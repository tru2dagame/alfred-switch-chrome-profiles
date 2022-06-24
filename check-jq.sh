#!/bin/zsh

if ! command -v jq &> /dev/null
then
    cat << EOB
    {"items": [
        {
            "uid": "error",
            "title": "Command jq not found",
            "subtitle": "error",
            "arg": "jq"
        }
    ]}
EOB
exit 1
fi

if ! command -v fzf &> /dev/null
then
    cat << EOB
    {"items": [
        {
            "uid": "error",
            "title": "Command fzf not found",
            "subtitle": "error",
            "arg": "fzf"
        }
    ]}
EOB
exit 1
fi
