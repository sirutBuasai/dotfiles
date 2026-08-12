# v2 Rebuild — Deferred Checklist

Things we **will** need but are not building yet. (Optional/maybe items — e.g. a tiling WM —
are out of scope here; everything below is a commitment, just later.)

## L6 — Setup / bootstrap script (chezmoi + wrapper, or Rust binary)

One command to provision a machine. Must **install major dependencies**, not just drop configs.

- [ ] Package manager bootstrap (Homebrew on macOS / apt on Linux)
- [ ] `uv` (Python runtime + venv manager)
- [ ] Fonts (FiraCode Nerd Font + nerd symbols)
- [ ] `zsh` + oh-my-zsh + powerlevel10k
- [ ] `tmux` + TPM + plugins
- [ ] `neovim`
- [ ] `ghostty` (macOS only)
- [ ] `chezmoi` self-install inside the one-liner
- [ ] `Brewfile` (`brew bundle`) as the macOS package source of truth
- [ ] `bootstrap.sh` (full — P1 mac↔mac) and `bootstrap-minimal.sh` (P2 primitives→EC2)

## Cross-machine / remote (P2)

- [ ] Push `xterm-ghostty` terminfo to EC2 (or `SetEnv TERM=xterm-256color`)
- [ ] Minimal profile: `.vimrc` + `.gitconfig` + `.zshrc` only, skip full stack
- [ ] Secrets via chezmoi encryption — public repo, no plaintext keys

## Conventions to honor as we build each layer

- [ ] tmux resize on `prefix+HJKL`; keep `Alt/Option` free for a future WM
- [ ] smart-splits tmux backend (do NOT lazy-load)

## Later layers (in the plan; noted here so nothing drops)

- [ ] Claude Code config (settings / keybindings / commands / hooks) mirroring nvim mnemonics
- [ ] `coder/claudecode.nvim` bridge
- [ ] `.vimrc` full-keybind stone-age fallback
