#!/bin/bash

# mark - Help command

# Help function
show_help() {
    cat << 'EOF'
mark - AI prompt templating tool

USAGE:
    mark <COMMAND> [OPTIONS]

COMMANDS:
    generate <template> [data]    Generate prompt from template
    list                          List recently generated prompts
    clear                         Clear all logs
    help                          Show this help message

FEATURES:
    - Placeholders: {{variable_name}}
    - File substitution: {{@file_path}}
    - Data files: key=value format
    - Environment variables
    - Conditional blocks: {{#if condition}}...{{/if}}
    - Loop blocks: {{#each array}}...{{/each}}

EXAMPLES:
    mark generate my_template.md
    mark generate my_template.md data.md
    mark list
    mark clear
    mark help
EOF
}