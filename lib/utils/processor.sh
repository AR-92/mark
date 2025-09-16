#!/bin/bash

# mark - Processor
# Template processor with placeholder replacement

# Process template with placeholder replacement
process_template() {
    local template_file="$1"
    
    # Read template line by line and process placeholders
    while IFS= read -r line || [[ -n "$line" ]]; do
        # Process placeholders in the line
        process_line "$line"
    done < "$template_file"
}

# Process a single line with placeholder replacement
process_line() {
    local line="$1"
    local processed_line="$line"
    
    # Replace placeholders with variable values
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