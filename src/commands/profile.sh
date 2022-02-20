profile() {
    if ! [ -f "$HOME/.config/bash/profiles/$1.bash" ]; then
        echo "Can't find profile!"
        return
    fi
    config=$(cat $HOME/.config/bash/custom/config.bdb)
    echo "PROFILE=$1;OSICON=$(bdbFind OSICON $config)" > $HOME/.config/bash/custom/config.bdb
    bash
}
