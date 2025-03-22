# Termify 🖥️✨  
**Terminal Setup & Theme Manager for Termux & Arch**  

Transform your terminal into a powerful environment with pre-configured tools and aliases.  
Optimized for **Termux (Android)** and **Arch Linux**.  

![GitHub License](https://img.shields.io/badge/License-MIT-blue)  
![Platform](https://img.shields.io/badge/Platform-Termux%20%7C%20Linux-green)  

<div align="center" style="display: flex; justify-content: space-around; align-items: center; flex-wrap: wrap; gap: 20px; margin: 30px 0;">
  <img src="assets/demo.gif" style="width: 50%; max-width: 250px; border-radius: 10px;" alt="Demo GIF">
</div>

## 🌟 Before & After  
<div style="display: flex; justify-content: center; gap: 15px; flex-wrap: wrap; margin: 20px 0;">
  <img src="assets/before.png" style="width: 40%; max-width: 350px; border: 1px solid #eee; border-radius: 8px;" alt="Before">
  <img src="assets/after.png" style="width: 40%; max-width: 350px; border: 1px solid #eee; border-radius: 8px;" alt="After">
</div>

## ✨ Features  
- 🛠️ **One-Click Setup**  
  Installs Zsh, plugins, and essential tools  
- 🎨 **Theme Management**  
  Pre-configured color schemes and prompt styles  
- ⚡ **Productivity Boost**  
  `spd` - Speed test | `neo` - System info | `edit` - Edit config  
- 🔄 **Safe Rollback**  
  Full restoration script included  

## 🙏 Credits  
+ Special thanks to these amazing open-source projects:  
+ [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh) - Community-driven Zsh framework  
+ [Zsh Autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) - Fish-like autocomplete  
+ [Termux](https://github.com/termux/termux-app) - Android terminal environment  

## ⚠️ Important Notes
1. Backup existing config manually before installation:
```bash
cp ~/.zshrc ~/.zshrc.backup
```
2. Auto-suggestions will be enabled after terminal restart
3. Rollback script will completely remove all theme components
4. Requires storage permission in Termux
5. Arch Linux users need sudo privileges

## 🚀 Quick Start  

### Termux
```bash  
git clone https://github.com/r0users/Termify.git
cd Termify
bash install-theme.sh

# Reopen Terminal
```
# Arch Linux
```bash
git clone https://github.com/r0users/Termify.git
cd Termify
sudo ./install-theme.sh

# Reopen Terminal
```
## Restore Defaults
```bash

cd Termify
bash restore-default.sh

# Or

cd Termify
sudo ./restore-default.sh

exit  

# Reopen Terminal
```

### ❓ FAQ
## "Why doesn't autosuggestion work?"

- Ensure you restarted terminal after installation
- Check plugin installation in ~/.zshrc

## "Arch Linux installation failed?"

- Ensure dependencies are installed
- sudo pacman -S git curl zsh