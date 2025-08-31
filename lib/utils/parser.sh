#!/bin/bash

# mark - Data parsing utilities

# Function to parse simple key=value data file
parse_data_file() {
    local data_file="$1"
    
    if [[ -n "$data_file" && -f "$data_file" ]]; then
        # Read entire file and process line by line
        local content
        content=$(cat "$data_file")
        
        while IFS= read -r line || [[ -n "$line" ]]; do
            # Skip empty lines and comments
            if [[ -z "$line" ]] || [[ "$line" =~ ^[[:space:]]*$ ]] || [[ "$line" =~ ^[[:space:]]*#.*$ ]]; then
                continue
            fi
            
            # Split on first =
            if [[ "$line" =~ ^([^=]+)=(.*)$ ]]; then
                local key="${BASH_REMATCH[1]}"
                local value="${BASH_REMATCH[2]}"
                
                # Trim whitespace
                key=$(echo "$key" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
                value=$(echo "$value" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
                
                # Validate variable name - must start with letter or underscore
                if [[ "$key" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
                    # Declare global variables so they can be accessed
                    declare -g "$key=$value"
                fi
            fi
        done <<< "$content"
    fi
}