# SuperBash
Super bash configuration.

## Preview
![Default Image](https://i.imgur.com/HHZgbAS.png)
![Csharp Image](https://i.imgur.com/1FoqtVc.png)
##### Easy way to make custom path and custom colors
![Path](https://i.imgur.com/xc16JsO.png)
![Color](https://i.imgur.com/LR3rZfa.png)

## Installation
```bash
git clone "https://github.com/MyCoolDev/SuperBash.git"
cd SuperBash
if ! [ -d "$HOME/.config/bash/" ]; then mkdir "$HOME/.config/bash/" fi; && cp "src/*" "$HOME/.config/\bash/";
```

## Configuration

### ~/.bashrc
```bash
source $HOME/.config/bash/init.bash
```

### ~/.config/bash/init.bash
```bash
source $HOME/.config/bash/profiles/...  # Select your bash profile. By default green
```

### ~/.config/bash/custom/path.bash
```bash
edit_path() {
    localFiles=$1
    icon=$2
    # For exemple:
    # if [[ $localFiles == "~/Development"* ]]; then
    #   icon="<>"; localFiles="Dev"
    # fi

    echo "$localFiles $icon"
    unset edit_path
}
```
