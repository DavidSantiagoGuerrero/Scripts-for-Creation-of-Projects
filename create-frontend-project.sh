#!/bin/bash
set -e
set -u

# Function to create front
create_front() {
    read -e -p $'Choose the number of the framework:\n1 - Vanilla\n2 - React\n> ' framework
    echo

    # Check the options 
    case $framework in
        1) framework_name="vanilla" ;;
        2) framework_name="react" ;;
        *) echo "Error: Invalid option"; exit 1 ;;
    esac

    read -e -p $'Choose your programming language:\n1 - JavaScript\n2 - TypeScript\n> ' language
    echo

    # Check the options 
    if [ "$language" == "2" ]; then
        framework_name="$framework_name-ts"
    fi

    # Initialize the project
    echo "Creating project $1"
    echo | npm create vite@latest -y $1 -- --template $framework_name

    # Create .env and put in the gitignore
    cd "$1"
    echo > .env
    echo $'\n# Environment variables' >> .gitignore
    echo ".env" >> .gitignore

    # Git init
    npm i
    git init

    # Create basic folder structure
    cd "src"
    mkdir "api"
    mkdir "router"
    mkdir "pages"
    mkdir "components"
    mkdir "styles"
}

# Presentation
echo $'================================='
echo $'|                               |'
echo $'|       FRONTEND CREATION       |'
echo $'|                               |'
echo $'================================='

name=$1
cd "$2"

# Check if the project includes backend
if [ ! -d "$name-PROJECT" ]; then
    create_front $name
else
    cd "$name-PROJECT"
    create_front "$name-FRONTEND"
fi

echo "Frontend created successfully on $2"
