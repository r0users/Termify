# Termify 🖥️✨  
**One-Click Terminal Setup & Theme Manager**  

Transform your terminal into a powerful environment with pre-configured tools and aliases.  
Works on **Termux (Android)** and **Linux** (Ubuntu, Arch, Fedora).  

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
- 🛠️ **Automated Setup**  
  Installs Zsh, Oh-My-Zsh, speedtest tools, and neofetch.  
- 🔌 **Smart Configuration**  
  Auto-detects Termux/Linux environments.  
- ⚡ **Productivity Aliases**  
  `spd` - Run speed test | `neo` - Show system info | `edit` - Edit config.  
- 🔄 **Safe Rollback**  
  Use `restore-default` to revert changes (backups preserved).  

## ⚠️ Important Notes
1. Backup existing config manually before installation:
```bash
cp ~/.zshrc ~/.zshrc.backup
```
2. Auto-suggestions will be enabled after terminal restart
3. Rollback script will completely remove all theme components

## 🚀 Quick Start  

### Install Theme 
```bash  
# Install & Setup  

git clone https://github.com/r0users/Termify.git  
cd Termify

cd Termify
bash install-theme.sh

# Or

cd Termify
sudo ./install-theme.sh

# After setup completes:  

chsh -s zsh 

exit 

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

## ❓ FAQ
### "Why doesn't my shell change automatically?"

- Changing shells requires elevated privileges.
- Follow the post-install instructions carefully.

### "Package installation failed!"

- Ensure you have internet connection.
- For Linux, run with sudo.