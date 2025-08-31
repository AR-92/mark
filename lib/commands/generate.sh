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
    
    # Debug output
    # echo "DEBUG: After processing #each blocks:" >&2
    # echo "$template_content" >&2
    
    # Handle #if conditional blocks
    template_content=$(process_if_blocks "$template_content")
    
    # Debug output
    # echo "DEBUG: After processing #if blocks:" >&2
    # echo "$template_content" >&2
    
    # Handle file substitution: {{@file_path}}
    while [[ "$template_content" =~ \{\{(@[^}]+)\}\} ]]; do
        local file_path="${BASH_REMATCH[1]#@}"
        local file_content=""
        
        # Resolve relative paths based on template file location
        local resolved_file_path=""
        if [[ "$file_path" == /* ]]; then
            # Absolute path
            resolved_file_path="$file_path"
        else
            # Relative path - resolve relative to template file directory
            local template_dir=$(dirname "$template_file")
            resolved_file_path="$template_dir/$file_path"
        fi
        
        # Check if file exists and read its content
        if [[ -f "$resolved_file_path" ]]; then
            file_content=$(cat "$resolved_file_path")
        else
            file_content="[File not found: $file_path]"
        fi
        
        # Replace the placeholder with file content using a more robust approach
        # Use a unique delimiter that's unlikely to appear in file content
        local delimiter="MARK_FILE_DELIMITER_$(date +%s)_$"
        template_content="${template_content//\{\{@$file_path\}\}/$delimiter}"
        template_content="${template_content//$delimiter/$file_content}"
    done
    
    # Handle regular variable substitution: {{variable_name}}
    # Process environment variables and data file values
    local iteration=0
    local max_iterations=100
    while [[ "$template_content" =~ \{\{([^}]+)\}\} ]] && [[ $iteration -lt $max_iterations ]]; do
        local var_name="${BASH_REMATCH[1]}"
        local var_value=""
        
        # Skip special blocks (#if, #each, @file) - they should be processed separately
        if [[ "$var_name" == "#if "* ]] || [[ "$var_name" == "#each "* ]] || [[ "$var_name" == "@"* ]]; then
            # Move to next iteration without processing
            iteration=$((iteration + 1))
            continue
        fi
        
        # Check environment variables
        if [[ -n "${!var_name}" ]]; then
            var_value="${!var_name}"
        fi
        
        # Escape special characters in the replacement value to prevent issues
        local placeholder="{{${var_name}}}"
        # Properly escape special regex characters for sed
        local escaped_value="$var_value"
        escaped_value="${escaped_value//\\/\\\\}"
        escaped_value="${escaped_value//\&/\\&}"
        escaped_value="${escaped_value//\//\\/}"
        
        # Replace ALL occurrences globally using sed for robustness
        template_content=$(echo "$template_content" | sed "s/{{$var_name}}/$escaped_value/g")
        
        iteration=$((iteration + 1))
    done
    
    # Output generated prompt
    echo "$template_content"
    log "Generated prompt from template: $template_file"
}