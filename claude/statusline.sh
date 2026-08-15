#!/usr/bin/env bash
# claudecode statusline reads JSON on stdin, prints a single line of conditional segments:
#   left:   <cwd> · <branch> · <ctx-bar> · <git-diff?>
#   right:  <model+thinking> · <cost> · <rate-limit?>

set -uo pipefail

INPUT="$(cat)"
HAVE_JQ=0
command -v jq >/dev/null 2>&1 && HAVE_JQ=1

j() {
    if (( HAVE_JQ )); then
        local out
        out="$(jq -r "$1 // empty" <<<"$INPUT" 2>/dev/null)"
        [[ -n "$out" ]] && { printf '%s' "$out"; return; }
    fi
    printf '%s' "${2:-}"
}

# -- palette (kanagawa-toned 256-color) --------------------------------------
RESET=$'\033[0m'; BOLD=$'\033[1m'; DIM=$'\033[38;5;242m'
C_CWD=$'\033[38;5;110m'    # crystal blue
C_MODEL=$'\033[38;5;209m'  # salmon
C_THINK=$'\033[38;5;179m'  # carp yellow
C_GIT=$'\033[38;5;176m'    # oni violet
C_ADD=$'\033[38;5;108m'    # spring green
C_MOD=$'\033[38;5;179m'    # carp yellow
C_DEL=$'\033[38;5;174m'    # autumn red
C_COST=$'\033[38;5;109m'   # wave aqua
OK=$'\033[38;5;108m'; WARN=$'\033[38;5;179m'; CRIT=$'\033[38;5;174m'

# glyphs (FiraCode Nerd Font): swap if any don't render
G_BRANCH=$''   #  git branch
G_THINK=$''    #  thinking / effort

CWD="$(j '.workspace.current_dir' "$PWD")"

# -- cwd ---------------------------------------------------------------------
shorten_path() {
    local p="$1"
    case "$p" in "$HOME"|"$HOME/"*) p="~${p#$HOME}" ;; esac
    local nc; nc=$(awk -F/ '{print NF-1}' <<<"$p")
    if (( nc > 4 )); then
        printf '%s/.../%s' "$(awk -F/ '{print $1"/"$2}' <<<"$p")" "$(awk -F/ '{print $(NF-1)"/"$NF}' <<<"$p")"
    else
        printf '%s' "$p"
    fi
}
CWD_SEG="${BOLD}${C_CWD}$(shorten_path "$CWD")${RESET}"

# -- model + thinking/effort -------------------------------------------------
MODEL="$(j '.model.display_name' "claude")"
THINKING="$(j '.thinking.enabled' "")"
EFFORT="$(j '.effort.level' "")"
MODEL_EXTRA=""
if [[ "$THINKING" == "true" ]]; then
    MODEL_EXTRA=" ${C_THINK}${G_THINK}${EFFORT:+ ${EFFORT}}${RESET}"
fi
MODEL_SEG="${BOLD}${C_MODEL}${MODEL}${RESET}${MODEL_EXTRA}"

# -- context window ----------------------------------------------------------
CTX_PCT="$(j '.context_window.used_percentage' "0")"
used="${CTX_PCT%.*}"; [[ -z "$used" ]] && used=0
(( used > 100 )) && used=100
W=10; parts='▏▎▍▌▋▊▉█'
e=$(( used * W * 8 / 100 )); full=$(( e / 8 )); frac=$(( e % 8 ))
if   (( used >= 80 )); then color="$CRIT"
elif (( used >= 60 )); then color="$WARN"
else                        color="$OK"; fi
bar=""; i=0
while (( i < full )); do bar+="█"; ((i++)); done
if (( frac > 0 && full < W )); then bar+="${parts:frac-1:1}"; ((i++)); fi
empty=""; while (( i < W )); do empty+="░"; ((i++)); done
CTX_SEG="${color}${bar}${DIM}${empty}${RESET} ${color}${used}%${RESET}"

# -- git ---------------------------------------------------------------------
GIT_SEG=""; DIFF_SEG=""
if cd "$CWD" 2>/dev/null && git rev-parse --git-dir >/dev/null 2>&1; then
    branch="$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)"
    dirty=""
    if ! git diff --quiet 2>/dev/null || ! git diff --cached --quiet 2>/dev/null; then dirty="${WARN}*${RESET}"; fi
    GIT_SEG="${C_GIT}${G_BRANCH}${RESET} ${branch}${dirty}"

    if status=$(git status --porcelain 2>/dev/null); then
        a=0; m=0; d=0
        while IFS= read -r line; do
            [[ -z "$line" ]] && continue
            case "${line:0:2}" in
                "A "*|"AM"|"AD"|"??"*) ((a++)) ;;
                " D"*|"D "*|"DD"*)     ((d++)) ;;
                " M"*|"M "*|"MM"*|"RM"*) ((m++)) ;;
            esac
        done <<<"$status"
        if (( a + m + d > 0 )); then
            DIFF_SEG=""
            (( a > 0 )) && DIFF_SEG+="${C_ADD}A:${a}${RESET} "
            (( m > 0 )) && DIFF_SEG+="${C_MOD}M:${m}${RESET} "
            (( d > 0 )) && DIFF_SEG+="${C_DEL}D:${d}${RESET}"
            DIFF_SEG="${DIM}Δ${RESET} ${DIFF_SEG% }"
        fi
    fi
fi

# -- cost --------------------------------------------------------------------
COST_USD="$(j '.cost.total_cost_usd' "")"
COST_SEG=""
[[ -n "$COST_USD" ]] && COST_SEG="${C_COST}\$$(printf '%.2f' "$COST_USD" 2>/dev/null || echo "$COST_USD")${RESET}"

# -- rate limit --------------------------------------------------------------
fmt_rate() {
    local label="$1" pct="$2"; local i="${pct%.*}"
    if [[ -z "$i" ]]; then printf '%s%s:—%s' "$DIM" "$label" "$RESET"; return; fi
    local c="$OK"; (( i >= 50 )) && c="$WARN"; (( i >= 80 )) && c="$CRIT"
    printf '%s%s:%s%%%s' "$c" "$label" "$i" "$RESET"
}
r5="$(fmt_rate "5h" "$(j '.rate_limits.five_hour.used_percentage' "")")"
r7="$(fmt_rate "7d" "$(j '.rate_limits.seven_day.used_percentage' "")")"
RATE_SEG="⏳ ${r5} ${r7}"

# -- alignment ---------------------------------------------------------------
sep="${DIM} · ${RESET}"
join_with_sep() {
    local s="$1"; shift; local out=""
    for p in "$@"; do
        [[ -z "$p" ]] && continue
        [[ -z "$out" ]] && out="$p" || out+="${s}${p}"
    done
    printf '%s' "$out"
}
visible_width() {
    local s; s=$(printf '%s' "$1" | sed -E $'s/\x1b\\[[0-9;]*[a-zA-Z]//g')
    python3 -c "
import sys, unicodedata
s = sys.argv[1]; w = 0
for ch in s:
    if unicodedata.east_asian_width(ch) in ('F','W') or unicodedata.category(ch) == 'So':
        w += 2
    else:
        w += 1
print(w)
" "$s" 2>/dev/null || printf '%s' "${#s}"
}

LEFT="$(join_with_sep "$sep" "$CWD_SEG" "$GIT_SEG" "$CTX_SEG" "$DIFF_SEG")"
RIGHT="$(join_with_sep "$sep" "$MODEL_SEG" "$COST_SEG" "$RATE_SEG")"

COLS="${COLUMNS:-}"
if [[ -z "$COLS" ]]; then
    for tty_path in /dev/tty "${_P9K_TTY:-}"; do
        [[ -z "$tty_path" || ! -e "$tty_path" ]] && continue
        COLS="$(stty size 2>/dev/null < "$tty_path" | awk '{print $2}')"; [[ -n "$COLS" ]] && break
    done
fi
[[ -z "$COLS" ]] && COLS="$(tput cols 2>/dev/null)"
[[ -z "$COLS" ]] && COLS="$(stty size 2>/dev/null | awk '{print $2}')"
[[ -z "$COLS" ]] && COLS=200

lw="$(visible_width "$LEFT")"; rw="$(visible_width "$RIGHT")"
gap=$(( COLS - lw - rw )); (( gap < 2 )) && gap=2
printf '%s%*s%s\n' "$LEFT" "$gap" "" "$RIGHT"
