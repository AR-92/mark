#!/bin/bash

# mark - Generate Command
# Generate prompt from template

generate_prompt() {
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
    
    # Process and output template
    parse_template "$template_file"
    
    # Log the generation
    log "Generated prompt from template: $template_file"
}