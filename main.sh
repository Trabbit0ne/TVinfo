#!/bin/bash

# clear the screen
clear

# VARIABLES
version="1.0"

# Colors
R="\e[41m"
G="\e[42m"
Y="\e[43m"
B="\e[44m"
P="\e[45m"
C="\e[46m"
W="\e[47m\e[30m"
PK="\e[48;5;13m"
GY="\e[48;5;235m"
N="\e[0m"


# function to make TV art in ASCII
function TV() {
    echo -e "            o           o                                                   "
    echo -e "             \         /                                                    "
    echo -e "              \       /                                                     "
    echo -e "    ,----------\-----/---------------,                                      "
    echo -e "   /            '    '              /|     _______   ___      ___ $version       "
    echo -e "  /________________________________/ |    /_  __/ | / (_)__  / _/__         "
    echo -e "  |  ,__________________________,  | |     / /  | |/ / / _ \/ _/ _ \        "
    echo -e "  |  │${W}    ${Y}    ${C}    ${G}    ${PK}   ${R}    ${B}   ${N}│  │ │    /_/   |___/_/_//_/_/ \___/ "
    echo -e "  |  │${W}    ${Y}    ${C}    ${G}    ${PK}   ${R}    ${B}   ${N}│  │ │    Created By Trabbit         "
    echo -e "  |  │${W}    ${Y}    ${C}    ${G}    ${PK}   ${R}    ${B}   ${N}│  │ │     "
    echo -e "  |  │${W}    ${Y}    ${C} ${W} ERROR ${PK}   ${R}    ${B}   ${N}│  │ │     "
    echo -e "  |  │${B}    ${PK}    ${Y}    ${R}    ${C}    ${N}   ${W}   ${N}│  │ │     "
    echo -e "  |  │${W}    ${GY}    ${N}    ${Y}    ${G}    ${B}   ${PK}   ${N}│  │ │    "
    echo -e "  |  │${GY}    ${W}    ${W}    ${N}    ${N}    ${N}   ${N}   ${N}│  │ │     "
    echo -e "  |  │__________________________|  | /                                      "
    echo -e "  |________________________________|/                                       "
    echo -e "    |  [_______________________]  |'                                        "
    echo -e "    '_____________________________'                                         "
    echo
    echo
}

function GETInfos() {
    # Prompt for the title to search
    local prompt=$( echo -e "\e[1;32mTitle${N}")
    read -p " [$prompt]> " title
    echo

    # URL encode the title for safety (optional but recommended for handling special characters)
    encoded_title=$(echo "$title" | jq -R @uri)

    # Make the API request with the encoded title
    results=$(curl -s "https://api.tvmaze.com/search/shows?q=${encoded_title}")

    # Check if there are any results
    if [[ -z "$results" || "$results" == "[]" ]]; then
        echo "No results found for '$title'."
        return
    fi

    # Parse and format the results using jq
    echo "$results" | jq -r '.[] | .show | "\(.name) - \(.status) - \(.premiered) - \(.rating.average)"'
}


# main function
main() {
    TV
    GETInfos
}

# call the main function
main
