# ─────────────────────────────────────────────────────────────
# ~/.zshrc — thin orchestrator. Real config lives in ~/.config/zsh/*.
# Order: instant-prompt → path → init → oh-my-zsh → func → alias → local → p10k
# ─────────────────────────────────────────────────────────────

# ── Powerlevel10k instant prompt (keep near the very top) ────
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH_CFG="$HOME/.config/zsh"

# ── PATH + tool init (before OMZ so plugins find binaries) ───
[ -f "$ZSH_CFG/path.zsh" ] && source "$ZSH_CFG/path.zsh"
[ -f "$ZSH_CFG/init.zsh" ] && source "$ZSH_CFG/init.zsh"

# ── oh-my-zsh ────────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(
  git
  aws
  brew
  colored-man-pages
  colorize
  copybuffer
  copyfile
  copypath
  golang
  helm
  history
  kubectl
  macos
  pip
  python
  sudo
  vi-mode
  web-search
  fzf-tab
  zsh-bat
  zsh-autosuggestions
  fast-syntax-highlighting
)
source "$ZSH/oh-my-zsh.sh"

# ── functions + aliases ──────────────────────────────────────
[ -f "$ZSH_CFG/alias.zsh" ] && source "$ZSH_CFG/alias.zsh"

# ── per-machine overrides (gitignored; absent by default) ────
[ -f "$ZSH_CFG/local.zsh" ] && source "$ZSH_CFG/local.zsh"

# ── p10k prompt config (keep last) ───────────────────────────
[ -f ~/.p10k.zsh ] && source ~/.p10k.zsh
