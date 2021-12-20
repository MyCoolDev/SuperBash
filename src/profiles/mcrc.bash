# If not running interactively, don't do anything
[[ $- != *i* ]] && return

__run() {
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

        localFiles="$(pwd)"
        localFiles=${localFiles/\/home\/$(whoami)/\~}

        # Custom Path:
        source $HOME/.config/bash/custom/path.bash

        # Github Status:
        gitInfo="$(source $HOME/.config/bash/share/git_status.bash)"
        gitInfoLan=$?

        # Size:
        str="$(stty size)"
        readarray -d " " -t str <<< $str

        # Calc
        ps1string=" $localFiles "
        DATETEXT="$(date +'%H:%M:%S') "

        spaces=$((str[1] - ${#ps1string} - ${#DATETEXT} - gitInfoLan))

        spacestr=""

        for i in $(seq 3 $spaces)
        do
            spacestr+=" ‎"
        done

        ps1string=$(echo "\n $FG_COLOR_02$RESET$BG_COLOR_02$FG_BLACK_COLOR$BOLD $localFiles $RESET$FG_COLOR_02$RESET")
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
        unset osIcon
    }
    
    PROMPT_COMMAND=bash_prompt
}

__run

# UNSETS!
unset run
