__git_info() { 
    if  ! [ -d .git ]; then
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
    unset __git_info
}
