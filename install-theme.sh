#!/bin/bash
# SPDX-License-Identifier: MIT
# Copyright (c) 2024 realmeuser
# Repository: https://github.com/realmeuser/universal-terminal-theme
#
# Description:
#   - Backs up and completely removes previous zsh/Oh-My-Zsh and Termux settings.
#   - Installs required packages (zsh, git, curl, speedtest-go, neofetch) and sets up
#     Oh-My-Zsh with default settings.
#   - For Termux, it restores default color settings and disables the welcome banner.
#   - Displays colored warning/info messages to help you understand what is happening.
#   - At the end, it waits 5 seconds and then attempts to close the terminal.
#
# IMPORTANT: This will remove your current zsh configuration after backing it up.
# Make sure to review your backup (~/.zshrc.backup.TIMESTAMP) if you need your custom settings.
#
# Usage:
#   bash apply.sh
#   (Your terminal will close automatically in 5 seconds after applying changes.)
# =================================================================

# Color definitions for warnings/info
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
NC="\e[0m"  # No Color

# Determine HOME directory (works for root or regular user)
HOME_DIR="$HOME"

echo -e "${YELLOW}*** Universal Terminal Theme Installer ***${NC}"
echo -e "${YELLOW}This script will back up your current configuration and install the default theme settings.${NC}"

# Function to totally remove previous configuration
remove_all_config() {
    echo -e "${YELLOW}Starting total removal of previous configurations...${NC}"
    
    # Backup and remove .zshrc
    if [ -f "$HOME_DIR/.zshrc" ]; then
        backup_file="$HOME_DIR/.zshrc.backup.$(date +%Y%m%d%H%M%S)"
        cp "$HOME_DIR/.zshrc" "$backup_file"
        echo -e "${GREEN}Backed up your .zshrc to $backup_file${NC}"
        rm -f "$HOME_DIR/.zshrc"
        echo -e "${GREEN}Removed existing .zshrc${NC}"
    fi

    # Remove entire oh-my-zsh directory if it exists
    if [ -d "$HOME_DIR/.oh-my-zsh" ]; then
        rm -rf "$HOME_DIR/.oh-my-zsh"
        echo -e "${GREEN}Removed existing .oh-my-zsh directory${NC}"
    fi

    # Remove Termux configuration folder (if exists)
    if [ -d "$HOME_DIR/.termux" ]; then
        rm -rf "$HOME_DIR/.termux"
        echo -e "${GREEN}Removed existing .termux folder${NC}"
    fi

    # Remove .hushlogin to reset Termux banner configuration
    if [ -f "$HOME_DIR/.hushlogin" ]; then
        rm -f "$HOME_DIR/.hushlogin"
        echo -e "${GREEN}Removed .hushlogin${NC}"
    fi

    echo -e "${GREEN}Total removal complete.${NC}"
}

# Function to append new configuration to ~/.zshrc
append_config() {
cat << 'EOF' >> "$HOME_DIR/.zshrc"

# BEGIN UNIVERSAL THEME
# Speedtest aliases
if command -v speedtest-go >/dev/null 2>&1; then
    alias spd='speedtest-go'  
fi

if command -v speedtest-cli >/dev/null 2>&1; then
    alias speedtest='speedtest-cli'  
fi

alias neo='neofetch'
alias edit='nano $HOME/.zshrc'

if [ -f "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
  source "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# (No custom prompt override; using default Oh-My-Zsh settings)
# END UNIVERSAL THEME
EOF
}

# Function for Termux (Android)
install_termux() {
    echo -e "${YELLOW}Detected Termux environment...${NC}"
    pkg update && pkg upgrade -y
    pkg install -y zsh git curl speedtest-go neofetch

    echo -e "${YELLOW}Installing Oh-My-Zsh with default settings...${NC}"
    export RUNZSH=no
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    echo -e "${YELLOW}Installing zsh-autosuggestions plugin...${NC}"
    git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME_DIR/.oh-my-zsh/custom/plugins/zsh-autosuggestions"

    echo -e "${YELLOW}Restoring Termux default color settings...${NC}"
    mkdir -p "$HOME_DIR/.termux"
    cat << 'EOF' > "$HOME_DIR/.termux/colors.properties"
background = #1E1E1E
foreground = #C7C7C7
cursor = #C7C7C7
color0 = #000000
color1 = #C62828
color2 = #2E7D32
color3 = #FF8F00
color4 = #1565C0
color5 = #6A1B9A
color6 = #00838F
color7 = #C7C7C7
color8 = #4E342E
color9 = #EF5350
color10 = #66BB6A
color11 = #FFCA28
color12 = #42A5F5
color13 = #AB47BC
color14 = #26C6DA
color15 = #F5F5F5
EOF

    echo -e "${YELLOW}Reloading Termux settings...${NC}"
    termux-reload-settings
    touch "$HOME_DIR/.hushlogin"
    append_config
    chsh -s zsh
    echo -e "${GREEN}Termux configuration complete!${NC}"
}

# Function for Linux distros
install_linux() {
    echo -e "${YELLOW}Detected Linux distro environment...${NC}"
    if command -v apt-get >/dev/null; then
        sudo apt-get update -y && sudo apt-get upgrade -y
        sudo apt-get install -y zsh git curl speedtest-go neofetch
    elif command -v pacman >/dev/null; then
        sudo pacman -Syu --noconfirm
        sudo pacman -S --noconfirm zsh git curl speedtest-cli neofetch
    elif command -v dnf >/dev/null; then
        sudo dnf upgrade --refresh -y
        sudo dnf install -y zsh git curl python3-speedtest-cli neofetch
    else
        echo -e "${RED}Unsupported package manager. Please install packages manually.${NC}"
        exit 1
    fi

    echo -e "${YELLOW}Installing Oh-My-Zsh with default settings...${NC}"
    export RUNZSH=no
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    echo -e "${YELLOW}Installing zsh-autosuggestions plugin...${NC}"
    git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME_DIR/.oh-my-zsh/custom/plugins/zsh-autosuggestions"

    append_config
    chsh -s "$(which zsh)"
    echo -e "${GREEN}Linux configuration complete!${NC}"
}

# Main: Remove previous configuration and detect environment
remove_all_config

if [ -d "/data/data/com.termux/files/usr/bin" ]; then
    install_termux
elif [ -f /etc/os-release ]; then
    install_linux
else
    echo -e "${RED}Unsupported environment. Exiting.${NC}"
    exit 1
fi

echo -e "${GREEN}----------------------------------------------------${NC}"
echo -e "${GREEN}All settings are complete! Your terminal will close in 5 seconds to apply changes.${NC}"
sleep 3

if [ -d "/data/data/com.termux/files/usr/bin" ]; then
    exec kill -9 $PPID
else
    kill -9 $PPID
fi