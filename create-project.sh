#!/bin/bash
set -e
set -u

# Presentation
echo $'============================================'
echo $'|                                          |'
echo $'|        WELCOME TO PROJECT CREATOR        |'
echo $'|   Created with love by David Guerrero    |'
echo $'|                                          |'
echo $'============================================'
echo $'Shall we start?\n'

# Ask for the type of project
read -p $'What will your project include?\n1 - Backend and frontend\n2 - Only frontend\n> ' project
echo

# If invalid option, exit
if [ "$project" != "1" ] && [ "$project" != "2" ]; then
    echo "Error: Invalid option."
    exit 1
fi

# Ask for the name of the project
read -e -p $'Enter the name of your project (If you selected option 1, we will add \'-BACKEND\' and \'-FRONTEND\' at the end of the name):\n> ' name 
echo

# Create the project
if [ "$project" == "1" ]; then
    mkdir "$name-PROJECT"
    ./create-backend-project.sh "$name-BACKEND"
    ./create-frontend-project.sh "$name-FRONTEND"
else
    ./create-frontend-project.sh "$name"
fi
