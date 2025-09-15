#!/bin/bash

# mark - Interactive Generate
# Interactive mode for generate command

# Source interactive utilities
source "/home/rana/Documents/mark/lib/utils/interactive.sh"

# Interactive generate function
generate_prompt_interactive() {
    echo "🌟 Welcome to Mark Interactive Mode"
    echo ""
    
    # Get template directories from config
    local template_dirs_str=$(config_get "template_dirs" 2>/dev/null)
    local IFS=":"
    local template_dirs=($template_dirs_str)
    
    # If no template directories are configured, use default
    if [[ ${#template_dirs[@]} -eq 0 ]]; then
        template_dirs=("${HOME}/.mark/templates")
    fi
    
    # Collect all templates from all directories
    local all_templates=()
    for dir in "${template_dirs[@]}"; do
        # Expand tilde to home directory
        dir="${dir/#\~/$HOME}"
        
        if [[ -d "$dir" ]]; then
            while IFS= read -r -d '' file; do
                local basename=$(basename "$file")
                # Check if template is already in the list
                local found=false
                for existing in "${all_templates[@]}"; do
                    if [[ "$existing" == "$basename" ]]; then
                        found=true
                        break
                    fi
                done
                if [[ "$found" == false ]]; then
                    all_templates+=("$basename")
                fi
            done < <(find "$dir" -type f -name "*.md" -print0 2>/dev/null)
        fi
    done
    
    # Check if we have any templates
    if [[ ${#all_templates[@]} -eq 0 ]]; then
        echo "No templates found. Create one with 'mark template new <name> --wizard'"
        return 1
    fi
    
    # Select template
    echo "📋 Select a template:"
    local selected_template=$(select_from_list "Templates" "${all_templates[@]}")
    
    if [[ -z "$selected_template" ]]; then
        echo "No template selected."
        return 1
    fi
    
    echo ""
    echo "📝 Template: $selected_template"
    
    # Find the full path of the selected template
    local template_path=""
    for dir in "${template_dirs[@]}"; do
        # Expand tilde to home directory
        dir="${dir/#\~/$HOME}"
        
        local possible_path="$dir/$selected_template"
        # Add .md extension if not present
        if [[ "$selected_template" != *.md ]]; then
            possible_path="$dir/${selected_template}.md"
        fi
        
        if [[ -f "$possible_path" ]]; then
            template_path="$possible_path"
            break
        fi
    done
    
    if [[ -z "$template_path" ]]; then
        echo "Error: Could not find template '$selected_template'"
        return 1
    fi
    
    # Extract variables from template
    local template_content=$(cat "$template_path")
    local variables=()
    
    # Extract {{variable}} patterns
    while [[ "$template_content" =~ \{\{([^#{}@][^{}]*)\}\} ]]; do
        local var="${BASH_REMATCH[1]}"
        # Trim whitespace
        var=$(echo "$var" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
        
        # Add to variables array if not already there
        local found=false
        for existing in "${variables[@]}"; do
            if [[ "$existing" == "$var" ]]; then
                found=true
                break
            fi
        done
        if [[ "$found" == false ]]; then
            variables+=("$var")
        fi
        
        # Remove this match from content to continue searching
        template_content="${template_content#*${BASH_REMATCH[0]}}"
    done
    
    # Prompt for variables
    echo ""
    echo "🔧 Required Variables:"
    if [[ ${#variables[@]} -gt 0 ]]; then
        for var in "${variables[@]}"; do
            local value=$(prompt_input "Enter value for $var")
            # Export variable so it's available for template processing
            export "$var=$value"
        done
    else
        echo "No variables required for this template."
    fi
    
    # Ask for output destination
    echo ""
    echo "💾 Output Options:"
    local output_choice=$(prompt_choice "How would you like to save the output?" "Display on screen" "Save to file")
    
    local output_file=""
    if [[ "$output_choice" == "Save to file" ]]; then
        local default_name="generated_$(date +%Y-%m-%d_%H-%M-%S).md"
        output_file=$(prompt_input "Output file name" "$default_name")
    fi
    
    echo ""
    echo "✨ Generating output..."
    
    # Generate the prompt using the existing function
    local output=$(generate_prompt "$template_path")
    
    # Show preview
    echo ""
    echo "📄 Preview:"
    echo "--- START PREVIEW ---"
    echo "$output"
    echo "--- END PREVIEW ---"
    
    # Confirm before finalizing
    echo ""
    local confirm=$(prompt_confirm "Proceed with generation?")
    if [[ "$confirm" != "yes" ]]; then
        echo "Generation cancelled."
        return 0
    fi
    
    # Output or save
    if [[ -n "$output_file" ]]; then
        echo "$output" > "$output_file"
        echo "✅ Prompt saved to $output_file"
        log "Generated prompt from template: $selected_template, saved to: $output_file"
    else
        echo ""
        echo "$output"
        log "Generated prompt from template: $selected_template, displayed on screen"
    fi
    
    echo ""
    echo "🎉 Generation complete!"
}