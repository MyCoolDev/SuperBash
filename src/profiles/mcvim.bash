# If not running interactively, don't do anything
[[ $- != *i* ]] && return

__run() {
    # Colors:
    source $HOME/.config/bash/custom/colors.bash

    # Unicode symbols
    readonly GIT_BRANCH_CHANGED_SYMBOL=''
    readonly GIT_NEED_PULL_SYMBOL=''
    readonly GIT_NEED_PUSH_SYMBOL=''


    bash_prompt() {
        # Functions
        source $HOME/.config/bash/share/git_status.bash
        source $HOME/.config/bash/custom/path.bash

        # Check the exit code of the previous command and display different
        # colors in the prompt accordingly.
        if [ "$?" -eq 0 ]; then
            local BG_EXIT="$BG_GREEN"
            local FG_EXIT="$FG_GREEN"
        else
            local BG_EXIT="$BG_RED"
            local FG_EXIT="$FG_RED"
        fi

        localFiles="$(pwd)"
        icon=""
        localFiles=${localFiles/\/home\/$(whoami)/\~}

        # Custom Path:
        editpathres=$(edit_path $localFiles $icon)
        read -ra editpathres <<< "$editpathres"
        localFiles=${editpathres[0]}
        icon=${editpathres[1]}

        # Github Status:
        gitInfo="$(__git_info)"
        gitInfoLan=$?

        # Size:
        str="$(stty size)"
        read -ra str <<< "$str"

        #calc
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

        PS1="$ps1string$spacestr$DATETEXT\n\n$MAINTEXTCOLOR  >$RESET " # Set

        # unsets:
        unset localFiles
        unset icon
        unset spacestr
        unset space
        unset gitInfo
        unset gitInfoLan
        unset editpathres
    }
    
<<<<<<< HEAD
    PROMPT_COMMAND=bash_prompt
=======
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
>>>>>>> 72e0e86911d6d2cb753bbdb641ef5bcaabfdcb91
}

__run

# UNSETS!
unset run
