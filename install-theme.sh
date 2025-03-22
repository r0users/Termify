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
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# Configure theme and colors
cat > ~/.zshrc <<EOL
# Termify Configuration
ZSH_THEME="robbyrussell"
plugins=(git zsh-autosuggestions)
source \$ZSH/oh-my-zsh.sh
EOL

# Set gray background (#333333)
mkdir -p ~/.termux
echo -e "background=#333333\nforeground=#FFFFFF" > ~/.termux/colors.properties
termux-reload-settings

# Clean exit
exit