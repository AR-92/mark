#!/bin/bash

# mark - Enhanced Help command with Gum formatting
# Beautiful, formatted help pages using Gum's formatting capabilities

# Check if Gum is installed
check_gum() {
    command -v gum &> /dev/null
}

# Show formatted main help
show_help_formatted() {
    if check_gum; then
        # Use Gum formatting for a beautiful help page
        cat << 'EOF' | gum format -t markdown
# 🚀 MARK - AI Prompt Templating Tool v1.0.0

A powerful command-line tool for generating AI prompts from templates with dynamic placeholders, file inclusion, conditional logic, and iterative processing capabilities.

## 📖 USAGE

```bash
mark <COMMAND> [OPTIONS]
```

## 🎯 CORE COMMANDS

| Command | Description |
|---------|-------------|
| `generate <template> [data]` | Process template with optional data file |
| `list` | Show recently generated prompts |
| `clear` | Clear all log entries |
| `config [action] [key] [value]` | Manage tool configuration |
| `template [action] [args]` | Manage prompt templates |
| `about` | Display information about mark |
| `help` | Display this help information |

## ⚡ ADDITIONAL COMMANDS

| Command | Description |
|---------|-------------|
| `version` | Show tool version information |
| `upgrade` | Update to the latest version |
| `uninstall` | Remove mark from your system |
| `tui` | Launch full Terminal User Interface |

## 🌟 INTERACTIVE COMMANDS (require Gum)

| Command | Description |
|---------|-------------|
| `generate interactive` | Interactive prompt generation wizard |
| `template interactive` | Interactive template management |
| `tui` | Full Terminal User Interface dashboard |

## ✨ TEMPLATING FEATURES

- **Placeholders**: `{{variable_name}}` for simple variable substitution
- **File inclusion**: `{{@file_path}}` to include content from other files
- **Conditional blocks**: `{{#if condition}}...{{/if}}` for conditional content
- **Loop/iteration blocks**: `{{#each array}}...{{/each}}` for iterating over lists
- **Data files**: Key=value format for variable definitions
- **Environment variables**: Automatic integration with system environment

## 🚀 QUICK START EXAMPLES

```bash
# Generate a prompt from a template with data
mark generate welcome_email.md user_data.txt

# List all templates
mark template list

# Show a template's content
mark template show welcome_email.md

# Set your preferred editor
mark config set editor vim

# View recently generated prompts
mark list
```

## 📚 DOCUMENTATION

For detailed information:
- Run `mark help <command>` for specific command help
- See `TUI_DOCUMENTATION.md` for TUI interface documentation
- Visit [GitHub Repository](https://github.com/AR-92/mark) for complete documentation

---
💻 *Made with ❤️ for AI developers and prompt engineers*
EOF
    else
        # Fall back to plain text help
        show_help_plain
    fi
}

# Show plain text main help (fallback)
show_help_plain() {
    echo "MARK - AI Prompt Templating Tool v1.0.0"
    echo "========================================"
    echo ""
    echo "A powerful command-line tool for generating AI prompts from templates with dynamic placeholders,"
    echo "file inclusion, conditional logic, and iterative processing capabilities."
    echo ""
    echo "USAGE:"
    echo "    mark <COMMAND> [OPTIONS]"
    echo ""
    echo "CORE COMMANDS:"
    echo "    generate <template> [data]     Process template with optional data file"
    echo "    list                           Show recently generated prompts"
    echo "    clear                          Clear all log entries"
    echo "    config [action] [key] [value]  Manage tool configuration"
    echo "    template [action] [args]       Manage prompt templates"
    echo "    help                           Display this help information"
    echo ""
    echo "ADDITIONAL COMMANDS:"
    echo "    version                        Show tool version information"
    echo "    upgrade                        Update to the latest version"
    echo "    uninstall                      Remove mark from your system"
    echo "    tui                            Launch full Terminal User Interface"
    echo ""
    echo "INTERACTIVE COMMANDS (require Gum):"
    echo "    generate interactive           Interactive prompt generation wizard"
    echo "    template interactive           Interactive template management"
    echo "    tui                            Launch full Terminal User Interface"
    echo ""
    echo "TEMPLATING FEATURES:"
    echo "    • Placeholders: {{variable_name}}"
    echo "    • File inclusion: {{@file_path}}"
    echo "    • Conditional blocks: {{#if condition}}...{{/if}}"
    echo "    • Loop/iteration blocks: {{#each array}}...{{/each}}"
    echo "    • Data files with key=value format"
    echo "    • Environment variable integration"
    echo ""
    echo "QUICK START EXAMPLES:"
    echo "    mark generate welcome_email.md user_data.txt"
    echo "    mark template list"
    echo "    mark template show welcome_email.md"
    echo "    mark config set editor vim"
    echo "    mark list"
    echo ""
    echo "For detailed command help: mark help <command>"
    echo "For TUI documentation: see TUI_DOCUMENTATION.md"
    echo "Documentation: https://github.com/AR-92/mark"
}

# Show formatted detailed help for specific commands
show_detailed_help_formatted() {
    if ! check_gum; then
        # Fall back to plain text if Gum is not available
        show_detailed_help_plain "$1"
        return
    fi

    case "$1" in
        generate|g)
            cat << 'EOF' | gum format -t markdown
# 📝 MARK GENERATE

Process a template file with optional data to generate a prompt.

## 📖 USAGE

```bash
mark generate <template_file> [data_file] [OPTIONS]
mark generate interactive              # Interactive mode (requires Gum)
```

## 📝 DESCRIPTION

The generate command processes template files using the powerful mark templating engine. Templates can include placeholders, file inclusions, conditional blocks, and loops.

## 🎯 ARGUMENTS

| Argument | Description |
|----------|-------------|
| `<template_file>` | Path to the template file to process |
| `[data_file]` | Optional path to data file with key=value pairs |

## ⚙️ OPTIONS

| Option | Description |
|--------|-------------|
| `--out <file>` | Write output to specified file instead of stdout |
| `--template-dir <dir>` | Use additional template directory |

## 🌟 INTERACTIVE MODE

If you have Gum installed, you can use the interactive mode:

```bash
mark generate interactive    # Launch interactive prompt generation wizard
```

## 🚀 EXAMPLES

```bash
# Generate a prompt from a template
mark generate welcome_email.md

# Generate with data file
mark generate report_template.md data.txt

# Save output to file
mark generate invoice.md --out final_invoice.md

# Use interactive mode
mark generate interactive

# Short form
mark g welcome_email.md user_data.txt
```
EOF
            ;;
            
        template|t)
            cat << 'EOF' | gum format -t markdown
# 📁 MARK TEMPLATE

Manage prompt templates used by the mark templating engine.

## 📖 USAGE

```bash
mark template <SUBCOMMAND> [ARGS] [OPTIONS]
```

## 🎯 SUBCOMMANDS

| Command | Description |
|---------|-------------|
| `list` | List all available templates |
| `show <name>` | Display the content of a template |
| `new <name>` | Create a new template file |
| `edit <name>` | Edit an existing template |
| `delete <name>` | Remove a template file |
| `rename <old> <new>` | Rename a template file |

## 🌟 INTERACTIVE MODE

If you have Gum installed, you can use the interactive mode:

```bash
mark template interactive     # Launch interactive template manager
```

## ⚙️ OPTIONS

| Option | Description |
|--------|-------------|
| `--template-dir <dir>` | Use specific template directory |
| `--editor <editor>` | Use specific editor for new/edit |

## 🚀 EXAMPLES

```bash
# List all templates
mark template list

# Show a template
mark template show welcome_email.md

# Create a new template
mark template new sales_pitch.md

# Edit a template
mark template edit my_template.md

# Delete a template
mark template delete old_template.md

# Rename a template
mark template rename current_name.md new_name.md

# Use interactive mode
mark template interactive

# Short form
mark t list
```
EOF
            ;;
            
        config|cfg)
            cat << 'EOF' | gum format -t markdown
# ⚙️ MARK CONFIG

Manage mark tool configuration settings.

## 📖 USAGE

```bash
mark config <SUBCOMMAND> [KEY] [VALUE]
```

## 🎯 SUBCOMMANDS

| Command | Description |
|---------|-------------|
| `set <key> <value>` | Set a configuration value |
| `get <key>` | Retrieve a configuration value |
| `list` | Display all configuration values |

## 🔧 CONFIGURATION KEYS

| Key | Description |
|-----|-------------|
| `template_dirs` | Template search directories (colon-separated) |
| `default_template_dir` | Default directory for new templates |
| `editor` | Default editor for template creation/editing |
| `use_fzf` | Enable fuzzy finder for template selection |
| `data_file_formats` | Supported data file formats (json,yaml,toml) |

## 🚀 EXAMPLES

```bash
# Set editor
mark config set editor nvim

# Set template directories
mark config set template_dirs "~/.mark/templates:/usr/share/mark"

# Get editor setting
mark config get editor

# List all configuration
mark config list

# Short form
mark cfg set editor code
```
EOF
            ;;
            
        list|l)
            cat << 'EOF' | gum format -t markdown
# 📋 MARK LIST

Display recently generated prompts from the mark log.

## 📖 USAGE

```bash
mark list
```

## 📝 DESCRIPTION

Shows a chronological list of recently generated prompts with timestamps. This helps track prompt generation history and outputs.

## 🚀 EXAMPLES

```bash
# List recent prompts
mark list

# Short form
mark l
```
EOF
            ;;
            
        clear|c)
            cat << 'EOF' | gum format -t markdown
# 🧹 MARK CLEAR

Clear all entries from the mark log file.

## 📖 USAGE

```bash
mark clear
```

## 📝 DESCRIPTION

Removes all log entries from the mark log file, freeing disk space and clearing the prompt generation history.

## 🚀 EXAMPLES

```bash
# Clear logs
mark clear

# Short form
mark c
```
EOF
            ;;
            
        version|v)
            cat << 'EOF' | gum format -t markdown
# 🔢 MARK VERSION

Display version information for the mark tool.

## 📖 USAGE

```bash
mark version
```

## 📝 DESCRIPTION

Shows the current version of mark and build information.

## 🚀 EXAMPLES

```bash
# Show version
mark version

# Short form
mark v
```
EOF
            ;;
            
        tui)
            cat << 'EOF' | gum format -t markdown
# 💻 MARK TUI

Launch the full Terminal User Interface dashboard for mark.

## 📖 USAGE

```bash
mark tui
```

## 📝 DESCRIPTION

Opens a beautiful, interactive TUI dashboard that provides a complete graphical interface for all mark functionality using Gum components. Features a clean design with Solarized blue color scheme and enhanced visual elements.

## 📋 REQUIREMENTS

- Gum must be installed for the TUI to function properly
- Run `setup_gum.sh` if Gum is not installed

## 🌟 FEATURES

- **Completely box-free interface** for a modern, clean appearance
- Solarized blue color scheme
- Enhanced visual elements with animations
- Improved navigation flow with breadcrumbs
- Template management interface
- Prompt generation workflows
- Configuration management
- Help and documentation browser
- System operations (upgrade, uninstall)

## 🚀 EXAMPLES

```bash
# Launch enhanced TUI
mark tui
```
EOF
            ;;
            
        upgrade|u)
            cat << 'EOF' | gum format -t markdown
# 🔄 MARK UPGRADE

Update mark to the latest version from the official repository.

## 📖 USAGE

```bash
mark upgrade
```

## 📝 DESCRIPTION

Downloads and installs the latest version of mark from GitHub. Preserves existing templates and configuration during the update. Now includes enhanced upgrade functionality that properly handles all TUI files including the enhanced box-free version.

## 🔄 PROCESS

1. Checks for the latest version availability
2. Backs up the current installation
3. Downloads the latest release
4. Installs the updated version with all TUI files
5. Verifies the installation
6. Preserves existing templates and configuration

## 🚀 EXAMPLES

```bash
# Upgrade mark
mark upgrade

# Short form
mark u
```
EOF
            ;;
            
        uninstall|un)
            cat << 'EOF' | gum format -t markdown
# 🗑️ MARK UNINSTALL

Completely remove mark from your system.

## 📖 USAGE

```bash
mark uninstall
```

## 📝 DESCRIPTION

Removes all mark components from your system, including executables and libraries. Optionally preserves user templates and configuration.

## 🧼 REMOVALS

- Executable: `$HOME/.local/bin/mark`
- Libraries: `$HOME/.local/lib/mark/`
- Configuration: `$HOME/.mark/` (optional)

## 🚀 EXAMPLES

```bash
# Uninstall mark
mark uninstall

# Short form
mark un
```
EOF
            ;;
            
        help|h)
            cat << 'EOF' | gum format -t markdown
# ❓ MARK HELP

Display help information for mark commands.

## 📖 USAGE

```bash
mark help [command]
```

## 📝 DESCRIPTION

Shows general help information or detailed help for a specific command.

## 🎯 ARGUMENTS

| Argument | Description |
|----------|-------------|
| `[command]` | Optional command name for detailed help |

## 🚀 EXAMPLES

```bash
# Show main help
mark help

# Show help for generate command
mark help generate

# Show help for template command
mark help template

# Short form
mark h config
```
EOF
            ;;
            
        about|info)
            cat << 'EOF' | gum format -t markdown
# ❓ MARK ABOUT

Display information about mark and its features.

## 📖 USAGE

```bash
mark about
mark info
```

## 📝 DESCRIPTION

Shows detailed information about mark, its capabilities, and use cases.

## 🚀 EXAMPLES

```bash
# Show about information
mark about

# Alternative form
mark info
```
EOF
            ;;
    esac
}

# Show plain text detailed help (fallback)
show_detailed_help_plain() {
    # This will call the original help functions
    show_detailed_help "$1"
}

# Export the functions
export -f show_help_formatted
export -f show_detailed_help_formatted