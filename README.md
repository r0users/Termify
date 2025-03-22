# Termify 🖥️✨  
**One-Click Terminal Setup & Theme Manager**  

Transform your terminal into a powerful environment with pre-configured tools and aliases.  
Works on **Termux (Android)** and **Linux** (Ubuntu, Arch, Fedora).  

![GitHub License](https://img.shields.io/badge/License-MIT-blue)  
![Platform](https://img.shields.io/badge/Platform-Termux%20%7C%20Linux-green)  

<!-- Logo utama dengan ukuran responsive -->
<div align="center">
  <img src="assets/logo.png" style="width: 80%; max-width: 600px; margin: 20px 0;" alt="Termify Logo">
</div>

## 🌟 Before & After  
| Sebelum Install | Sesudah Install |  
|-----------------|------------------|  
| ![Before](assets/before.png) | ![After](assets/after.png) |  

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

### Install Theme 
```bash  
# Install & Setup  

git clone https://github.com/r0users/Termify.git  
cd Termify

bash install-theme

# Or

sudo ./install-theme 

# After setup completes:  

chsh -s zsh 

exit 

# Reopen Terminal
```

🛠️ Customization
Adding Themes (Advanced)

- Place your theme files in Termify/ directory.
- Modify install-theme.sh to apply your theme.

## Restore Defaults
```bash

cd Termify

bash restore-default.sh

# Or

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