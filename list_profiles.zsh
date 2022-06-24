#!/bin/zsh

SERVICE='Google Chrome'

if pgrep -xq -- "${SERVICE}"; then
	# Get profile name strings by applescript
    profile=$(osascript -e 'tell application "System Events"
        get properties
        tell process "Google Chrome"
            get every menu bar
            tell menu bar 1
                -- menu bar item 8 is "Profiles", use "8" to prevent language issue
                title of menu item of menu 1 of menu bar item 8
            end tell
        end tell
    end tell')
	# Make strings to json and delete "Add" and "Edit" options
    profile=`echo $profile | jq -R 'split(", ")' | jq -cs | jq -r '.[][] | select(length > 0) | select(. | contains("Add")|not) | select(. | contains("Edit")|not) '`
    echo $profile > ${alfred_workflow_data}/profiles.txt
else

    cat << EOB
    {"items": [
        {
            "uid": "error",
            "title": "Please open your Chrome first",
            "subtitle": "error",
            "arg": "open_chrome"
        }
    ]}
EOB
    exit 1

fi
