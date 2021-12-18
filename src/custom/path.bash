edit_path() {
    localFiles=$1
    icon=$2
    # For exemple:
    # if [[ $localFiles == "~/Development"* ]]; then
    #   icon="<>"; localFiles="Dev"
    # fi

    echo "$localFiles $icon"
    unset edit_path
}
