# If not running interactively, don't do anything
[[ $- != *i* ]] && return

__run() {
    # Unicode symbols
    readonly GIT_BRANCH_CHANGED_SYMBOL=''
    readonly GIT_NEED_PULL_SYMBOL=''
    readonly GIT_NEED_PUSH_SYMBOL=''


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
    
    PROMPT_COMMAND=bash_prompt
}

__run

# UNSETS!
unset run
