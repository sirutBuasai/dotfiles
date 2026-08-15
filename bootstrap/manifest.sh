#!/usr/bin/env bash
# bootstrap/manifest.sh — the single source of truth: which repo file goes where.
# deploy.sh reads it forward (repo → $HOME, copy); sync.sh reads it back ($HOME → repo, rsync).
#
# One entry per line:  <src (repo-relative)> | <dst (HOME-relative)> | <flags,csv>
# Flags:
#   all | mac | linux   platform gate (default: all)
#   file | dir          entry type (default: file)
#   minimal             part of the primitive/EC2 set (deployed with --minimal)
#   exec                chmod +x after copy (dir → every *.sh inside; file → the file)
#   perms600            chmod 600 the copied file
#   dirperms700         chmod 700 the destination's parent dir (e.g. ~/.ssh)
#   merge               jq-merge with ~/.claude/settings.local.json instead of a plain copy
#   nosync              NEVER rsync back to the repo (public-safety: keeps secrets out)
#   exclude=NAME        rsync/cp exclude pattern (dirs only)
MANIFEST=(
  "tmux/.tmux.conf|.tmux.conf|all,file"
  "ghostty/config.ghostty|.config/ghostty/config.ghostty|mac,file"
  "nvim|.config/nvim|all,dir,exclude=autoload"
  "zsh/.zshrc|.zshrc|all,file"
  "zsh/.p10k.zsh|.p10k.zsh|all,file"
  "zsh/alias.zsh|.config/zsh/alias.zsh|all,file"
  "zsh/init.zsh|.config/zsh/init.zsh|all,file"
  "zsh/path.zsh|.config/zsh/path.zsh|all,file"
  "bash/.bashrc|.bashrc|all,file,minimal"
  "bash/.bash_profile|.bash_profile|all,file,minimal"
  "sesh/sesh.toml|.config/sesh/sesh.toml|all,file"
  "git/.gitconfig|.gitconfig|all,file,minimal"
  "vim/.vimrc|.vimrc|all,file,minimal"
  "ssh/config|.ssh/config|all,file,minimal,perms600,dirperms700"
  "claude/CLAUDE.md|.claude/CLAUDE.md|all,file"
  "claude/commands|.claude/commands|all,dir"
  "claude/hooks|.claude/hooks|all,dir,exec"
  "claude/statusline.sh|.claude/statusline.sh|all,file,exec"
  "claude/settings.json|.claude/settings.json|all,file,merge,nosync"
)

# ── flag helpers ──
has_flag() { case ",$1," in *",$2,"*) return 0 ;; esac; return 1; }   # has_flag "$flags" file
flag_value() {                                                        # flag_value "$flags" exclude
  local x; IFS=, read -ra _f <<< "$1"
  for x in "${_f[@]}"; do case "$x" in "$2="*) printf '%s' "${x#*=}"; return ;; esac; done
}
