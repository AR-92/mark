#!/bin/bash

# mark - Template Management Wizards
# Wizard modes for template management commands

# Source interactive utilities
source "/home/rana/Documents/mark/lib/utils/interactive.sh"

# Template edit wizard function
template_edit_wizard() {
    echo "✏️  Template Edit Wizard"
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
    
    # Select template to edit
    echo "📋 Select a template to edit:"
    local selected_template=$(select_from_list "Templates" "${all_templates[@]}")
    
    if [[ -z "$selected_template" ]]; then
        echo "No template selected."
        return 1
    fi
    
    echo ""
    echo "📝 Editing template: $selected_template"
    
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
    
    # Get editor from config or use default
    local editor=$(config_get "editor" 2>/dev/null)
    if [[ -z "$editor" ]]; then
        editor="vim"
    fi
    
    echo ""
    echo "🔧 Opening template in $editor..."
    
    if command -v "$editor" &> /dev/null; then
        "$editor" "$template_path"
        echo "✅ Template edited successfully!"
    else
        echo "❌ Editor '$editor' not found."
        echo "You can manually edit the template at:"
        echo "$template_path"
        return 1
    fi
}

# Template delete wizard function
template_delete_wizard() {
    echo "🗑️  Template Delete Wizard"
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
        echo "No templates found."
        return 1
    fi
    
    # Select template to delete
    echo "📋 Select a template to delete:"
    local selected_template=$(select_from_list "Templates" "${all_templates[@]}")
    
    if [[ -z "$selected_template" ]]; then
        echo "No template selected."
        return 1
    fi
    
    echo ""
    echo "📝 Template to delete: $selected_template"
    
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
    
    # Confirm deletion
    echo ""
    local confirm=$(prompt_confirm "Are you sure you want to delete '$selected_template'?")
    if [[ "$confirm" != "yes" ]]; then
        echo "Deletion cancelled."
        return 0
    fi
    
    # Delete the template
    if rm "$template_path"; then
        echo "✅ Template '$selected_template' deleted successfully!"
    else
        echo "❌ Failed to delete template '$selected_template'"
        return 1
    fi
}

# Template rename wizard function
template_rename_wizard() {
    echo "🏷️  Template Rename Wizard"
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
        echo "No templates found."
        return 1
    fi
    
    # Select template to rename
    echo "📋 Select a template to rename:"
    local selected_template=$(select_from_list "Templates" "${all_templates[@]}")
    
    if [[ -z "$selected_template" ]]; then
        echo "No template selected."
        return 1
    fi
    
    echo ""
    echo "📝 Template to rename: $selected_template"
    
    # Find the full path of the selected template
    local template_path=""
    local template_dir=""
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
            template_dir="$dir"
            break
        fi
    done
    
    if [[ -z "$template_path" ]]; then
        echo "Error: Could not find template '$selected_template'"
        return 1
    fi
    
    # Get new name
    local new_name=$(prompt_input "Enter new name for the template")
    if [[ -z "$new_name" ]]; then
        echo "No new name provided. Rename cancelled."
        return 1
    fi
    
    # Add .md extension if not present
    if [[ "$new_name" != *.md ]]; then
        new_name="${new_name}.md"
    fi
    
    # Check if new name already exists
    local new_path="$template_dir/$new_name"
    if [[ -f "$new_path" ]]; then
        local overwrite=$(prompt_confirm "Template '$new_name' already exists. Overwrite?")
        if [[ "$overwrite" != "yes" ]]; then
            echo "Rename cancelled."
            return 1
        fi
    fi
    
    # Rename the template
    if mv "$template_path" "$new_path"; then
        echo "✅ Template renamed from '$selected_template' to '$new_name' successfully!"
    else
        echo "❌ Failed to rename template"
        return 1
    fi
}