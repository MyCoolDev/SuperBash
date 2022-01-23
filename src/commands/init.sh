source $HOME/.config/bash/commands/dev.sh
source $HOME/.config/bash/commands/config.sh
source $HOME/.config/bash/commands/profile.sh

# Extra Commands
if [ -f /etc/arch-release ]; then
    source $HOME/.config/bash/commands/extra/package.sh         # for arch linux
fi
