profile() {
    config=$(cat $HOME/.config/bash/custom/config.bdb)
    echo "PROFILE=$1;OSICON=$(bdbFind OSICON $config)" > $HOME/.config/bash/custom/config.bdb
    bash
}
