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
./Install
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
# For exemple:
# if [[ $localFiles == "~/Development"* ]]; then
#   icon="<>"; localFiles="Dev"
# fi
```
