#!/bin/bash

# mark - Template command
# Manage templates

# Source the enhanced config for template directory configuration
source "/home/rana/Documents/mark/lib/core/enhanced_config.sh"

# Source template wizard if available
if [[ -f "/home/rana/Documents/mark/lib/commands/template_wizard.sh" ]]; then
    source "/home/rana/Documents/mark/lib/commands/template_wizard.sh"
fi

# Source template management wizards if available
if [[ -f "/home/rana/Documents/mark/lib/commands/template_management_wizards.sh" ]]; then
    source "/home/rana/Documents/mark/lib/commands/template_management_wizards.sh"
fi

# Template command
template_command() {
    case "$1" in
        list)
            template_list "$2" "$3"
            ;;
        show)
            if [[ -z "$2" ]]; then
                echo "Error: Missing template name for show command"
                echo "Usage: mark template show <template_name>"
                return 1
            fi
            template_show "$2" "$3"
            ;;
        new)
            if [[ -z "$2" ]]; then
                echo "Error: Missing template name for new command"
                echo "Usage: mark template new <template_name>"
                return 1
            fi
            # Check if wizard mode is requested
            if [[ "$3" == "--wizard" ]]; then
                if declare -f template_new_wizard >/dev/null; then
                    template_new_wizard "$2"
                else
                    echo "Error: Wizard mode not available"
                    return 1
                fi
            else
                template_new "$2" "$3"
            fi
            ;;
        edit)
            # Check if wizard mode is requested
            if [[ "$2" == "--wizard" ]]; then
                if declare -f template_edit_wizard >/dev/null; then
                    template_edit_wizard
                else
                    echo "Error: Wizard mode not available"
                    return 1
                fi
            else
                if [[ -z "$2" ]]; then
                    echo "Error: Missing template name for edit command"
                    echo "Usage: mark template edit <template_name>"
                    return 1
                fi
                template_edit "$2" "$3"
            fi
            ;;
        delete)
            # Check if wizard mode is requested
            if [[ "$2" == "--wizard" ]]; then
                if declare -f template_delete_wizard >/dev/null; then
                    template_delete_wizard
                else
                    echo "Error: Wizard mode not available"
                    return 1
                fi
            else
                if [[ -z "$2" ]]; then
                    echo "Error: Missing template name for delete command"
                    echo "Usage: mark template delete <template_name>"
                    return 1
                fi
                template_delete "$2" "$3"
            fi
            ;;
        rename)
            # Check if wizard mode is requested
            if [[ "$2" == "--wizard" ]]; then
                if declare -f template_rename_wizard >/dev/null; then
                    template_rename_wizard
                else
                    echo "Error: Wizard mode not available"
                    return 1
                fi
            else
                if [[ -z "$2" ]] || [[ -z "$3" ]]; then
                    echo "Error: Missing template names for rename command"
                    echo "Usage: mark template rename <old_name> <new_name>"
                    return 1
                fi
                template_rename "$2" "$3" "$4"
            fi
            ;;
        *)
            echo "Usage: mark template [list|show|new|edit|delete|rename] [args]"
            echo ""
            echo "Commands:"
            echo "  list                    List all templates"
            echo "  show <template_name>    Show raw content of a template"
            echo "  new <template_name>     Create a new template"
            echo "  new <template_name> --wizard  Create a new template with wizard"
            echo "  edit <template_name>    Edit an existing template"
            echo "  edit --wizard           Edit a template with wizard"
            echo "  delete <template_name>  Delete a template"
            echo "  delete --wizard         Delete a template with wizard"
            echo "  rename <old> <new>      Rename a template"
            echo "  rename --wizard         Rename a template with wizard"
            return 1
            ;;
    esac
}

# List templates
template_list() {
    # Get template directories from config
    local template_dirs_str=$(config_get "template_dirs")
    local IFS=":"
    local template_dirs=($template_dirs_str)
    
    # If no template directories are configured, use default
    if [[ ${#template_dirs[@]} -eq 0 ]]; then
        template_dirs=("${HOME}/.mark/templates")
    fi
    
    echo "Available templates:"
    
    local found=false
    for dir in "${template_dirs[@]}"; do
        # Expand tilde to home directory
        dir="${dir/#\~/$HOME}"
        
        if [[ -d "$dir" ]]; then
            # Use a while loop with process substitution to handle filenames with spaces
            while IFS= read -r -d '' file; do
                local basename=$(basename "$file")
                echo "  $basename"
                found=true
            done < <(find "$dir" -type f -name "*.md" -print0 2>/dev/null)
        fi
    done
    
    if [[ "$found" == false ]]; then
        echo "  No templates found"
    fi
}

# Show template content
template_show() {
    local template_name="$1"
    
    # Get template directories from config
    local template_dirs_str=$(config_get "template_dirs")
    local IFS=":"
    local template_dirs=($template_dirs_str)
    
    # If no template directories are configured, use default
    if [[ ${#template_dirs[@]} -eq 0 ]]; then
        template_dirs=("${HOME}/.mark/templates")
    fi
    
    # Look for the template in all configured directories
    for dir in "${template_dirs[@]}"; do
        # Expand tilde to home directory
        dir="${dir/#\~/$HOME}"
        
        local template_path="$dir/$template_name"
        
        # Add .md extension if not present
        if [[ "$template_name" != *.md ]]; then
            template_path="$dir/${template_name}.md"
        fi
        
        if [[ -f "$template_path" ]]; then
            cat "$template_path"
            return 0
        fi
    done
    
    echo "Error: Template '$template_name' not found"
    return 1
}

# Create new template
template_new() {
    local template_name="$1"
    
    # Get default template directory from config or use default
    local default_template_dir=$(config_get "default_template_dir")
    if [[ -z "$default_template_dir" ]]; then
        default_template_dir="${HOME}/.mark/templates"
    fi
    
    # Expand tilde to home directory
    default_template_dir="${default_template_dir/#\~/$HOME}"
    
    # Create directory if it doesn't exist
    mkdir -p "$default_template_dir"
    
    # Add .md extension if not present
    if [[ "$template_name" != *.md ]]; then
        template_name="${template_name}.md"
    fi
    
    local template_path="$default_template_dir/$template_name"
    
    # Check if template already exists
    if [[ -f "$template_path" ]]; then
        echo "Error: Template '$template_name' already exists"
        return 1
    fi
    
    # Create empty template file
    touch "$template_path"
    
    # Open in editor if available
    local editor=$(config_get "editor")
    if [[ -z "$editor" ]]; then
        editor="vim"
    fi
    
    if command -v "$editor" &> /dev/null; then
        "$editor" "$template_path"
    else
        echo "Template created at: $template_path"
        echo "Warning: Editor '$editor' not found. You can manually edit the file."
    fi
}

# Edit existing template
template_edit() {
    local template_name="$1"
    
    # Get template directories from config
    local template_dirs_str=$(config_get "template_dirs")
    local IFS=":"
    local template_dirs=($template_dirs_str)
    
    # If no template directories are configured, use default
    if [[ ${#template_dirs[@]} -eq 0 ]]; then
        template_dirs=("${HOME}/.mark/templates")
    fi
    
    # Look for the template in all configured directories
    for dir in "${template_dirs[@]}"; do
        # Expand tilde to home directory
        dir="${dir/#\~/$HOME}"
        
        local template_path="$dir/$template_name"
        
        # Add .md extension if not present
        if [[ "$template_name" != *.md ]]; then
            template_path="$dir/${template_name}.md"
        fi
        
        if [[ -f "$template_path" ]]; then
            # Get editor from config or use default
            local editor=$(config_get "editor")
            if [[ -z "$editor" ]]; then
                editor="vim"
            fi
            
            if command -v "$editor" &> /dev/null; then
                "$editor" "$template_path"
            else
                echo "Error: Editor '$editor' not found"
                return 1
            fi
            return 0
        fi
    done
    
    echo "Error: Template '$template_name' not found"
    return 1
}

# Delete template
template_delete() {
    local template_name="$1"
    
    # Get template directories from config
    local template_dirs_str=$(config_get "template_dirs")
    local IFS=":"
    local template_dirs=($template_dirs_str)
    
    # If no template directories are configured, use default
    if [[ ${#template_dirs[@]} -eq 0 ]]; then
        template_dirs=("${HOME}/.mark/templates")
    fi
    
    # Look for the template in all configured directories
    for dir in "${template_dirs[@]}"; do
        # Expand tilde to home directory
        dir="${dir/#\~/$HOME}"
        
        local template_path="$dir/$template_name"
        
        # Add .md extension if not present
        if [[ "$template_name" != *.md ]]; then
            template_path="$dir/${template_name}.md"
        fi
        
        if [[ -f "$template_path" ]]; then
            # Confirm deletion
            echo "Are you sure you want to delete '$template_name'? (y/N)"
            read -r response
            if [[ "$response" == "y" ]] || [[ "$response" == "Y" ]]; then
                rm "$template_path"
                echo "Template '$template_name' deleted"
            else
                echo "Deletion cancelled"
            fi
            return 0
        fi
    done
    
    echo "Error: Template '$template_name' not found"
    return 1
}

# Rename template
template_rename() {
    local old_name="$1"
    local new_name="$2"
    
    # Get template directories from config
    local template_dirs_str=$(config_get "template_dirs")
    local IFS=":"
    local template_dirs=($template_dirs_str)
    
    # If no template directories are configured, use default
    if [[ ${#template_dirs[@]} -eq 0 ]]; then
        template_dirs=("${HOME}/.mark/templates")
    fi
    
    # Look for the template in all configured directories
    for dir in "${template_dirs[@]}"; do
        # Expand tilde to home directory
        dir="${dir/#\~/$HOME}"
        
        local old_path="$dir/$old_name"
        local new_path="$dir/$new_name"
        
        # Add .md extension if not present
        if [[ "$old_name" != *.md ]]; then
            old_path="$dir/${old_name}.md"
        fi
        
        if [[ "$new_name" != *.md ]]; then
            new_path="$dir/${new_name}.md"
        fi
        
        if [[ -f "$old_path" ]]; then
            # Check if new name already exists
            if [[ -f "$new_path" ]]; then
                echo "Error: Template '$new_name' already exists"
                return 1
            fi
            
            mv "$old_path" "$new_path"
            echo "Template '$old_name' renamed to '$new_name'"
            return 0
        fi
    done
    
    echo "Error: Template '$old_name' not found"
    return 1
}