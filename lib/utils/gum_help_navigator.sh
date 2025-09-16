#!/bin/bash

# gum_help_navigator.sh - Enhanced help system with intuitive navigation
# Provides intuitive help navigation using Gum

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

# Show main help with intuitive navigation
show_help_navigator() {
    if ! check_gum; then
        # Show plain text help
        ./bin/mark help
        return
    fi
    
    # Clear screen and show header
    if declare -f gum_clear_screen >/dev/null; then
        gum_clear_screen
    else
        clear
        if command -v gum &> /dev/null; then
            gum style --align center --bold "MARK - AI Prompt Templating Tool"
        else
            echo "MARK - AI Prompt Templating Tool"
        fi
        echo ""
    fi
    
    # Show help navigator
    if declare -f gum_section >/dev/null; then
        gum_section "Help Navigator"
    else
        gum style --bold "Help Navigator"
    fi
    echo ""
    
    # Show command categories
    local categories=("Core Commands" "Additional Commands" "Configuration" "Templates" "Prompt Generation" "System Operations" "Back to Main Menu")
    local category
    
    if declare -f gum_filter_option >/dev/null; then
        category=$(gum_filter_option "Select help category..." "${categories[@]}")
    else
        category=$(printf '%s\n' "${categories[@]}" | gum filter --placeholder="Select help category...")
    fi
    
    case "$category" in
        "Core Commands")
            show_core_commands_help
            ;;
        "Additional Commands")
            show_additional_commands_help
            ;;
        "Configuration")
            show_configuration_help
            ;;
        "Templates")
            show_templates_help
            ;;
        "Prompt Generation")
            show_prompt_generation_help
            ;;
        "System Operations")
            show_system_operations_help
            ;;
        "Back to Main Menu"|*)
            return
            ;;
    esac
}

# Show core commands help
show_core_commands_help() {
    if ! check_gum; then
        ./bin/mark help
        return
    fi
    
    # Clear screen and show header
    if declare -f gum_clear_screen >/dev/null; then
        gum_clear_screen
    else
        clear
        if command -v gum &> /dev/null; then
            gum style --align center --bold "MARK - AI Prompt Templating Tool"
        else
            echo "MARK - AI Prompt Templating Tool"
        fi
        echo ""
    fi
    
    # Show section header
    if declare -f gum_section >/dev/null; then
        gum_section "Core Commands"
    else
        gum style --bold "Core Commands"
    fi
    echo ""
    
    # Show core commands
    local commands=("generate" "list" "clear" "config" "template" "help" "Back to Help Navigator")
    local command
    
    if declare -f gum_filter_option >/dev/null; then
        command=$(gum_filter_option "Select command for detailed help..." "${commands[@]}")
    else
        command=$(printf '%s\n' "${commands[@]}" | gum filter --placeholder="Select command for detailed help...")
    fi
    
    case "$command" in
        "generate")
            if command -v gum &> /dev/null; then
                ./bin/mark help generate | gum format
            else
                ./bin/mark help generate
            fi
            echo ""
            if declare -f gum_info >/dev/null; then
                gum_info "Press Enter to continue..."
            else
                echo "Press Enter to continue..."
            fi
            gum input --placeholder="" --width=1 > /dev/null
            show_core_commands_help
            ;;
        "list")
            if command -v gum &> /dev/null; then
                ./bin/mark help list | gum format
            else
                ./bin/mark help list
            fi
            echo ""
            if declare -f gum_info >/dev/null; then
                gum_info "Press Enter to continue..."
            else
                echo "Press Enter to continue..."
            fi
            gum input --placeholder="" --width=1 > /dev/null
            show_core_commands_help
            ;;
        "clear")
            if command -v gum &> /dev/null; then
                ./bin/mark help clear | gum format
            else
                ./bin/mark help clear
            fi
            echo ""
            if declare -f gum_info >/dev/null; then
                gum_info "Press Enter to continue..."
            else
                echo "Press Enter to continue..."
            fi
            gum input --placeholder="" --width=1 > /dev/null
            show_core_commands_help
            ;;
        "config")
            if command -v gum &> /dev/null; then
                ./bin/mark help config | gum format
            else
                ./bin/mark help config
            fi
            echo ""
            if declare -f gum_info >/dev/null; then
                gum_info "Press Enter to continue..."
            else
                echo "Press Enter to continue..."
            fi
            gum input --placeholder="" --width=1 > /dev/null
            show_core_commands_help
            ;;
        "template")
            if command -v gum &> /dev/null; then
                ./bin/mark help template | gum format
            else
                ./bin/mark help template
            fi
            echo ""
            if declare -f gum_info >/dev/null; then
                gum_info "Press Enter to continue..."
            else
                echo "Press Enter to continue..."
            fi
            gum input --placeholder="" --width=1 > /dev/null
            show_core_commands_help
            ;;
        "help")
            if command -v gum &> /dev/null; then
                ./bin/mark help help | gum format
            else
                ./bin/mark help help
            fi
            echo ""
            if declare -f gum_info >/dev/null; then
                gum_info "Press Enter to continue..."
            else
                echo "Press Enter to continue..."
            fi
            gum input --placeholder="" --width=1 > /dev/null
            show_core_commands_help
            ;;
        "Back to Help Navigator"|*)
            show_help_navigator
            ;;
    esac
}

# Show additional commands help
show_additional_commands_help() {
    if ! check_gum; then
        echo "Additional Commands:"
        echo "==================="
        echo ""
        echo "version    Show tool version information"
        echo "upgrade    Update to the latest version"
        echo "uninstall  Remove mark from your system"
        echo "tui        Launch full Terminal User Interface"
        echo ""
        read -p "Press Enter to continue..." </dev/null
        show_help_navigator
        return
    fi
    
    # Clear screen and show header
    if declare -f gum_clear_screen >/dev/null; then
        gum_clear_screen
    else
        clear
        if command -v gum &> /dev/null; then
            gum style --align center --bold "MARK - AI Prompt Templating Tool"
        else
            echo "MARK - AI Prompt Templating Tool"
        fi
        echo ""
    fi
    
    # Show section header
    if declare -f gum_section >/dev/null; then
        gum_section "Additional Commands"
    else
        gum style --bold "Additional Commands"
    fi
    echo ""
    
    # Show additional commands
    local commands=("version" "upgrade" "uninstall" "tui" "Back to Help Navigator")
    local command
    
    if declare -f gum_filter_option >/dev/null; then
        command=$(gum_filter_option "Select command for detailed help..." "${commands[@]}")
    else
        command=$(printf '%s\n' "${commands[@]}" | gum filter --placeholder="Select command for detailed help...")
    fi
    
    case "$command" in
        "version")
            if command -v gum &> /dev/null; then
                ./bin/mark help version | gum format
            else
                ./bin/mark help version
            fi
            echo ""
            if declare -f gum_info >/dev/null; then
                gum_info "Press Enter to continue..."
            else
                echo "Press Enter to continue..."
            fi
            gum input --placeholder="" --width=1 > /dev/null
            show_additional_commands_help
            ;;
        "upgrade")
            if command -v gum &> /dev/null; then
                ./bin/mark help upgrade | gum format
            else
                ./bin/mark help upgrade
            fi
            echo ""
            if declare -f gum_info >/dev/null; then
                gum_info "Press Enter to continue..."
            else
                echo "Press Enter to continue..."
            fi
            gum input --placeholder="" --width=1 > /dev/null
            show_additional_commands_help
            ;;
        "uninstall")
            if command -v gum &> /dev/null; then
                ./bin/mark help uninstall | gum format
            else
                ./bin/mark help uninstall
            fi
            echo ""
            if declare -f gum_info >/dev/null; then
                gum_info "Press Enter to continue..."
            else
                echo "Press Enter to continue..."
            fi
            gum input --placeholder="" --width=1 > /dev/null
            show_additional_commands_help
            ;;
        "tui")
            if command -v gum &> /dev/null; then
                ./bin/mark help tui | gum format
            else
                ./bin/mark help tui
            fi
            echo ""
            if declare -f gum_info >/dev/null; then
                gum_info "Press Enter to continue..."
            else
                echo "Press Enter to continue..."
            fi
            gum input --placeholder="" --width=1 > /dev/null
            show_additional_commands_help
            ;;
        "Back to Help Navigator"|*)
            show_help_navigator
            ;;
    esac
}

# Show configuration help
show_configuration_help() {
    if ! check_gum; then
        echo "Configuration Help:"
        echo "==================="
        echo ""
        echo "config set <key> <value>    Set a configuration value"
        echo "config get <key>            Retrieve a configuration value"
        echo "config list                 Display all configuration values"
        echo ""
        read -p "Press Enter to continue..." </dev/null
        show_help_navigator
        return
    fi
    
    # Clear screen and show header
    if declare -f gum_clear_screen >/dev/null; then
        gum_clear_screen
    else
        clear
        if command -v gum &> /dev/null; then
            gum style --align center --bold "MARK - AI Prompt Templating Tool"
        else
            echo "MARK - AI Prompt Templating Tool"
        fi
        echo ""
    fi
    
    # Show section header
    if declare -f gum_section >/dev/null; then
        gum_section "Configuration Help"
    else
        gum style --bold "Configuration Help"
    fi
    echo ""
    
    # Show configuration commands
    local commands=("config set" "config get" "config list" "Back to Help Navigator")
    local command
    
    if declare -f gum_filter_option >/dev/null; then
        command=$(gum_filter_option "Select configuration command..." "${commands[@]}")
    else
        command=$(printf '%s\n' "${commands[@]}" | gum filter --placeholder="Select configuration command...")
    fi
    
    case "$command" in
        "config set")
            if command -v gum &> /dev/null; then
                ./bin/mark help config | grep -A 10 "set" | gum format
            else
                echo "config set <key> <value>    Set a configuration value"
                echo "  Set a configuration value in the mark tool."
                echo ""
                echo "  Example:"
                echo "    mark config set editor nvim"
            fi
            echo ""
            if declare -f gum_info >/dev/null; then
                gum_info "Press Enter to continue..."
            else
                echo "Press Enter to continue..."
            fi
            gum input --placeholder="" --width=1 > /dev/null
            show_configuration_help
            ;;
        "config get")
            if command -v gum &> /dev/null; then
                ./bin/mark help config | grep -A 10 "get" | gum format
            else
                echo "config get <key>    Retrieve a configuration value"
                echo "  Retrieve a configuration value from the mark tool."
                echo ""
                echo "  Example:"
                echo "    mark config get editor"
            fi
            echo ""
            if declare -f gum_info >/dev/null; then
                gum_info "Press Enter to continue..."
            else
                echo "Press Enter to continue..."
            fi
            gum input --placeholder="" --width=1 > /dev/null
            show_configuration_help
            ;;
        "config list")
            if command -v gum &> /dev/null; then
                ./bin/mark help config | grep -A 10 "list" | gum format
            else
                echo "config list    Display all configuration values"
                echo "  Display all configuration values in the mark tool."
                echo ""
                echo "  Example:"
                echo "    mark config list"
            fi
            echo ""
            if declare -f gum_info >/dev/null; then
                gum_info "Press Enter to continue..."
            else
                echo "Press Enter to continue..."
            fi
            gum input --placeholder="" --width=1 > /dev/null
            show_configuration_help
            ;;
        "Back to Help Navigator"|*)
            show_help_navigator
            ;;
    esac
}

# Show templates help
show_templates_help() {
    if ! check_gum; then
        echo "Templates Help:"
        echo "==============="
        echo ""
        echo "template list              List all available templates"
        echo "template show <name>       Display the content of a template"
        echo "template new <name>        Create a new template file"
        echo "template edit <name>       Edit an existing template"
        echo "template delete <name>     Remove a template file"
        echo "template rename <old> <new> Rename a template file"
        echo ""
        read -p "Press Enter to continue..." </dev/null
        show_help_navigator
        return
    fi
    
    # Clear screen and show header
    if declare -f gum_clear_screen >/dev/null; then
        gum_clear_screen
    else
        clear
        if command -v gum &> /dev/null; then
            gum style --align center --bold "MARK - AI Prompt Templating Tool"
        else
            echo "MARK - AI Prompt Templating Tool"
        fi
        echo ""
    fi
    
    # Show section header
    if declare -f gum_section >/dev/null; then
        gum_section "Templates Help"
    else
        gum style --bold "Templates Help"
    fi
    echo ""
    
    # Show template commands
    local commands=("template list" "template show" "template new" "template edit" "template delete" "template rename" "Back to Help Navigator")
    local command
    
    if declare -f gum_filter_option >/dev/null; then
        command=$(gum_filter_option "Select template command..." "${commands[@]}")
    else
        command=$(printf '%s\n' "${commands[@]}" | gum filter --placeholder="Select template command...")
    fi
    
    case "$command" in
        "template list")
            if command -v gum &> /dev/null; then
                ./bin/mark help template | grep -A 10 "list" | gum format
            else
                echo "template list    List all available templates"
                echo "  List all available templates in the mark tool."
                echo ""
                echo "  Example:"
                echo "    mark template list"
            fi
            echo ""
            if declare -f gum_info >/dev/null; then
                gum_info "Press Enter to continue..."
            else
                echo "Press Enter to continue..."
            fi
            gum input --placeholder="" --width=1 > /dev/null
            show_templates_help
            ;;
        "template show")
            if command -v gum &> /dev/null; then
                ./bin/mark help template | grep -A 10 "show" | gum format
            else
                echo "template show <name>    Display the content of a template"
                echo "  Display the content of a template in the mark tool."
                echo ""
                echo "  Example:"
                echo "    mark template show welcome_email.md"
            fi
            echo ""
            if declare -f gum_info >/dev/null; then
                gum_info "Press Enter to continue..."
            else
                echo "Press Enter to continue..."
            fi
            gum input --placeholder="" --width=1 > /dev/null
            show_templates_help
            ;;
        "template new")
            if command -v gum &> /dev/null; then
                ./bin/mark help template | grep -A 10 "new" | gum format
            else
                echo "template new <name>    Create a new template file"
                echo "  Create a new template file in the mark tool."
                echo ""
                echo "  Example:"
                echo "    mark template new sales_pitch.md"
            fi
            echo ""
            if declare -f gum_info >/dev/null; then
                gum_info "Press Enter to continue..."
            else
                echo "Press Enter to continue..."
            fi
            gum input --placeholder="" --width=1 > /dev/null
            show_templates_help
            ;;
        "template edit")
            if command -v gum &> /dev/null; then
                ./bin/mark help template | grep -A 10 "edit" | gum format
            else
                echo "template edit <name>    Edit an existing template"
                echo "  Edit an existing template in the mark tool."
                echo ""
                echo "  Example:"
                echo "    mark template edit my_template.md"
            fi
            echo ""
            if declare -f gum_info >/dev/null; then
                gum_info "Press Enter to continue..."
            else
                echo "Press Enter to continue..."
            fi
            gum input --placeholder="" --width=1 > /dev/null
            show_templates_help
            ;;
        "template delete")
            if command -v gum &> /dev/null; then
                ./bin/mark help template | grep -A 10 "delete" | gum format
            else
                echo "template delete <name>    Remove a template file"
                echo "  Remove a template file from the mark tool."
                echo ""
                echo "  Example:"
                echo "    mark template delete old_template.md"
            fi
            echo ""
            if declare -f gum_info >/dev/null; then
                gum_info "Press Enter to continue..."
            else
                echo "Press Enter to continue..."
            fi
            gum input --placeholder="" --width=1 > /dev/null
            show_templates_help
            ;;
        "template rename")
            if command -v gum &> /dev/null; then
                ./bin/mark help template | grep -A 10 "rename" | gum format
            else
                echo "template rename <old> <new>    Rename a template file"
                echo "  Rename a template file in the mark tool."
                echo ""
                echo "  Example:"
                echo "    mark template rename current_name.md new_name.md"
            fi
            echo ""
            if declare -f gum_info >/dev/null; then
                gum_info "Press Enter to continue..."
            else
                echo "Press Enter to continue..."
            fi
            gum input --placeholder="" --width=1 > /dev/null
            show_templates_help
            ;;
        "Back to Help Navigator"|*)
            show_help_navigator
            ;;
    esac
}

# Show prompt generation help
show_prompt_generation_help() {
    if ! check_gum; then
        echo "Prompt Generation Help:"
        echo "======================="
        echo ""
        echo "generate <template> [data]    Process template with optional data file"
        echo "generate interactive           Interactive prompt generation wizard"
        echo ""
        read -p "Press Enter to continue..." </dev/null
        show_help_navigator
        return
    fi
    
    # Clear screen and show header
    if declare -f gum_clear_screen >/dev/null; then
        gum_clear_screen
    else
        clear
        if command -v gum &> /dev/null; then
            gum style --align center --bold "MARK - AI Prompt Templating Tool"
        else
            echo "MARK - AI Prompt Templating Tool"
        fi
        echo ""
    fi
    
    # Show section header
    if declare -f gum_section >/dev/null; then
        gum_section "Prompt Generation Help"
    else
        gum style --bold "Prompt Generation Help"
    fi
    echo ""
    
    # Show prompt generation commands
    local commands=("generate" "generate interactive" "Back to Help Navigator")
    local command
    
    if declare -f gum_filter_option >/dev/null; then
        command=$(gum_filter_option "Select generation command..." "${commands[@]}")
    else
        command=$(printf '%s\n' "${commands[@]}" | gum filter --placeholder="Select generation command...")
    fi
    
    case "$command" in
        "generate")
            if command -v gum &> /dev/null; then
                ./bin/mark help generate | gum format
            else
                echo "generate <template> [data]    Process template with optional data file"
                echo "  Process a template file with optional data to generate a prompt."
                echo ""
                echo "  Example:"
                echo "    mark generate welcome_email.md user_data.txt"
            fi
            echo ""
            if declare -f gum_info >/dev/null; then
                gum_info "Press Enter to continue..."
            else
                echo "Press Enter to continue..."
            fi
            gum input --placeholder="" --width=1 > /dev/null
            show_prompt_generation_help
            ;;
        "generate interactive")
            if command -v gum &> /dev/null; then
                ./bin/mark help generate | grep -A 20 "interactive" | gum format
            else
                echo "generate interactive    Interactive prompt generation wizard"
                echo "  Launch the interactive prompt generation wizard."
                echo ""
                echo "  Example:"
                echo "    mark generate interactive"
            fi
            echo ""
            if declare -f gum_info >/dev/null; then
                gum_info "Press Enter to continue..."
            else
                echo "Press Enter to continue..."
            fi
            gum input --placeholder="" --width=1 > /dev/null
            show_prompt_generation_help
            ;;
        "Back to Help Navigator"|*)
            show_help_navigator
            ;;
    esac
}

# Show system operations help
show_system_operations_help() {
    if ! check_gum; then
        echo "System Operations Help:"
        echo "======================"
        echo ""
        echo "upgrade    Update to the latest version"
        echo "uninstall  Remove mark from your system"
        echo "tui        Launch full Terminal User Interface"
        echo ""
        read -p "Press Enter to continue..." </dev/null
        show_help_navigator
        return
    fi
    
    # Clear screen and show header
    if declare -f gum_clear_screen >/dev/null; then
        gum_clear_screen
    else
        clear
        if command -v gum &> /dev/null; then
            gum style --align center --bold "MARK - AI Prompt Templating Tool"
        else
            echo "MARK - AI Prompt Templating Tool"
        fi
        echo ""
    fi
    
    # Show section header
    if declare -f gum_section >/dev/null; then
        gum_section "System Operations Help"
    else
        gum style --bold "System Operations Help"
    fi
    echo ""
    
    # Show system operations commands
    local commands=("upgrade" "uninstall" "tui" "Back to Help Navigator")
    local command
    
    if declare -f gum_filter_option >/dev/null; then
        command=$(gum_filter_option "Select system operation..." "${commands[@]}")
    else
        command=$(printf '%s\n' "${commands[@]}" | gum filter --placeholder="Select system operation...")
    fi
    
    case "$command" in
        "upgrade")
            if command -v gum &> /dev/null; then
                ./bin/mark help upgrade | gum format
            else
                echo "upgrade    Update to the latest version"
                echo "  Update mark to the latest version from the official repository."
                echo ""
                echo "  Example:"
                echo "    mark upgrade"
            fi
            echo ""
            if declare -f gum_info >/dev/null; then
                gum_info "Press Enter to continue..."
            else
                echo "Press Enter to continue..."
            fi
            gum input --placeholder="" --width=1 > /dev/null
            show_system_operations_help
            ;;
        "uninstall")
            if command -v gum &> /dev/null; then
                ./bin/mark help uninstall | gum format
            else
                echo "uninstall  Remove mark from your system"
                echo "  Completely remove mark from your system."
                echo ""
                echo "  Example:"
                echo "    mark uninstall"
            fi
            echo ""
            if declare -f gum_info >/dev/null; then
                gum_info "Press Enter to continue..."
            else
                echo "Press Enter to continue..."
            fi
            gum input --placeholder="" --width=1 > /dev/null
            show_system_operations_help
            ;;
        "tui")
            if command -v gum &> /dev/null; then
                ./bin/mark help tui | gum format
            else
                echo "tui    Launch full Terminal User Interface"
                echo "  Launch the full Terminal User Interface dashboard for mark."
                echo ""
                echo "  Example:"
                echo "    mark tui"
            fi
            echo ""
            if declare -f gum_info >/dev/null; then
                gum_info "Press Enter to continue..."
            else
                echo "Press Enter to continue..."
            fi
            gum input --placeholder="" --width=1 > /dev/null
            show_system_operations_help
            ;;
        "Back to Help Navigator"|*)
            show_help_navigator
            ;;
    esac
}