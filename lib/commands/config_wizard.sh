#!/bin/bash

# mark - Config Wizard
# Wizard mode for configuration management

# Source interactive utilities if available
if [[ -f "/home/rana/Documents/mark/lib/utils/interactive.sh" ]]; then
    source "/home/rana/Documents/mark/lib/utils/interactive.sh"
fi

# Config wizard function
config_wizard() {
    echo "⚙️  Configuration Wizard"
    echo ""
    
    # Get config directory and file
    local config_dir=$(dirname "$CONFIG_FILE")
    local config_data_file="$config_dir/config.data"
    
    # Ensure config directory exists
    mkdir -p "$config_dir"
    
    echo "Current Configuration:"
    echo "======================"
    if [[ -f "$config_data_file" ]]; then
        cat "$config_data_file"
    else
        echo "No custom configuration set"
    fi
    echo ""
    
    # Show default values
    echo "Default Values:"
    echo "==============="
    echo "template_dirs=$(IFS=":"; echo "${DEFAULT_TEMPLATE_DIRS[*]}")"
    echo "editor=$DEFAULT_EDITOR"
    echo "use_fzf=$DEFAULT_USE_FZF"
    echo "data_file_formats=$(IFS=","; echo "${DEFAULT_DATA_FILE_FORMATS[*]}")"
    echo "wizard_questions=$(IFS=","; echo "${DEFAULT_WIZARD_QUESTIONS[*]}")"
    echo ""
    
    # Ask user what they want to do
    echo "What would you like to do?"
    local action=$(prompt_choice "Select an option:" "Edit config in editor" "Set individual values" "Reset to defaults" "Cancel")
    
    case "$action" in
        "Edit config in editor")
            edit_config_in_editor "$config_data_file"
            ;;
        "Set individual values")
            set_individual_values "$config_data_file"
            ;;
        "Reset to defaults")
            reset_to_defaults "$config_data_file"
            ;;
        "Cancel")
            echo "Configuration wizard cancelled."
            return 0
            ;;
    esac
}

# Function to edit config in editor
edit_config_in_editor() {
    local config_data_file="$1"
    
    # Create config file if it doesn't exist
    if [[ ! -f "$config_data_file" ]]; then
        touch "$config_data_file"
    fi
    
    # Get editor from config or use default
    local editor=$(config_get "editor" 2>/dev/null)
    if [[ -z "$editor" ]]; then
        editor="vim"
    fi
    
    echo "Opening configuration file in $editor..."
    echo "Save and exit the editor when finished."
    echo "Press Enter to continue..."
    read -r
    
    if command -v "$editor" &> /dev/null; then
        # Backup current config
        if [[ -f "$config_data_file" ]]; then
            cp "$config_data_file" "${config_data_file}.backup"
        fi
        
        # Open editor
        "$editor" "$config_data_file"
        
        # Check if file was modified
        if [[ -f "${config_data_file}.backup" ]]; then
            if cmp -s "$config_data_file" "${config_data_file}.backup"; then
                echo "Configuration file unchanged."
            else
                echo "✅ Configuration updated successfully!"
            fi
            rm -f "${config_data_file}.backup"
        else
            echo "✅ Configuration updated successfully!"
        fi
    else
        echo "❌ Editor '$editor' not found."
        echo "Please install $editor or set a different editor with:"
        echo "mark config set editor <your-editor>"
        return 1
    fi
}

# Function to set individual values
set_individual_values() {
    local config_data_file="$1"
    
    echo "Setting individual configuration values..."
    echo "Leave blank to keep current value."
    echo ""
    
    # Get current values
    local current_editor=$(config_get "editor" 2>/dev/null)
    local current_use_fzf=$(config_get "use_fzf" 2>/dev/null)
    local current_template_dirs=$(config_get "template_dirs" 2>/dev/null)
    local current_data_file_formats=$(config_get "data_file_formats" 2>/dev/null)
    
    # Prompt for values
    local new_editor=$(prompt_input "Editor" "$current_editor")
    local new_use_fzf=$(prompt_input "Use FZF (true/false)" "$current_use_fzf")
    local new_template_dirs=$(prompt_input "Template directories (colon separated)" "$current_template_dirs")
    local new_data_file_formats=$(prompt_input "Data file formats (comma separated)" "$current_data_file_formats")
    
    # Update values if provided
    if [[ -n "$new_editor" ]]; then
        config_set "editor" "$new_editor"
    fi
    
    if [[ -n "$new_use_fzf" ]]; then
        config_set "use_fzf" "$new_use_fzf"
    fi
    
    if [[ -n "$new_template_dirs" ]]; then
        config_set "template_dirs" "$new_template_dirs"
    fi
    
    if [[ -n "$new_data_file_formats" ]]; then
        config_set "data_file_formats" "$new_data_file_formats"
    fi
    
    echo "✅ Configuration updated successfully!"
}

# Function to reset to defaults
reset_to_defaults() {
    local config_data_file="$1"
    
    local confirm=$(prompt_confirm "Are you sure you want to reset all configuration to defaults?")
    if [[ "$confirm" == "yes" ]]; then
        # Remove config file to use defaults
        if [[ -f "$config_data_file" ]]; then
            rm -f "$config_data_file"
        fi
        echo "✅ Configuration reset to defaults!"
    else
        echo "Reset cancelled."
    fi
}