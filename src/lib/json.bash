# .bdb LIB

# @{ command } parseData :: bdb ==> string[][]
# @{ parm } $1 :: bdb data
# @{ return } string[][]
bdbFind() {
    data=$2
    data=${data/\\n/a}
    results=""
    readarray -d ";" -t data <<< "$data"
    i=0; while [ $i -lt $((${#data[@]} + 1)) ]
    do
        readarray -d "=" -t dat <<< "${data[i]}"
        if [[ ${dat[0]} == $1 ]]; then
            results=${dat[1]}
            break
        fi
        ((i++))
    done
    echo ${results}
}
