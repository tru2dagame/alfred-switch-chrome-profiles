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
