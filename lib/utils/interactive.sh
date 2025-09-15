#!/bin/bash

# mark - Interactive utilities
# Utilities for interactive wizard mode

# Function to prompt user for input with optional default value
prompt_input() {
    local prompt="$1"
    local default="$2"
    
    if [[ -n "$default" ]]; then
        echo -n "$prompt [$default, or 'q' to quit]: "
    else
        echo -n "$prompt (or 'q' to quit): "
    fi
    
    local input
    read -r input
    
    # Check if user wants to quit
    if [[ "$input" == "q" ]] || [[ "$input" == "Q" ]]; then
        echo ""
        return 1
    fi
    
    if [[ -z "$input" ]] && [[ -n "$default" ]]; then
        echo "$default"
    else
        echo "$input"
    fi
}

# Function to prompt user for choice from a list
prompt_choice() {
    local prompt="$1"
    shift
    local choices=("$@")
    
    echo "$prompt"
    echo "  0) Quit/Cancel"
    for i in "${!choices[@]}"; do
        echo "  $((i+1))) ${choices[$i]}"
    done
    
    local choice
    while true; do
        echo -n "Enter choice (0-${#choices[@]}): "
        read -r choice
        
        if [[ "$choice" == "0" ]]; then
            echo ""
            return 1
        elif [[ "$choice" =~ ^[0-9]+$ ]] && [[ "$choice" -ge 1 ]] && [[ "$choice" -le "${#choices[@]}" ]]; then
            echo "${choices[$((choice-1))]}"
            return 0
        else
            echo "Invalid choice. Please enter a number between 0 and ${#choices[@]}."
        fi
    done
}

# Function to prompt user for yes/no confirmation
prompt_confirm() {
    local prompt="$1"
    local default="${2:-y}"
    
    local choices
    if [[ "$default" == "y" ]]; then
        choices=("Y/n/q")
    else
        choices=("y/N/q")
    fi
    
    while true; do
        echo -n "$prompt [${choices[0]}]: "
        local input
        read -r input
        
        if [[ -z "$input" ]]; then
            input="$default"
        fi
        
        case "$input" in
            y|Y|yes|Yes|YES)
                echo "yes"
                return 0
                ;;
            n|N|no|No|NO)
                echo "no"
                return 0
                ;;
            q|Q|quit|Quit)
                echo ""
                return 1
                ;;
            *)
                echo "Please answer yes, no, or q to quit."
                ;;
        esac
    done
}

# Function to check if fzf is available
has_fzf() {
    command -v fzf >/dev/null 2>&1
}

# Function to select from a list using fzf if available, otherwise numbered menu
select_from_list() {
    local prompt="$1"
    shift
    local items=("$@")
    
    # Check if fzf is enabled in config and available
    local use_fzf=$(config_get "use_fzf" 2>/dev/null)
    if [[ "$use_fzf" == "true" ]] && has_fzf; then
        # Use fzf for selection, but fallback to numbered menu if not in proper terminal
        if printf '%s\n' "${items[@]}" | fzf --prompt="$prompt> " 2>/dev/null; then
            return 0
        else
            # Fallback to numbered menu if fzf fails
            echo "Fzf not available in current environment, falling back to numbered menu."
        fi
    fi
    
    # Use numbered menu
    echo "$prompt"
    echo "  0) Quit/Cancel"
    for i in "${!items[@]}"; do
        echo "  $((i+1))) ${items[$i]}"
    done
    
    local choice
    while true; do
        echo -n "Enter choice (0-${#items[@]}): "
        read -r choice
        
        if [[ "$choice" == "0" ]]; then
            echo ""
            return 1
        elif [[ "$choice" =~ ^[0-9]+$ ]] && [[ "$choice" -ge 1 ]] && [[ "$choice" -le "${#items[@]}" ]]; then
            echo "${items[$((choice-1))]}"
            return 0
        else
            echo "Invalid choice. Please enter a number between 0 and ${#items[@]}."
        fi
    done
}