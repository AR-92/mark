#!/bin/bash

# mark - Template Wizard
# Wizard mode for template creation

# Source interactive utilities
source "/home/rana/Documents/mark/lib/utils/interactive.sh"

# Template creation wizard function
template_new_wizard() {
    local template_name="$1"
    
    echo "📝 Template Creation Wizard"
    echo ""
    
    # Confirm template name
    local confirmed_name=$(prompt_input "Template name" "$template_name")
    
    # Get default template directory from config or use default
    local default_template_dir=$(config_get "default_template_dir" 2>/dev/null)
    if [[ -z "$default_template_dir" ]]; then
        default_template_dir="${HOME}/.mark/templates"
    fi
    
    # Expand tilde to home directory
    default_template_dir="${default_template_dir/#\~/$HOME}"
    
    # Create directory if it doesn't exist
    mkdir -p "$default_template_dir"
    
    # Add .md extension if not present
    if [[ "$confirmed_name" != *.md ]]; then
        confirmed_name="${confirmed_name}.md"
    fi
    
    local template_path="$default_template_dir/$confirmed_name"
    
    # Check if template already exists
    if [[ -f "$template_path" ]]; then
        local overwrite=$(prompt_confirm "Template '$confirmed_name' already exists. Overwrite?")
        if [[ "$overwrite" != "yes" ]]; then
            echo "Template creation cancelled."
            return 1
        fi
    fi
    
    echo ""
    echo "📋 Template Information"
    
    # Get template description
    local description=$(prompt_input "Short description" "A new template")
    
    # Get variables
    local variables=()
    echo ""
    echo "🔧 Template Variables"
    echo "Enter variables one by one (press Enter with empty input to finish):"
    
    while true; do
        local var_name=$(prompt_input "Variable name")
        if [[ -z "$var_name" ]]; then
            break
        fi
        variables+=("$var_name")
    done
    
    echo ""
    echo "🏷️  Template Tags (optional)"
    echo "Enter tags one by one (press Enter with empty input to finish):"
    
    local tags=()
    while true; do
        local tag=$(prompt_input "Tag")
        if [[ -z "$tag" ]]; then
            break
        fi
        tags+=("$tag")
    done
    
    echo ""
    echo "📄 Template Content"
    
    # Create template content with front-matter
    local template_content=""
    
    # Add front-matter if we have metadata
    if [[ -n "$description" ]] || [[ ${#variables[@]} -gt 0 ]] || [[ ${#tags[@]} -gt 0 ]]; then
        template_content="---
"
        template_content+="name: ${confirmed_name%.md}
"
        if [[ -n "$description" ]]; then
            template_content+="description: \"$description\"
"
        fi
        if [[ ${#tags[@]} -gt 0 ]]; then
            template_content+="tags:
"
            for tag in "${tags[@]}"; do
                template_content+="  - $tag
"
            done
        fi
        if [[ ${#variables[@]} -gt 0 ]]; then
            template_content+="variables:
"
            for var in "${variables[@]}"; do
                template_content+="  - $var
"
            done
        fi
        template_content+="---
"
    fi
    
    # Add sample content
    template_content+="# $description

"
    
    if [[ ${#variables[@]} -gt 0 ]]; then
        for var in "${variables[@]}"; do
            template_content+="{{${var}}}

"
        done
    else
        template_content+="Your content here...

"
    fi
    
    # Write template to file
    echo -e "$template_content" > "$template_path"
    
    echo ""
    echo "✅ Template '$confirmed_name' created successfully!"
    echo "Location: $template_path"
    
    # Ask if user wants to edit the template
    echo ""
    local edit_choice=$(prompt_confirm "Would you like to edit the template now?")
    if [[ "$edit_choice" == "yes" ]]; then
        # Get editor from config or use default
        local editor=$(config_get "editor" 2>/dev/null)
        if [[ -z "$editor" ]]; then
            editor="vim"
        fi
        
        if command -v "$editor" &> /dev/null; then
            "$editor" "$template_path"
        else
            echo "Editor '$editor' not found. You can manually edit:"
            echo "$template_path"
        fi
    fi
    
    echo ""
    echo "🎉 Template creation complete!"
}