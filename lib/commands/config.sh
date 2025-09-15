#!/bin/bash

# mark - Config command
# Manage configuration values

# Source the enhanced config
source "/home/rana/Documents/mark/lib/core/enhanced_config.sh"

# Source config wizard if available
if [[ -f "/home/rana/Documents/mark/lib/commands/config_wizard.sh" ]]; then
    source "/home/rana/Documents/mark/lib/commands/config_wizard.sh"
fi

# Config command
config_command() {
    case "$1" in
        set)
            if [[ -z "$2" ]] || [[ -z "$3" ]]; then
                echo "Error: Missing key or value for set command"
                echo "Usage: mark config set <key> <value>"
                return 1
            fi
            config_set "$2" "$3"
            echo "Configuration '$2' set to '$3'"
            ;;
        get)
            if [[ -z "$2" ]]; then
                echo "Error: Missing key for get command"
                echo "Usage: mark config get <key>"
                return 1
            fi
            result=$(config_get "$2")
            echo "$result"
            ;;
        list)
            config_list
            ;;
        wizard)
            if declare -f config_wizard >/dev/null; then
                config_wizard
            else
                echo "Error: Config wizard not available"
                return 1
            fi
            ;;
        *)
            echo "Usage: mark config [set|get|list|wizard] [key] [value]"
            echo ""
            echo "Configurable keys:"
            echo "  template_dirs        List of directories to search for templates"
            echo "  default_template_dir Directory to use by default for new templates"
            echo "  editor               Default editor for template new/edit"
            echo "  use_fzf              Whether to use fuzzy finder when selecting templates"
            echo "  data_file_formats    Allowed formats for data input (json, yaml, toml)"
            echo "  wizard_questions     Default questions for wizard mode templates"
            echo ""
            echo "Wizard mode:"
            echo "  mark config wizard   Interactive configuration wizard"
            return 1
            ;;
    esac
}