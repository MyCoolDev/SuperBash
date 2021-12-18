# Solarized colorscheme
readonly BOLD="\\[$(tput bold)\\]"
readonly DIM="\\[$(tput dim)\\]"
readonly RESET="\\[$(tput sgr0)\\]"
readonly REVERSE="\\[$(tput rev)\\]"
readonly FG_BLACK_COLOR="\e[38;2;40;44;52m"
readonly BG_BLACK_COLOR="\e[48;2;40;44;52m"

# MAIN

readonly MAINCOLOR="97;175;239m" # Green: 152;195;121m || Blue: 97;175;239m || Purple: 198;120;221m || Red: 224;108;117m || You can add more...(RGB: R;G;B)
readonly MAINTEXTCOLOR="\e[38;2;$MAINCOLOR"
readonly MAINBACKCOLOR="\e[48;2;$MAINCOLOR"

# GIT

readonly GIT_RED_STATUS_BACK_COLOR="\e[48;2;224;108;117m"
readonly GIT_RED_STATUS_SYMBOLS_COLOR="\e[38;2;224;108;117m"
readonly GIT_BLUE_STATUS_BACK_COLOR="\e[48;2;97;175;239m"
readonly GIT_BLUE_STATUS_SYMBOLS_COLOR="\e[38;2;97;175;239m"
readonly GIT_STATUS_TEXT_COLOR=$FG_BLACK_COLOR

# COLORS_IN_USE

readonly EXIT_BG_GREEN="\\[$(tput setab 2)\\]"
readonly EXIT_BG_RED="\\[$(tput setab 1)\\]"
readonly EXIT_FG_GREEN="\\[$(tput setaf 2)\\]"
readonly EXIT_FG_RED="\\[$(tput setaf 1)\\]"
readonly BG_COLOR_01="\e[48;2;229;192;123m"
readonly FG_COLOR_01="\e[38;2;229;192;123m"
readonly BG_COLOR_02="\e[48;2;$MAINCOLOR"
readonly FG_COLOR_02="\e[38;2;$MAINCOLOR"
readonly BG_COLOR_03="\e[48;2;62;68;82m"
readonly FG_COLOR_03="\e[38;2;62;68;82m"
