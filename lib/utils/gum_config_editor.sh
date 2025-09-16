#!/bin/bash

# gum_config_editor.sh - Enhanced configuration management with Gum forms
# Provides intuitive configuration editing using Gum forms and inputs

# Source the Gum theme if available
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$SCRIPT_DIR/../lib"

if [[ -f "$LIB_DIR/utils/gum_theme.sh" ]]; then
    source "$LIB_DIR/utils/gum_theme.sh"
fi

# Check if Gum is installed
check_gum() {
    command -v gum &> /dev/null
}

# Show configuration with Gum formatting
show_config_formatted() {
    local config_data="$1"
    
    if check_gum; then
        if declare -f gum_section >/dev/null; then
            gum_section "Current Configuration"
        else
            gum style --bold "Current Configuration:"
        fi
        echo ""
        
        # Format as table if possible
        if echo "$config_data" | grep -q "="; then
            # Convert key=value pairs to table format
            echo "$config_data" | while IFS='=' read -r key value; do
                if [[ -n "$key" ]]; then
                    printf "%-20s | %s\n" "$key" "$value"
                fi
            done | gum table --border rounded --columns "Key,Value"
        else
            echo "$config_data" | gum format
        fi
    else
        echo "Current Configuration:"
        echo "====================="
        echo ""
        echo "$config_data"
    fi
}

# Edit configuration with Gum forms
edit_config_with_forms() {
    if ! check_gum; then
        echo "Error: Gum is not installed. Cannot use form-based configuration editor."
        return 1
    fi
    
    # Get current configuration
    local current_config
    current_config=$(./bin/mark config list 2>/dev/null)
    
    # Parse current configuration into variables
    local editor="vim"
    local template_dirs=""
    local use_fzf="false"
    local data_file_formats="json,yaml,toml"
    
    # Extract values from current config
    while IFS='=' read -r key value; do
        case "$key" in
            "editor") editor="$value" ;;
            "template_dirs") template_dirs="$value" ;;
            "use_fzf") use_fzf="$value" ;;
            "data_file_formats") data_file_formats="$value" ;;
        esac
    done <<< "$current_config"
    
    # Create temporary file for form
    local temp_form=$(mktemp)
    
    # Create form with current values
    cat > "$temp_form" << EOF
# Configuration Editor
# Edit your mark configuration settings

## Editor Settings
editor.text: Editor
editor.value: $editor
editor.description: Default editor for template creation and editing

## Template Settings
template_dirs.text: Template Directories
template_dirs.value: $template_dirs
template_dirs.description: Colon-separated list of template directories

## Feature Settings
use_fzf.text: Use FZF
use_fzf.value: $use_fzf
use_fzf.description: Enable fuzzy finder for template selection
use_fzf.type: boolean

data_file_formats.text: Data File Formats
data_file_formats.value: $data_file_formats
data_file_formats.description: Comma-separated list of supported data file formats
EOF
    
    # Show form using Gum
    if declare -f gum_info >/dev/null; then
        gum_info "Editing configuration with Gum forms..."
        gum_info "Leave fields empty to keep current values"
    else
        echo "Editing configuration with Gum forms..."
        echo "Leave fields empty to keep current values"
    fi
    echo ""
    
    # Process form
    local new_editor new_template_dirs new_use_fzf new_data_file_formats
    
    # Get editor
    if declare -f gum_input_prompt >/dev/null; then
        new_editor=$(gum_input_prompt "Editor [$editor]" "$editor")
    else
        new_editor=$(gum input --placeholder="Editor [$editor]" --value="$editor")
    fi
    
    # Get template directories
    if declare -f gum_input_prompt >/dev/null; then
        new_template_dirs=$(gum_input_prompt "Template Directories [$template_dirs]" "$template_dirs")
    else
        new_template_dirs=$(gum input --placeholder="Template Directories [$template_dirs]" --value="$template_dirs")
    fi
    
    # Get FZF setting
    if declare -f gum_choose_option >/dev/null; then
        new_use_fzf=$(gum_choose_option "Use FZF [$use_fzf]" "true" "false")
    else
        new_use_fzf=$(printf "true\nfalse" | gum choose --header="Use FZF [$use_fzf]")
    fi
    
    # Get data file formats
    if declare -f gum_input_prompt >/dev/null; then
        new_data_file_formats=$(gum_input_prompt "Data File Formats [$data_file_formats]" "$data_file_formats")
    else
        new_data_file_formats=$(gum input --placeholder="Data File Formats [$data_file_formats]" --value="$data_file_formats")
    fi
    
    # Update configuration
    local updated=false
    
    if [[ -n "$new_editor" ]] && [[ "$new_editor" != "$editor" ]]; then
        ./bin/mark config set editor "$new_editor"
        if declare -f gum_success >/dev/null; then
            gum_success "Updated editor: $new_editor"
        else
            echo "Updated editor: $new_editor"
        fi
        updated=true
    fi
    
    if [[ -n "$new_template_dirs" ]] && [[ "$new_template_dirs" != "$template_dirs" ]]; then
        ./bin/mark config set template_dirs "$new_template_dirs"
        if declare -f gum_success >/dev/null; then
            gum_success "Updated template directories: $new_template_dirs"
        else
            echo "Updated template directories: $new_template_dirs"
        fi
        updated=true
    fi
    
    if [[ -n "$new_use_fzf" ]] && [[ "$new_use_fzf" != "$use_fzf" ]]; then
        ./bin/mark config set use_fzf "$new_use_fzf"
        if declare -f gum_success >/dev/null; then
            gum_success "Updated use_fzf: $new_use_fzf"
        else
            echo "Updated use_fzf: $new_use_fzf"
        fi
        updated=true
    fi
    
    if [[ -n "$new_data_file_formats" ]] && [[ "$new_data_file_formats" != "$data_file_formats" ]]; then
        ./bin/mark config set data_file_formats "$new_data_file_formats"
        if declare -f gum_success >/dev/null; then
            gum_success "Updated data file formats: $new_data_file_formats"
        else
            echo "Updated data file formats: $new_data_file_formats"
        fi
        updated=true
    fi
    
    if ! $updated; then
        if declare -f gum_info >/dev/null; then
            gum_info "No configuration changes made"
        else
            echo "No configuration changes made"
        fi
    fi
    
    # Clean up
    rm -f "$temp_form"
}

# Reset configuration to defaults with confirmation
reset_config_defaults() {
    if ! check_gum; then
        echo "Reset all configuration to defaults? (y/N)"
        read -p "" reset_conf </dev/null
        if [[ "$reset_conf" =~ ^[Yy]$ ]]; then
            rm -f ~/.mark/config.data 2>/dev/null || true
            echo "Configuration reset to defaults!"
        else
            echo "Reset cancelled"
        fi
        return
    fi
    
    # Show warning
    if declare -f gum_warning >/dev/null; then
        gum_warning "🚨 WARNING: This will reset all configuration to defaults!"
    else
        gum style --foreground 220 --bold "🚨 WARNING: This will reset all configuration to defaults!"
    fi
    echo ""
    
    # Confirm reset
    if declare -f gum_confirm_action >/dev/null; then
        if gum_confirm_action "Reset all configuration to defaults?"; then
            # Reset configuration
            rm -f ~/.mark/config.data 2>/dev/null || true
            if declare -f gum_success >/dev/null; then
                gum_success "Configuration reset to defaults!"
            else
                echo "Configuration reset to defaults!"
            fi
        else
            if declare -f gum_info >/dev/null; then
                gum_info "Reset cancelled"
            else
                echo "Reset cancelled"
            fi
        fi
    else
        if gum confirm "Reset all configuration to defaults?"; then
            # Reset configuration
            rm -f ~/.mark/config.data 2>/dev/null || true
            if declare -f gum_success >/dev/null; then
                gum_success "Configuration reset to defaults!"
            else
                echo "Configuration reset to defaults!"
            fi
        else
            if declare -f gum_info >/dev/null; then
                gum_info "Reset cancelled"
            else
                echo "Reset cancelled"
            fi
        fi
    fi
}

# Show configuration menu
show_config_menu() {
    if ! check_gum; then
        echo "Configuration Management"
        echo "========================"
        echo "1. View Configuration"
        echo "2. Edit Configuration (Gum Forms)"
        echo "3. Reset to Defaults"
        echo "4. Back to Main Menu"
        echo ""
        read -p "Select option (1-4): " choice </dev/null
        case "$choice" in
            1) 
                local config_data
                config_data=$(./bin/mark config list 2>/dev/null)
                echo "Current Configuration:"
                echo "====================="
                echo ""
                echo "$config_data"
                echo ""
                read -p "Press Enter to continue..." </dev/null
                show_config_menu
                ;;
            2) 
                echo "Gum is required for form-based configuration editing"
                echo "Use 'mark config set <key> <value>' to update configuration"
                echo ""
                read -p "Press Enter to continue..." </dev/null
                show_config_menu
                ;;
            3)
                echo "Reset all configuration to defaults? (y/N)"
                read -p "" reset_conf </dev/null
                if [[ "$reset_conf" =~ ^[Yy]$ ]]; then
                    rm -f ~/.mark/config.data 2>/dev/null || true
                    echo "Configuration reset to defaults!"
                else
                    echo "Reset cancelled"
                fi
                echo ""
                read -p "Press Enter to continue..." </dev/null
                show_config_menu
                ;;
            4) return ;;
            *) 
                echo "Invalid option"
                read -p "Press Enter to continue..." </dev/null
                show_config_menu
                ;;
        esac
        return
    fi
    
    # Show configuration menu with Gum
    if declare -f gum_section >/dev/null; then
        gum_section "Configuration Management"
    else
        gum style --bold "Configuration Management"
    fi
    echo ""
    
    # Show options
    local options=("View Configuration" "Edit Configuration (Gum Forms)" "Reset to Defaults" "Back to Main Menu")
    local choice
    
    if declare -f gum_filter_option >/dev/null; then
        choice=$(gum_filter_option "Select configuration action..." "${options[@]}")
    else
        choice=$(printf '%s\n' "${options[@]}" | gum filter --placeholder="Select configuration action...")
    fi
    
    case "$choice" in
        "View Configuration")
            local config_data
            config_data=$(./bin/mark config list 2>/dev/null)
            show_config_formatted "$config_data"
            echo ""
            if declare -f gum_info >/dev/null; then
                gum_info "Press Enter to continue..."
            else
                echo "Press Enter to continue..."
            fi
            gum input --placeholder="" --width=1 > /dev/null
            show_config_menu
            ;;
        "Edit Configuration (Gum Forms)")
            edit_config_with_forms
            echo ""
            if declare -f gum_info >/dev/null; then
                gum_info "Press Enter to continue..."
            else
                echo "Press Enter to continue..."
            fi
            gum input --placeholder="" --width=1 > /dev/null
            show_config_menu
            ;;
        "Reset to Defaults")
            reset_config_defaults
            echo ""
            if declare -f gum_info >/dev/null; then
                gum_info "Press Enter to continue..."
            else
                echo "Press Enter to continue..."
            fi
            gum input --placeholder="" --width=1 > /dev/null
            show_config_menu
            ;;
        "Back to Main Menu"|*)
            return
            ;;
    esac
}