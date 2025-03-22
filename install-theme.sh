Copy

#!/bin/bash
# SPDX-License-Identifier: MIT
# Copyright (c) 2025 r0users
# Repository: https://github.com/r0users/Termify

# ---------------------- Animasi Kucing ----------------------
boot_animation() {
  printf "\033[1;36m"
  cat << "EOF"
 /\_/\  
( o.o ) 
 > ^ <
EOF
  printf "\033[0m"
  sleep 5
}

# ---------------------- Konfigurasi Warna ----------------------
BOLD="\033[1m"
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
NC="\033[0m"

HOME_DIR="$HOME"

# ---------------------- Fungsi Utama ----------------------
remove_config() {
  echo -e "${YELLOW}🔄 Membersihkan konfigurasi lama...${NC}"
  
  # Hapus file/folder terkait theme
  targets=(
    "$HOME_DIR/.oh-my-zsh"
    "$HOME_DIR/.termux"
    "$HOME_DIR/.hushlogin"
    "$HOME_DIR/.zcompdump*"
  )
  
  for target in "${targets[@]}"; do
    [ -e "$target" ] && rm -rfv "$target"
  done
}

install_deps() {
  echo -e "${BLUE}📦 Menginstall dependensi untuk ${OS_NAME}...${NC}"
  
  if [ "$OS_TYPE" = "termux" ]; then
    # Termux packages
    pkg update -y && pkg upgrade -y
    pkg install -y zsh git curl speedtest-go neofetch
    
  elif [ "$OS_TYPE" = "linux" ]; then
    # Linux packages
    if command -v apt-get >/dev/null; then
      sudo apt-get update -y
      sudo apt-get install -y zsh git curl speedtest-cli neofetch
      
    elif command -v pacman >/dev/null; then
      sudo pacman -Syu --noconfirm zsh git curl speedtest-cli neofetch
      
    elif command -v dnf >/dev/null; then
      sudo dnf install -y zsh git curl speedtest-cli neofetch
    fi
  fi || {
    echo -e "${RED}❌ Gagal menginstall paket!${NC}"
    exit 1
  }
}

setup_omz() {
  echo -e "${YELLOW}⚙️ Menyiapkan Oh-My-Zsh...${NC}"
  
  # Install tanpa mengubah shell
  RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  
  # Plugin zsh-autosuggestions
  if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions \
      "$ZSH_CUSTOM/plugins/zsh-autosuggestions" || {
        echo -e "${RED}❌ Gagal install plugin!${NC}"
        exit 1
      }
  fi
}

setup_termux() {
  echo -e "${BLUE}📱 Konfigurasi khusus Termux...${NC}"
  
  # Warna default Termux
  mkdir -p "$HOME/.termux"
  cat > "$HOME/.termux/colors.properties" << EOF
background=#1E1E1E
foreground=#C7C7C7
EOF
  
  termux-reload-settings
}

# ---------------------- Eksekusi Utama ----------------------
boot_animation

# Deteksi environment
if [ -d "/data/data/com.termux/files/usr" ]; then
  OS_TYPE="termux"
  OS_NAME="Termux"
  ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
else
  OS_TYPE="linux"
  OS_NAME="$(grep PRETTY_NAME /etc/os-release | cut -d'"' -f2)"
  ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
fi

remove_config
install_deps
setup_omz

[ "$OS_TYPE" = "termux" ] && setup_termux

echo -e "${GREEN}✅ Installasi berhasil!${NC}"
echo -e "${BOLD}Langkah selanjutnya:"
echo -e "1. Edit theme manual: ${BLUE}nano ~/.zshrc${NC}"
echo -e "2. Aktifkan zsh: ${BLUE}chsh -s zsh${NC}"
echo -e "3. Restart terminal!"
