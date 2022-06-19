source $HOME/.config/bash/commands/dev.sh
source $HOME/.config/bash/commands/config.sh
source $HOME/.config/bash/commands/profile.sh
source $HOME/.config/bash/commands/extract.sh

# Extra Commands
if [ -f /etc/arch-release ]; then
    source $HOME/.config/bash/commands/extra/package.sh         # for arch linux
fi
