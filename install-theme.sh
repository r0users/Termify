#!/bin/bash
# SPDX-License-Identifier: MIT
# Copyright (c) 2025 r0users
# Repository: https://github.com/r0users/Termify

# ---------------------- Global Config ----------------------
HOME_DIR="$HOME"
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

# ---------------------- Core Functions ----------------------
setup_termux() {
  # Configure Termux default colors (Dracula)
  mkdir -p "$HOME/.termux"
  echo -e "background=#1E1E1E\nforeground=#C7C7C7" > "$HOME/.termux/colors.properties"
  termux-reload-settings
  touch "$HOME/.hushlogin"
}

install_deps() {
  # Common packages
  if [ -d "/data/data/com.termux/files/usr" ]; then
    pkg update -y && pkg upgrade -y
    pkg install -y zsh git curl neofetch speedtest-go
  else
    sudo apt update -y
    sudo apt install -y zsh git curl neofetch speedtest-cli
  fi
}

configure_zsh() {
  # Install Oh-My-Zsh with default settings
  RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  
  # Install plugins
  git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"

  # Write default configuration
  cat > "$HOME/.zshrc" << EOF
# Termify Configuration
export ZSH_CUSTOM="${ZSH_CUSTOM}"
export ZSH_THEME="robbyrussell"
plugins=(git zsh-autosuggestions)

# Aliases
alias speed='speedtest-go || speedtest-cli'
alias neo='neofetch'

# Initialize OMZ
source \$ZSH/oh-my-zsh.sh
EOF
}

# ---------------------- Main Execution ----------------------
# Detect environment
if [ -d "/data/data/com.termux/files/usr" ]; then
  setup_termux
fi

# Execute setup
install_deps
configure_zsh

echo -e "\nSetup selesai! Restart terminal atau ketik: exec zsh"
