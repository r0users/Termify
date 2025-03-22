#!/bin/bash
# Arch Linux ZSH Auto-Setup
# Repo: https://github.com/r0users/Archify

# Core setup
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm zsh git curl

# Set ZSH as default
sudo chsh -s /usr/bin/zsh $USER

# Install Oh My ZSH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Configure .zshrc
cat > ~/.zshrc <<'EOL'
# Archify Configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"
plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh
PROMPT='%F{blue}%n@%m%f:%F{cyan}%~%f ➤ '
EOL

# Apply changes
exec zsh