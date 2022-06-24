#!/bin/zsh
export PATH=$JQ_PATH:$PATH
[[ -d "${alfred_workflow_data}" ]] || mkdir "${alfred_workflow_data}"

source check-jq.sh

source list_profiles.zsh

  # | Sed -e 's/\\/\\\\\\/g'  \
  # | sed -e 's/"/\\&/g' \
  # | sed -e 's/\r$//g'  \

# fzf search
cat ${alfred_workflow_data}/profiles.txt        \
  | fzf -e +s -f "$1"  \
  | head -n30          \
  > ${alfred_workflow_data}/matches.txt

cat ${alfred_workflow_data}/matches.txt | jq -nR '{ "items":
     [ inputs
       | select(length>0) as $name |
       split("-") as $parts |
       {
       "uid": $name,
        "title":$name | sub("-"; " "; "g") | sub("\\("; " "; "g") | sub("\\)"; " "; "g"),
        "subtitle":$name,
        "arg":$name,
        "autocomplete":$name | sub("-"; " "; "g") | sub("\\("; " "; "g") | sub("\\)"; " "; "g")
       }
     ]}'


# echo $profile | jq -nR '{ "items":
#      [ inputs
#        | select(length>0) as $name |
#        split("-") as $parts |
#        {
#        "uid": $name,
#         "title":$name | sub("-"; " "; "g") | sub("\\("; " "; "g") | sub("\\)"; " "; "g"),
#         "subtitle":$name,
#         "arg":$name,
#         "autocomplete":$name | sub("-"; " "; "g") | sub("\\("; " "; "g") | sub("\\)"; " "; "g")
#        }
#      ]}'
