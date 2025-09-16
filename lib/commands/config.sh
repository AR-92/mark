#!/bin/bash

# mark - Config command
# Manage configuration

# Source core functions
source "/home/rana/Documents/mark/lib/core/logging.sh"

# Config command function
config_command() {
    case "$1" in
        set)
            if [[ -z "$2" ]] || [[ -z "$3" ]]; then
                echo "Error: Missing key or value for set command"
                echo "Usage: mark config set <key> <value>"
                return 1
            fi
            config_set "$2" "$3"
            echo "Configuration updated: $2=$3"
            ;;
        get)
            if [[ -z "$2" ]]; then
                echo "Error: Missing key for get command"
                echo "Usage: mark config get <key>"
                return 1
            fi
            local value=$(config_get "$2")
            echo "$value"
            ;;
        list)
            config_list
            ;;
        *)
            echo "Usage: mark config [set|get|list] [args]"
            echo ""
            echo "Commands:"
            echo "  set <key> <value>  Set a configuration option"
            echo "  get <key>          Get a configuration option"
            echo "  list               List all configuration options"
            return 1
            ;;
    esac
}