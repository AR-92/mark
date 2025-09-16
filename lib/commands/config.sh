#!/bin/bash

# mark - Configuration Management
# Consolidated configuration functionality

config_command() {
    local action="$1"
    local key="$2"
    local value="$3"
    
    case "$action" in
        set)
            if [[ -z "$key" || -z "$value" ]]; then
                echo "Error: Missing key or value for set command"
                echo "Usage: mark config set <key> <value>"
                return 1
            fi
            
            # Create config directory if it doesn't exist
            mkdir -p "$(dirname "$CONFIG_FILE")"
            
            # Set the configuration value
            if grep -q "^${key}=" "$CONFIG_FILE" 2>/dev/null; then
                # Update existing key
                sed -i "s|^${key}=.*|${key}=${value}|" "$CONFIG_FILE"
            else
                # Add new key
                echo "${key}=${value}" >> "$CONFIG_FILE"
            fi
            
            echo "Configuration updated: ${key}=${value}"
            ;;
        get)
            if [[ -z "$key" ]]; then
                echo "Error: Missing key for get command"
                echo "Usage: mark config get <key>"
                return 1
            fi
            
            # Get the configuration value
            if [[ -f "$CONFIG_FILE" ]]; then
                grep "^${key}=" "$CONFIG_FILE" | cut -d'=' -f2-
            else
                echo "Configuration file not found"
                return 1
            fi
            ;;
        list)
            # List all configuration values
            if [[ -f "$CONFIG_FILE" ]]; then
                cat "$CONFIG_FILE"
            else
                echo "No configuration file found"
            fi
            ;;
        *)
            echo "Error: Unknown config action '$action'"
            echo "Usage: mark config <set|get|list> [key] [value]"
            return 1
            ;;
    esac
}