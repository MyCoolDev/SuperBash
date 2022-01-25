# Unicode symbols
readonly GIT_BRANCH_CHANGED_SYMBOL=''
readonly GIT_NEED_PULL_SYMBOL=''
readonly GIT_NEED_PUSH_SYMBOL=''
LocalPath=$(pwd)
readarray -d "/" -t LocalPath <<< "$LocalPath"
i=3
found=0;
while [ $i -lt $((${#LocalPath[@]} + 1)) ]
do
    if [ -d "${LocalPath[i]}/.git" ]; then
        found=1
        break
    fi
    ((i++))
done
if ! [ $found -eq 0 ]; then
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
    echo "$branch,$marks,RED" # RED STATUS
    return ${#text}
else
    echo "$branch,$marks,BLUE" # BLUE STATUS
    return ${#text}
fi
