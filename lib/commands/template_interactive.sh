#!/bin/bash

# mark - Interactive Template command using Gum
# This file demonstrates how Gum can be integrated into mark

# Check if Gum is installed
check_gum() {
    if ! command -v gum &> /dev/null; then
        echo "Error: Gum is not installed. Please install Gum to use interactive features."
        echo "See: https://github.com/charmbracelet/gum#installation"
        return 1
    fi
    return 0
}

# Interactive template command
template_interactive() {
    # Check if Gum is available
    if ! check_gum; then
        echo "Falling back to standard template command..."
        template_command "$@"
        return
    fi
    
    # Main interactive menu
    choice=$(gum choose "List templates" "Show template" "Create new template" "Edit template" "Delete template" "Rename template" "Exit")
    
    case "$choice" in
        "List templates")
            template_list_interactive
            ;;
        "Show template")
            template_show_interactive
            ;;
        "Create new template")
            template_new_interactive
            ;;
        "Edit template")
            template_edit_interactive
            ;;
        "Delete template")
            template_delete_interactive
            ;;
        "Rename template")
            template_rename_interactive
            ;;
        "Exit")
            echo "Goodbye!"
            ;;
    esac
}

# Interactive template listing with fuzzy search
template_list_interactive() {
    echo "Available templates:"
    
    # Get template directories from config
    local template_dirs_str=$(config_get "template_dirs")
    local IFS=":"
    local template_dirs=($template_dirs_str)
    
    # If no template directories are configured, use default
    if [[ ${#template_dirs[@]} -eq 0 ]]; then
        template_dirs=("${HOME}/.mark/templates")
    fi
    
    local templates=()
    local found=false
    for dir in "${template_dirs[@]}"; do
        # Expand tilde to home directory
        dir="${dir/#\~/$HOME}"
        
        if [[ -d "$dir" ]]; then
            # Collect all template files
            while IFS= read -r -d '' file; do
                local basename=$(basename "$file")
                templates+=("$basename")
                found=true
            done < <(find "$dir" -type f -name "*.md" -print0 2>/dev/null)
        fi
    done
    
    if [[ "$found" == false ]]; then
        echo "No templates found"
        return
    fi
    
    # Use Gum filter for fuzzy search
    selected=$(printf '%s\n' "${templates[@]}" | gum filter --placeholder "Filter templates...")
    
    if [[ -n "$selected" ]]; then
        echo "Selected: $selected"
        gum confirm "Show content of '$selected'?" && template_show "$selected"
    fi
}

# Interactive template show with selection
template_show_interactive() {
    # Get all templates first
    local template_dirs_str=$(config_get "template_dirs")
    local IFS=":"
    local template_dirs=($template_dirs_str)
    
    if [[ ${#template_dirs[@]} -eq 0 ]]; then
        template_dirs=("${HOME}/.mark/templates")
    fi
    
    local templates=()
    local found=false
    for dir in "${template_dirs[@]}"; do
        dir="${dir/#\~/$HOME}"
        
        if [[ -d "$dir" ]]; then
            while IFS= read -r -d '' file; do
                local basename=$(basename "$file")
                templates+=("$basename")
                found=true
            done < <(find "$dir" -type f -name "*.md" -print0 2>/dev/null)
        fi
    done
    
    if [[ "$found" == false ]]; then
        echo "No templates found"
        return
    fi
    
    # Select template with fuzzy finder
    selected=$(printf '%s\n' "${templates[@]}" | gum filter --placeholder "Select template to show...")
    
    if [[ -n "$selected" ]]; then
        template_show "$selected"
    fi
}

# Interactive template creation
template_new_interactive() {
    # Get template name
    template_name=$(gum input --placeholder "Enter template name (without .md extension)")
    
    if [[ -z "$template_name" ]]; then
        echo "Template name is required"
        return 1
    fi
    
    # Confirm creation
    if gum confirm "Create new template '$template_name'?"; then
        # Add .md extension if not present
        if [[ "$template_name" != *.md ]]; then
            template_name="${template_name}.md"
        fi
        
        # Get default template directory
        local default_template_dir=$(config_get "default_template_dir")
        if [[ -z "$default_template_dir" ]]; then
            default_template_dir="${HOME}/.mark/templates"
        fi
        
        # Expand tilde to home directory
        default_template_dir="${default_template_dir/#\~/$HOME}"
        
        # Create directory if it doesn't exist
        mkdir -p "$default_template_dir"
        
        local template_path="$default_template_dir/$template_name"
        
        # Check if template already exists
        if [[ -f "$template_path" ]]; then
            gum style --foreground 196 "Error: Template '$template_name' already exists"
            return 1
        fi
        
        # Create template with basic structure
        cat > "$template_path" << EOF
# $template_name

## Description
<!-- Add a description of this template -->

## Usage
<!-- Explain how to use this template -->

## Placeholders
<!-- List the placeholders used in this template -->
{{variable_name}}

## Example
<!-- Provide an example of how to use this template -->
EOF
        
        gum style --foreground 46 "Template '$template_name' created successfully!"
        
        # Ask if user wants to edit the template
        if gum confirm "Edit the new template now?"; then
            template_edit "$template_name"
        else
            echo "Template created at: $template_path"
        fi
    else
        echo "Template creation cancelled"
    fi
}

# Interactive template editing
template_edit_interactive() {
    # Get all templates
    local template_dirs_str=$(config_get "template_dirs")
    local IFS=":"
    local template_dirs=($template_dirs_str)
    
    if [[ ${#template_dirs[@]} -eq 0 ]]; then
        template_dirs=("${HOME}/.mark/templates")
    fi
    
    local templates=()
    local found=false
    for dir in "${template_dirs[@]}"; do
        dir="${dir/#\~/$HOME}"
        
        if [[ -d "$dir" ]]; then
            while IFS= read -r -d '' file; do
                local basename=$(basename "$file")
                templates+=("$basename")
                found=true
            done < <(find "$dir" -type f -name "*.md" -print0 2>/dev/null)
        fi
    done
    
    if [[ "$found" == false ]]; then
        gum style --foreground 196 "No templates found"
        return
    fi
    
    # Select template to edit
    selected=$(printf '%s\n' "${templates[@]}" | gum filter --placeholder "Select template to edit...")
    
    if [[ -n "$selected" ]]; then
        template_edit "$selected"
    fi
}

# Interactive template deletion
template_delete_interactive() {
    # Get all templates
    local template_dirs_str=$(config_get "template_dirs")
    local IFS=":"
    local template_dirs=($template_dirs_str)
    
    if [[ ${#template_dirs[@]} -eq 0 ]]; then
        template_dirs=("${HOME}/.mark/templates")
    fi
    
    local templates=()
    local found=false
    for dir in "${template_dirs[@]}"; do
        dir="${dir/#\~/$HOME}"
        
        if [[ -d "$dir" ]]; then
            while IFS= read -r -d '' file; do
                local basename=$(basename "$file")
                templates+=("$basename")
                found=true
            done < <(find "$dir" -type f -name "*.md" -print0 2>/dev/null)
        fi
    done
    
    if [[ "$found" == false ]]; then
        gum style --foreground 196 "No templates found"
        return
    fi
    
    # Select template to delete
    selected=$(printf '%s\n' "${templates[@]}" | gum filter --placeholder "Select template to delete...")
    
    if [[ -n "$selected" ]]; then
        if gum confirm "Are you sure you want to delete '$selected'? This action cannot be undone."; then
            template_delete "$selected"
        else
            echo "Deletion cancelled"
        fi
    fi
}

# Interactive template renaming
template_rename_interactive() {
    # Get all templates
    local template_dirs_str=$(config_get "template_dirs")
    local IFS=":"
    local template_dirs=($template_dirs_str)
    
    if [[ ${#template_dirs[@]} -eq 0 ]]; then
        template_dirs=("${HOME}/.mark/templates")
    fi
    
    local templates=()
    local found=false
    for dir in "${template_dirs[@]}"; do
        dir="${dir/#\~/$HOME}"
        
        if [[ -d "$dir" ]]; then
            while IFS= read -r -d '' file; do
                local basename=$(basename "$file")
                templates+=("$basename")
                found=true
            done < <(find "$dir" -type f -name "*.md" -print0 2>/dev/null)
        fi
    done
    
    if [[ "$found" == false ]]; then
        gum style --foreground 196 "No templates found"
        return
    fi
    
    # Select template to rename
    old_name=$(printf '%s\n' "${templates[@]}" | gum filter --placeholder "Select template to rename...")
    
    if [[ -n "$old_name" ]]; then
        new_name=$(gum input --placeholder "Enter new name for '$old_name'" --value "$old_name")
        
        if [[ -n "$new_name" ]] && [[ "$new_name" != "$old_name" ]]; then
            if gum confirm "Rename '$old_name' to '$new_name'?"; then
                template_rename "$old_name" "$new_name"
            else
                echo "Rename cancelled"
            fi
        elif [[ "$new_name" == "$old_name" ]]; then
            echo "New name is the same as the old name"
        fi
    fi
}