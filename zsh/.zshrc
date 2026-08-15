# -- powerlevel10k --------------------------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH_CFG="$HOME/.config/zsh"

# -- PATH + init ----------------------------------------------
[ -f "$ZSH_CFG/path.zsh" ] && source "$ZSH_CFG/path.zsh"
[ -f "$ZSH_CFG/init.zsh" ] && source "$ZSH_CFG/init.zsh"

# -- oh-my-zsh ------------------------------------------------
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

# -- functions + aliases --------------------------------------
[ -f "$ZSH_CFG/alias.zsh" ] && source "$ZSH_CFG/alias.zsh"

# -- per-machine overrides ------------------------------------
[ -f "$ZSH_CFG/local.zsh" ] && source "$ZSH_CFG/local.zsh"

# ── p10k prompt config ---------------------------------------
[ -f ~/.p10k.zsh ] && source ~/.p10k.zsh
