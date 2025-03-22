#!/bin/bash
# Termux Auto-ZSH Setup with Gray Theme
# Repo: https://github.com/r0users/Termify

# Suppress welcome message
touch ~/.hushlogin

# Core setup
pkg update -y && pkg upgrade -y
pkg install -y zsh git
chsh -s zsh

# Install Oh My ZSH (silent mode)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Configure .zshrc
cat > ~/.zshrc <<'EOL'
# Termify Configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh
PROMPT='%{$fg[green]%}%n@%m%{$reset_color%}:%{$fg[cyan]%}%~%{$reset_color%} ➤ '
EOL

# Set gray background (#333333)
mkdir -p ~/.termux
echo -e "background=#333333\nforeground=#FFFFFF" > ~/.termux/colors.properties
termux-reload-settings

# Apply changes
exec zsh