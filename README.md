# dotfiles
personal repo for .files and general macbook migration

### needed programs
- Google Chrome https://www.google.com/chrome/
- Slack https://slack.com/downloads/mac
- Spotify https://www.spotify.com/us/download/other/
- Discord https://discord.com/download
- LINE https://apps.apple.com/us/app/line/id539883307?mt=12
- Todoist https://todoist.com/downloads
- Tor https://www.torproject.org/download/
- Zoom https://zoom.us/download
- Notion https://www.notion.so/desktop

### terminal and coding configurations
- Mac Setup https://sourabhbajaj.com/mac-setup/

### setup guide
- install xcode cli tools `xcode-select --install`
- install homebrew `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"`
  - on apple M1 chip `echo 'export PATH=/opt/homebrew/bin:$PATH' >> .$(basename $SHELL)rc && source .$(basename $SHELL)rc`
  - on intel chip `echo 'export PATH=/usr/local/bin:$PATH' >> .$(basename $SHELL)rc && source .$(basename $SHELL)rc`
  - check if brew is working using `brew doctor`
- install iterm2 `brew install --cask iterm2`
  - install oh my zsh `sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
  - install powerlebel10k `git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k`
- install git `brew install git`
- install tree `brew install tree`
- install fzf `brew install fzf`
- install ripgrep `brew install ripgrep`
- install neovim `brew install neovim`
  - add python3 support `python3 -m pip install pynvim`
