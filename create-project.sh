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

echo $'First, choose a folder to create your project'
echo
sleep 1

scripts_folder=$(pwd)

while true; do
    current_folder=$(pwd)

    echo "You are on $current_folder right now"
    read -e -p $'Would you like to: \n1 - Go back\n2 - Create and enter a folder\n3 - Enter to a folder (Make sure it exists)\n4 - Stay in this folder\n> ' menu
    echo

    case $menu in
        1) cd .. ;;
        2) read -p "Write the name of the foler: " folder; mkdir "$folder"; cd "$folder";;
        3) ls; read -p "Write the name of the foler: " folder; cd "$folder";;
        4) current_folder=$(pwd); break;;
        *) echo "Error: Invalid option" ; exit 1 ;;
    esac
done

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
    cd "$scripts_folder"
    ./create-backend-project.sh "$name-BACKEND" "$current_folder"
    ./create-frontend-project.sh "$name-FRONTEND" "$current_folder"
else
    cd "$scripts_folder"
    ./create-frontend-project.sh "$name" "$current_folder"
fi
