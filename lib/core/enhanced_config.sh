#!/bin/bash

# mark - Enhanced Configuration
# Enhanced configuration management with set/get functionality

# Configuration file path
CONFIG_FILE="${HOME}/.mark/config.yml"

# Default values
DEFAULT_TEMPLATE_DIRS=("${HOME}/.mark/templates")
DEFAULT_EDITOR="vim"
DEFAULT_USE_FZF=false
DEFAULT_DATA_FILE_FORMATS=("json" "yaml" "toml")

# Ensure config directory exists
mkdir -p "$(dirname "$CONFIG_FILE")"

# Function to set config values
config_set() {
    local key="$1"
    local value="$2"
    
    # For now, we'll just use a simple key=value format in a file
    # In the future, we might want to use YAML
    
    local config_dir=$(dirname "$CONFIG_FILE")
    local config_data_file="$config_dir/config.data"
    
    # Create or update the config file
    if [[ -f "$config_data_file" ]]; then
        # Remove any existing line with this key
        grep -v "^${key}=" "$config_data_file" > "${config_data_file}.tmp" 2>/dev/null || true
        mv "${config_data_file}.tmp" "$config_data_file" 2>/dev/null || true
    else
        touch "$config_data_file"
    fi
    
    # Add the new value
    echo "${key}=${value}" >> "$config_data_file"
}

# Function to get config values
config_get() {
    local key="$1"
    
    local config_dir=$(dirname "$CONFIG_FILE")
    local config_data_file="$config_dir/config.data"
    
    if [[ -f "$config_data_file" ]]; then
        grep "^${key}=" "$config_data_file" 2>/dev/null | cut -d'=' -f2- || echo ""
    else
        # Return default values for specific keys
        case "$key" in
            "editor")
                echo "$DEFAULT_EDITOR"
                ;;
            "use_fzf")
                echo "$DEFAULT_USE_FZF"
                ;;
            "template_dirs")
                # Join array with colon
                local IFS=":"
                echo "${DEFAULT_TEMPLATE_DIRS[*]}"
                ;;
            "data_file_formats")
                # Join array with comma
                local IFS=","
                echo "${DEFAULT_DATA_FILE_FORMATS[*]}"
                ;;
            *)
                echo ""
                ;;
        esac
    fi
}

# Function to list all config values
config_list() {
    local config_dir=$(dirname "$CONFIG_FILE")
    local config_data_file="$config_dir/config.data"
    
    echo "Configuration:"
    
    if [[ -f "$config_data_file" ]]; then
        cat "$config_data_file"
    fi
    
    # Show defaults for keys not explicitly set
    echo "template_dirs=$(IFS=":"; echo "${DEFAULT_TEMPLATE_DIRS[*]}") (default)"
    echo "editor=$DEFAULT_EDITOR (default)"
    echo "use_fzf=$DEFAULT_USE_FZF (default)"
    echo "data_file_formats=$(IFS=","; echo "${DEFAULT_DATA_FILE_FORMATS[*]}") (default)"
}