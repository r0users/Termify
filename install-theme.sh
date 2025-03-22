#!/bin/bash
# Termux Auto-ZSH Setup
# Repo: https://github.com/r0users/Termify

# Suppress welcome message
touch ~/.hushlogin

# Core setup
pkg update -y && pkg upgrade -y
pkg install -y zsh
chsh -s zsh

# Install Oh My ZSH (silent mode)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Clean exit
exit