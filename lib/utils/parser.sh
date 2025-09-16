#!/bin/bash

# mark - Parser
# Template parser with placeholder replacement functionality

parse_template() {
    local template_file="$1"
    local data_file="$2"
    
    # Check if template file exists
    if [[ ! -f "$template_file" ]]; then
        echo "Error: Template file not found: $template_file" >&2
        return 1
    fi
    
    # Load data if provided
    if [[ -n "$data_file" && -f "$data_file" ]]; then
        source "$data_file"
    fi
    
    # Process template
    process_template "$template_file"
}

process_template() {
    local template_file="$1"
    
    # Read template line by line
    while IFS= read -r line || [[ -n "$line" ]]; do
        # Process placeholders
        process_line "$line"
    done < "$template_file"
}

process_line() {
    local line="$1"
    
    # Replace placeholders with variable values
    # This uses bash parameter expansion to replace {{variable}} with $variable
    # First, let's extract all placeholders from the line
    local processed_line="$line"
    
    # Simple placeholder replacement for {{variable_name}}
    # We use a while loop to handle multiple placeholders in the same line
    while [[ "$processed_line" =~ \{\{([a-zA-Z0-9_]+)\}\} ]]; do
        local placeholder="${BASH_REMATCH[0]}"
        local variable_name="${BASH_REMATCH[1]}"
        
        # Get the value of the variable (if it exists)
        local variable_value="${!variable_name}"
        
        # Replace the placeholder with the variable value
        processed_line="${processed_line//$placeholder/$variable_value}"
    done
    
    echo "$processed_line"
}