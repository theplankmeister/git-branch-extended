#!/bin/bash

# requires git > v.1.7.9
# you can set branch's description using command
# git branch --edit-description
# this opens the configured text editor, enter message, save and exit
# if one editor does not work (for example Sublime does not work for me)
# try another one, like vi

# By adding the following line to your .bashrc you can inject the functionality of this script
# into the git command itself:
# git() { if [[ $# -eq 1 && $1 == "branch" ]]; then command ~/br.sh; else command git "$@"; fi; }

BRANCH=""
BRANCHES=`git for-each-ref  --sort=-committerdate refs/heads/ --format='%(HEAD) %(refname:short)'`
COLOUR_GREEN="\033[01;92m"
COLOUR_RESET="\033[0m"
OUTPUT='\n  Branch name\t  Last commit ▾\t  Description\n\n'
FORMAT='%s\t|%s\t|%s\n'
 
# First, we want to build the output for all the branches...
while read -r BRANCH; do
    # git marks current branch with "* ", remove it
    CLEAN_BRANCH_NAME=${BRANCH//\*\ /}
    DESCRIPTION=`git config branch.$CLEAN_BRANCH_NAME.description`
    CREATED=`git show --pretty="%ct" --no-patch $CLEAN_BRANCH_NAME`
    PRETTY=`date -d @$CREATED +"%Y-%m-%d %H:%m"`
    if [ "${BRANCH::1}" == "*" ]; then
        printf -v LINE $FORMAT "$BRANCH" " $PRETTY" " $DESCRIPTION"
    else
        printf -v LINE $FORMAT "  $BRANCH" " $PRETTY" " $DESCRIPTION"
    fi
    OUTPUT=$OUTPUT$LINE

done <<< "$BRANCHES"

# Then, we want to pipe it through the column command to line everything up nicely. We set IFS to
# force the output to respect leading spaces.
IFS='\n'
NEW=`printf "$OUTPUT" | column -e -t -s$'\t'`

# Then, we want to iterate over each line of this prettified output and highlight the currently
# active branch
while read -r BR; do
    if [ "${BR::1}" == "*" ]; then
        echo -e "${COLOUR_GREEN}${BR}${COLOUR_RESET}"
    else
        echo -e "${BR}"
    fi
done <<< "$NEW"

echo

# Just being thorough...
unset IFS

