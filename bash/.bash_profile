# ═══════════════════════════════════════════════════════════════════
# ~/.bash_profile — read by LOGIN shells (e.g. `ssh ec2` opens one).
# Bash reads .bash_profile for login shells and .bashrc for interactive
# non-login shells, but never both — so source .bashrc here to unify them.
# ═══════════════════════════════════════════════════════════════════
[ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
