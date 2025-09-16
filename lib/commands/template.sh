#!/bin/bash

# mark - Template Management
# Consolidated template functionality

template_command() {
    local action="$1"
    local arg1="$2"
    local arg2="$3"
    
    case "$action" in
        list)
            # List all templates
            if [[ -d "$TEMPLATE_DIR" ]]; then
                echo "Templates in $TEMPLATE_DIR:"
                ls "$TEMPLATE_DIR" 2>/dev/null || echo "No templates found"
            else
                echo "Template directory does not exist: $TEMPLATE_DIR"
            fi
            ;;
        show)
            # Show template content
            if [[ -z "$arg1" ]]; then
                echo "Error: Missing template name"
                echo "Usage: mark template show <template_name>"
                return 1
            fi
            
            local template_path="$TEMPLATE_DIR/$arg1"
            if [[ -f "$template_path" ]]; then
                cat "$template_path"
            else
                echo "Template not found: $arg1"
                return 1
            fi
            ;;
        new)
            # Create a new template
            if [[ -z "$arg1" ]]; then
                echo "Error: Missing template name"
                echo "Usage: mark template new <template_name>"
                return 1
            fi
            
            local template_path="$TEMPLATE_DIR/$arg1"
            
            # Create template directory if it doesn't exist
            mkdir -p "$(dirname "$template_path")"
            
            # Create a basic template
            cat > "$template_path" << 'EOF'
# {{title}}

{{#if description}}
## Description
{{description}}
{{/if}}

## Requirements
{{#each requirements}}
- {{this}}
{{/each}}

## Task
{{task}}

{{#if example}}
## Example
```{{language}}
{{example}}
```
{{/if}}

Please provide a complete, well-documented implementation.
EOF
            
            echo "Template created: $arg1"
            ;;
        edit)
            # Edit a template
            if [[ -z "$arg1" ]]; then
                echo "Error: Missing template name"
                echo "Usage: mark template edit <template_name>"
                return 1
            fi
            
            local template_path="$TEMPLATE_DIR/$arg1"
            if [[ ! -f "$template_path" ]]; then
                echo "Template not found: $arg1"
                return 1
            fi
            
            # Use configured editor or default to vim
            local editor="${EDITOR:-vim}"
            "$editor" "$template_path"
            ;;
        delete)
            # Delete a template
            if [[ -z "$arg1" ]]; then
                echo "Error: Missing template name"
                echo "Usage: mark template delete <template_name>"
                return 1
            fi
            
            local template_path="$TEMPLATE_DIR/$arg1"
            if [[ ! -f "$template_path" ]]; then
                echo "Template not found: $arg1"
                return 1
            fi
            
            rm "$template_path"
            echo "Template deleted: $arg1"
            ;;
        rename)
            # Rename a template
            if [[ -z "$arg1" || -z "$arg2" ]]; then
                echo "Error: Missing template names"
                echo "Usage: mark template rename <old_name> <new_name>"
                return 1
            fi
            
            local old_path="$TEMPLATE_DIR/$arg1"
            local new_path="$TEMPLATE_DIR/$arg2"
            
            if [[ ! -f "$old_path" ]]; then
                echo "Template not found: $arg1"
                return 1
            fi
            
            # Create directory for new path if it doesn't exist
            mkdir -p "$(dirname "$new_path")"
            
            mv "$old_path" "$new_path"
            echo "Template renamed from $arg1 to $arg2"
            ;;
        *)
            echo "Error: Unknown template action '$action'"
            echo "Usage: mark template <list|show|new|edit|delete|rename> [args]"
            return 1
            ;;
    esac
}