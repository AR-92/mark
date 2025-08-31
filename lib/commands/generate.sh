#!/bin/bash

# mark - Generate command

# Generate command
generate_prompt() {
    local template_file="$1"
    local data_file="$2"
    
    # Check if template file exists
    if [[ ! -f "$template_file" ]]; then
        log "ERROR: Template file '$template_file' not found"
        echo "Error: Template file '$template_file' not found" >&2
        return 1
    fi
    
    # Read template
    local template_content
    template_content=$(cat "$template_file")
    
    # Process data file if provided
    parse_data_file "$data_file"
    
    # Process template content
    
    # Handle #each loop blocks first
    template_content=$(process_each_blocks "$template_content")
    
    # Handle #if conditional blocks
    template_content=$(process_if_blocks "$template_content")
    
    # Handle file substitution: {{@file_path}}
    while [[ "$template_content" =~ \{\{(@[^}]+)\}\} ]]; do
        local file_path="${BASH_REMATCH[1]#@}"
        local file_content=""
        
        # Check if file exists and read its content
        if [[ -f "$file_path" ]]; then
            file_content=$(cat "$file_path")
        else
            file_content="[File not found: $file_path]"
        fi
        
        # Replace the placeholder with file content
        template_content="${template_content//\{\{@$file_path\}\}/$file_content}"
    done
    
    # Handle regular variable substitution: {{variable_name}}
    # Process environment variables and data file values
    local iteration=0
    local max_iterations=100
    while [[ "$template_content" =~ \{\{([^}]+)\}\} ]] && [[ $iteration -lt $max_iterations ]]; do
        local var_name="${BASH_REMATCH[1]}"
        local var_value=""
        
        # Check environment variables
        if [[ -n "${!var_name}" ]]; then
            var_value="${!var_name}"
        fi
        
        # Escape special characters in the replacement value to prevent issues
        local placeholder="{{${var_name}}}"
        local escaped_value="${var_value//\\/\\\\}"
        # escaped_value="${escaped_value//\&/\\&}"  # Removed ampersand escaping
        # escaped_value="${escaped_value//\//\\/}"  # Removed slash escaping
        
        # Replace ALL occurrences globally
        template_content="${template_content//"$placeholder"/$escaped_value}"
        
        iteration=$((iteration + 1))
    done
    
    # Output generated prompt
    echo "$template_content"
    log "Generated prompt from template: $template_file"
}