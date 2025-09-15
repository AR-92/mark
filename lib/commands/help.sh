#!/bin/bash

# mark - Help command

# Help function
show_help() {
    cat << 'EOF'
mark 1.0.0 - AI prompt templating tool

USAGE:
    mark <COMMAND> [OPTIONS]

COMMANDS:
    generate <template> [data]    Generate prompt from template
    list                          List recently generated prompts
    clear                         Clear all logs
    config [set|get|list] [key] [value]  Manage configuration
    template [list|show|new|edit|delete|rename] [args]  Manage templates
    upgrade                       Upgrade mark to latest version
    version                       Show version information
    help                          Show this help message

FEATURES:
    - Placeholders: {{variable_name}}
    - File substitution: {{@file_path}}
    - Data files: key=value format
    - Environment variables
    - Conditional blocks: {{#if condition}}...{{/if}}
    - Loop blocks: {{#each array}}...{{/each}}

WIZARD MODE:
    - Interactive generation: mark generate --interactive
    - Template creation wizard: mark template new <name> --wizard

EXAMPLES:
    mark generate my_template.md
    mark generate my_template.md data.md
    mark generate --interactive
    mark list
    mark clear
    mark config set editor nvim
    mark config get editor
    mark config list
    mark template list
    mark template show my_template.md
    mark template new my_new_template --wizard
    mark template edit my_template.md
    mark template delete my_template.md
    mark template rename old_name new_name
    mark upgrade
    mark version
    mark help

For detailed help: mark help <command>
EOF
}

# Detailed help for specific commands
show_detailed_help() {
    case "$1" in
        generate)
            cat << 'EOF'
GENERATE - Create output from templates

USAGE:
    mark generate <template_name> [data_file] [OPTIONS]

DESCRIPTION:
    Generate output by processing a template with provided data.

OPTIONS:
    --out <file>          Write output to file instead of stdout
    --template-dir <dir>  Use additional template directory
    --interactive         Interactive mode with guided input
    --fuzzy               Use fuzzy finder for template selection
    --editor <editor>     Edit output in editor before saving
    --dry-run             Show output without saving
    --force               Overwrite existing files without prompting

EXAMPLES:
    mark generate welcome_email user_data.txt
    mark generate report_template --out final_report.txt
    mark generate --interactive --fuzzy
    mark generate invoice --template-dir ~/my-templates
EOF
            ;;
        template)
            cat << 'EOF'
TEMPLATE - Manage templates

USAGE:
    mark template <SUBCOMMAND> [ARGS] [OPTIONS]

SUBCOMMANDS:
    list                  List all templates
    show <name>           Show template content
    new <name>            Create new template
    new <name> --wizard   Create new template with wizard
    edit <name>           Edit existing template
    edit --wizard         Edit template with wizard
    delete <name>         Delete template
    delete --wizard       Delete template with wizard
    rename <old> <new>    Rename template
    rename --wizard       Rename template with wizard

OPTIONS:
    --template-dir <dir>  Use specific template directory
    --editor <editor>     Use specific editor
    --wizard              Use guided wizard mode
    --tag <tag>           Filter by or assign tags

EXAMPLES:
    mark template list
    mark template show welcome_email
    mark template new sales_pitch --wizard
    mark template edit my_template
    mark template delete old_template
    mark template rename current_name new_name
EOF
            ;;
        config)
            cat << 'EOF'
CONFIG - Manage configuration

USAGE:
    mark config <SUBCOMMAND> [KEY] [VALUE]

SUBCOMMANDS:
    set <key> <value>     Set configuration value
    get <key>             Get configuration value
    list                  List all configuration values
    wizard                Interactive configuration wizard

CONFIGURABLE KEYS:
    template_dirs         List of template directories (colon-separated)
    default_template_dir  Directory to use by default for new templates
    editor                Default editor for template new/edit
    use_fzf               Whether to use fuzzy finder when selecting templates
    data_file_formats     Allowed formats for data input (json, yaml, toml)

EXAMPLES:
    mark config set editor nvim
    mark config set template_dirs "~/.mark/templates:/usr/share/mark"
    mark config get editor
    mark config list
    mark config wizard
EOF
            ;;
        upgrade)
            cat << 'EOF'
UPGRADE - Upgrade mark to latest version

USAGE:
    mark upgrade

DESCRIPTION:
    Upgrade mark CLI tool to the latest version from GitHub.
    Your templates and configuration will be preserved.

WHAT THIS DOES:
    - Downloads latest version from GitHub
    - Backs up current installation
    - Installs new version
    - Preserves templates and configuration

OPTIONS:
    None

EXAMPLES:
    mark upgrade
EOF
            ;;
        *)
            show_help
            ;;
    esac
}