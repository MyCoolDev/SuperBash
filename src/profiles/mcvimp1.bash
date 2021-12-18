# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Solarized colorscheme
readonly BOLD="\\[$(tput bold)\\]"
readonly DIM="\\[$(tput dim)\\]"
readonly RESET="\\[$(tput sgr0)\\]"
readonly REVERSE="\\[$(tput rev)\\]"
readonly FG_BLACK_COLOR="\e[38;2;40;44;52m"
readonly BG_BLACK_COLOR="\e[48;2;40;44;52m"

# MAIN

readonly MAINCOLOR="152;195;121m" # Green: 152;195;121m || Blue: 97;175;239m || Purple: 198;120;221m || Red: 224;108;117m || You can add more...(RGB: R;G;B)
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

# Unicode symbols

readonly GIT_BRANCH_CHANGED_SYMBOL=''
readonly GIT_NEED_PULL_SYMBOL=''
readonly GIT_NEED_PUSH_SYMBOL=''

# Functions

__git_info() {
    if ! [ -d .git ]; then
        echo ""
        return 0;
    fi

    local aheadN
    local behindN 
    local branch ocal marks
    local status

    # get current branch name or short SHA1 hash for detached head
    branch="$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --always 2>/dev/null)"
    if ! [ -n "$branch" ]; then # git branch not found
        echo ""
        return 0;
    fi

    # how many commits local branch is ahead/behind of remote?
    stats="$(git status --porcelain --branch | grep '^##' | grep -o '\[.\+\]$')"
    aheadN="$(echo "$stats" | grep -o 'ahead \d\+' | grep -o '\d\+')"
    behindN="$(echo "$stats" | grep -o 'behind \d\+' | grep -o '\d\+')"
    [ -n "$aheadN" ] && marks+=" $GIT_NEED_PUSH_SYMBOL$aheadN"
    [ -n "$behindN" ] && marks+=" $GIT_NEED_PULL_SYMBOL$behindN"

    # print the git branch segment without a trailing newline
    # branch is modified?
    text=" $branch$marks "
    if [ -n "$(git status --porcelain)" ]; then
        echo "$GIT_RED_STATUS_SYMBOLS_COLOR\e[0m$GIT_RED_STATUS_BACK_COLOR$GIT_STATUS_TEXT_COLOR$BOLD $branch$marks $FG_COLOR_03$RESET" # RED STATUS
        return ${#text}
    else
        echo "$GIT_BLUE_STATUS_SYMBOLS_COLOR\e[0m$GIT_BLUE_STATUS_BACK_COLOR$GIT_STATUS_TEXT_COLOR$BOLD $branch$marks $FG_COLOR_03$RESET" # BLUE STATUS
        return ${#text}
    fi
}         
    
bash_prompt() {
    # Check the exit code of the previous command and display different
    # colors in the prompt accordingly.
    if [ "$?" -eq 0 ]; then
        local BG_EXIT="$BG_GREEN"
        local FG_EXIT="$FG_GREEN"
    else
        local BG_EXIT="$BG_RED"
        local FG_EXIT="$FG_RED"
    fi
     
    str="$(stty size)"
    read -ra str <<< "$str"

    localFiles="$(pwd)"
    icon=""
    localFiles=${localFiles/\/home\/$(whoami)/\~}

    # Custom paths:

    if [[ $localFiles == "~/Development"* ]] && ! [[ $localFiles == "~/Development/tests"* ]] && ! [[ $localFiles == "~/Development/cpp"* ]] && ! [[ $localFiles == "~/Development/java"* ]] && ! [[ $localFiles == "~/Development/javascript"* ]] && ! [[ $localFiles == "~/Development/python"* ]] && ! [[ $localFiles == "~/.config" ]]; then
        icon=""; localFiles=${localFiles/\~\/Development/Dev}
    elif [[ $localFiles == "~/Development/tests"* ]]; then
        icon=""; localFiles=${localFiles/\~\/Development\/tests/Tests}
    elif [[ $localFiles == "/usr"* ]]; then
        icon=""; localFiles=${localFiles/\/usr/User}
    elif [[ $localFiles == "~/Development/cpp"* ]]; then
        icon=""; localFiles=${localFiles/\~\/Development\/cpp/C++}
    elif [[ $localFiles == "~/Development/java"* ]] && ! [[ $localFiles == "~/Development/javascript"* ]]; then
        icon=""; localFiles=${localFiles/\~\/Development\/java/\Java}
    elif [[ $localFiles == "~/Development/javascript"* ]]; then
        icon=""; localFiles=${localFiles/\~\/Development\/javascript/Javascript} 
    elif [[ $localFiles == "~/Development/python"* ]]; then
        icon=""; localFiles=${localFiles/\~\/Development\/python/Python}
    elif [[ $localFiles == "~/.config"* ]]; then
        icon=""; localFiles=${localFiles/\~\/\.config/Configuration}
    fi
    gitInfo="$(__git_info)"
    gitInfoLan=$?
    ps1string="    $icon  $(cat /etc/hostname) at $(whoami) in $localFiles "
    DATETEXT="$(date +'%H:%M:%S') "

    spaces=$((str[1] - ${#ps1string} - ${#DATETEXT} - gitInfoLan))

    spacestr=""

    for i in $(seq 2 $spaces)
    do
        spacestr+=" ‎" 
    done

    ps1string=$(echo "\n $FG_COLOR_01$RESET$BG_COLOR_01$FG_BLACK_COLOR $RESET$BG_COLOR_02$FG_COLOR_01$RESET$BG_COLOR_02$FG_BLACK_COLOR $icon $RESET$BG_COLOR_03$FG_COLOR_02$RESET$BG_COLOR_03 $MAINTEXTCOLOR$BOLD$(cat /etc/hostname) at $(whoami) in $localFiles $RESET$FG_COLOR_03$RESET")
    
    if ! [ $gitInfoLan -gt 0 ]; then
        DATETEXT="$FG_COLOR_03$BG_COLOR_03$MAINTEXTCOLOR$BOLD $(date +'%H:%M:%S')$RESET$FG_COLOR_03$RESET "
    else
        DATETEXT="$gitInfo$BG_COLOR_03$MAINTEXTCOLOR$BOLD $(date +'%H:%M:%S')$RESET$FG_COLOR_03$RESET "
    fi

    PS1="$ps1string$spacestr$DATETEXT\n\n$MAINTEXTCOLOR  >$RESET "
}

PROMPT_COMMAND=bash_prompt
