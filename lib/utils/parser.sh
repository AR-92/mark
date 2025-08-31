#!/bin/bash

# mark - Data parsing utilities

# Function to parse simple key=value data file
parse_data_file() {
    local data_file="$1"
    
    if [[ -n "$data_file" && -f "$data_file" ]]; then
        while IFS='=' read -r key value || [[ -n "$key" ]]; do
            # Skip comments and empty lines
            [[ "$key" =~ ^#.*$ || -z "$key" ]] && continue
            # Export variables so they can be accessed
            export "$key=$value"
        done < "$data_file"
    fi
}