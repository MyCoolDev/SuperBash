init() {
  source $HOME/.config/bash/custom/path.bash
  source $HOME/.config/bash/custom/colors.bash
  source $HOME/.config/bash/commands/init.bash
  source $HOME/.config/bash/lib/json.bash
  config=$(cat $HOME/.config/bash/custom/config.bdb)
  profile=$(bdbFind PROFILE $config)
  source $HOME/.config/bash/profiles/$profile.bash
}

init
unset init
