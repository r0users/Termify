# Termify 🖥️✨  
**One-Click Terminal Setup & Theme Manager**  

Transform your terminal into a powerful environment with pre-configured tools and aliases.  
Works on **Termux (Android)** and **Linux** (Ubuntu, Arch, Fedora).  

![GitHub License](https://img.shields.io/badge/License-MIT-blue)  
![Platform](https://img.shields.io/badge/Platform-Termux%20%7C%20Linux-green)  

<div align="center">
  <img src="https://i.imgur.com/your-demo-image.png" width="600" alt="Termify Demo">  
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

## 🚀 Quick Start  

### Termux (Android)  
```bash  
# Install & Setup  
git clone https://github.com/r0users/Termify.git  
cd Termify  
bash install-theme  

# After setup completes:  
chsh -s zsh  
exit  
# Reopen Termux 
```
### Arch,Others (Linux)
```bash
# Install & Setup  
git clone https://github.com/r0users/Termify.git  
cd Termify  
sudo ./install-theme  

# After setup completes:  
chsh -s zsh  
exit  
# Reopen Termux 
```
🛠️ Customization
Adding Themes (Advanced)

    Place your theme files in themes/ directory.

    Modify install-theme to apply your theme.

## Restore Defaults
```bash
# (Android)
cd Termify
bash restore-default.sh

# (Linux)
cd Termify
sudo ./restore-default.sh
```

## ❓ FAQ
### "Why doesn't my shell change automatically?"

- Changing shells requires elevated privileges.
- Follow the post-install instructions carefully.

### "Package installation failed!"

- Ensure you have internet connection.
- For Linux, run with sudo.