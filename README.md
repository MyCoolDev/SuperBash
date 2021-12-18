# SuperBash
Super bash configuration.

# Installation
```bash
git clone "https://github.com/MyCoolDev/SuperBash.git"
cd SuperBash
if ! [ -d "$HOME/.config/bash/" ]; mkdir "$HOME/.config/bash/" && cp "src/" "$HOME/.config/\bash/"
```

# Configuration

### $HOME/.bashrc
```bash
source $HOME/.config/bash/init.bash
```

### $HOME/.config/bash/init.bash
```bash
source $HOME/.config/bash/profiles/...  # Select your bash profile. BY default green
```
