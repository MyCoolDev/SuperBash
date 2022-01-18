init() {
  source $HOME/.config/bash/custom/colors.sh
  source $HOME/.config/bash/commands/init.sh
  source $HOME/.config/bash/lib/bdb.sh
  config=$(cat $HOME/.config/bash/custom/config.bdb)
  profile=$(bdbFind PROFILE $config)
  source $HOME/.config/bash/profiles/$profile.sh
}

init
unset init
