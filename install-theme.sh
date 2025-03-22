#!/bin/bash
# SPDX-License-Identifier: MIT
# Copyright (c) 2025 r0users
# Repository: https://github.com/r0users/Termify

# ---------------------- Animated Cat ----------------------
show_cat() {
  frames=(
    "  ╱▔▔▔▔▔▔▔╲ 
   ▕  ฅ^•ﻌ•^ฅ  ▏
    ╲     ▼    ╱
     ╲        ╱
      ▔▔▔▔▔▔▔▔"
    "  ╱▔▔▔▔▔▔▔╲ 
   ▕  ฅ¬•ﻌ•¬ฅ  ▏
    ╲     ▼    ╱
     ╲   ◡    ╱
      ▔▔▔▔▔▔▔▔"
  )
  for i in {1..5}; do
    clear
    echo -e "\033[1;36m${frames[$((i % 2))]}\033[0m"
    sleep 0.5
  done
}

# ---------------------- Global Config ----------------------
BOLD="\033[1m"
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
NC="\033[0m"

HOME_DIR="$HOME"
ZSH_CUSTOM=""

# ---------------------- Core Functions ----------------------
setup_termux() {
  echo -e "${BLUE}Configuring Termux...${NC}"
  
  # Suppress welcome message
  touch "$HOME/.hushlogin"
  
  # Color schemes
  schemes=(
    "Dracula:#1E1E1E:#C7C7C7"
    "Nord:#2E3440:#D8DEE9"
    "Solarized:#002B36:#839496"
  )
  
  selected=$(printf "%s\n" "${schemes[@]}" | fzf --prompt="Select color scheme: " | cut -d: -f2-)
  IFS=':' read -r bg fg <<< "$selected"
  
  mkdir -p "$HOME/.termux"
  echo -e "background=${bg}\nforeground=${fg}" > "$HOME/.termux/colors.properties"
  termux-reload-settings
}

setup_prompt() {
  echo -e "${YELLOW}Choose your ZSH prompt style:${NC}"
  prompts=(
    "robbyrussell (Default OMZ)"
    "agnoster (Powerline style)"
    "bira (Compact)"
    "fishy (Colorful)"
  )
  
  selected=$(printf "%s\n" "${prompts[@]}" | fzf --height=30% --reverse --prompt="Select prompt: ")
  theme=$(echo "$selected" | awk '{print $1}')
  
  sed -i "s/ZSH_THEME=.*/ZSH_THEME=\"${theme}\"/" "$HOME/.zshrc"
}

install_deps() {
  # Common packages
  packages=(
    zsh git curl neofetch
    speedtest-go  # Termux
    speedtest-cli # Linux
  )
  
  echo -e "${BLUE}Installing dependencies...${NC}"
  if [ -d "/data/data/com.termux/files/usr" ]; then
    pkg update -y && pkg upgrade -y
    pkg install -y "${packages[@]}"
  else
    sudo apt update -y && sudo apt install -y "${packages[@]}"   # Ubuntu/Debian
    # sudo pacman/dnf commands here
  fi || {
    echo -e "${RED}Dependency installation failed!${NC}"
    exit 1
  }
}

configure_zsh() {
  echo -e "${YELLOW}Configuring ZSH...${NC}"
  
  # Install Oh-My-Zsh
  RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  
  # Auto-suggestions plugin
  git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"
  
  # Write config
  cat > "$HOME/.zshrc" << EOF
# Termify Configuration
export ZSH_CUSTOM="${ZSH_CUSTOM}"
plugins=(git zsh-autosuggestions)

# Aliases
alias speed='speedtest-go || speedtest-cli'
alias neo='neofetch'
alias edit='nano ~/.zshrc'

# Initialize OMZ
source \$ZSH/oh-my-zsh.sh
EOF

  setup_prompt
}

# ---------------------- Main Execution ----------------------
show_cat
echo -e "${BOLD}Termify Terminal Setup${NC}\n"

# Environment detection
if [ -d "/data/data/com.termux/files/usr" ]; then
  ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
  setup_termux
else
  ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
fi

install_deps
configure_zsh

echo -e "\n${GREEN}Setup complete!${NC}"
echo -e "Restart terminal or run: ${BOLD}exec zsh${NC}"
