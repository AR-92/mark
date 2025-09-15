#!/bin/bash

# mark - Help command with colorful output

# Source color utilities if available
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$SCRIPT_DIR/../"
if [[ -f "$LIB_DIR/utils/colors.sh" ]]; then
    source "$LIB_DIR/utils/colors.sh"
fi

# Define emojis for help sections
EMOJI_TOOL="🔧"
EMOJI_VERSION="📦"
EMOJI_USAGE="📋"
EMOJI_COMMANDS="🚀"
EMOJI_FEATURES="✨"
EMOJI_WIZARD="🧙"
EMOJI_EXAMPLES="💡"
EMOJI_INFO="ℹ️"

# Default emojis if not defined
: ${EMOJI_TOOL:="🔧"}
: ${EMOJI_VERSION:="📦"}
: ${EMOJI_USAGE:="📋"}
: ${EMOJI_COMMANDS:="🚀"}
: ${EMOJI_FEATURES:="✨"}
: ${EMOJI_WIZARD:="🧙"}
: ${EMOJI_EXAMPLES:="💡"}
: ${EMOJI_INFO:="ℹ️"}

# Define colors if not available
: ${COLOR_RESET:='\033[0m'}
: ${COLOR_BOLD:='\033[1m'}
: ${COLOR_GREEN:='\033[0;32m'}
: ${COLOR_BLUE:='\033[0;34m'}
: ${COLOR_CYAN:='\033[0;36m'}
: ${COLOR_YELLOW:='\033[0;33m'}
: ${COLOR_PURPLE:='\033[0;35m'}
: ${COLOR_RED:='\033[0;31m'}
: ${COLOR_BG_BLUE:='\033[44m'}
: ${COLOR_BG_CYAN:='\033[46m'}
: ${COLOR_BG_GREEN:='\033[42m'}
: ${COLOR_BG_YELLOW:='\033[43m'}
: ${COLOR_BG_PURPLE:='\033[45m'}

# More beautiful color palette
: ${COLOR_BRIGHT_BLUE:='\033[1;34m'}
: ${COLOR_BRIGHT_GREEN:='\033[1;32m'}
: ${COLOR_BRIGHT_CYAN:='\033[1;36m'}
: ${COLOR_BRIGHT_YELLOW:='\033[1;33m'}
: ${COLOR_BRIGHT_PURPLE:='\033[1;35m'}
: ${COLOR_BRIGHT_RED:='\033[1;31m'}
: ${COLOR_ORANGE:='\033[38;5;208m'}
: ${COLOR_PINK:='\033[38;5;207m'}
: ${COLOR_MAGENTA:='\033[38;5;198m'}
: ${COLOR_LIME:='\033[38;5;154m'}
: ${COLOR_BG_MAGENTA:='\033[48;5;198m'}
: ${COLOR_BG_ORANGE:='\033[48;5;208m'}
: ${COLOR_BG_PINK:='\033[48;5;207m'}
: ${COLOR_BG_LIME:='\033[48;5;154m'}

# Help function with colors and emojis
show_help() {
    echo -e "${COLOR_BG_MAGENTA}${COLOR_BOLD}${COLOR_WHITE} ${EMOJI_TOOL} mark 1.0.0 - AI prompt templating tool ${COLOR_RESET}"
    echo ""
    
    echo -e "${COLOR_BG_BLUE}${COLOR_BOLD}${COLOR_WHITE} ${EMOJI_USAGE} USAGE ${COLOR_RESET}"
    echo -e "    ${COLOR_BRIGHT_GREEN}mark${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}<COMMAND>${COLOR_RESET} ${COLOR_BRIGHT_CYAN}[OPTIONS]${COLOR_RESET}"
    echo ""
    
    echo -e "${COLOR_BG_CYAN}${COLOR_BOLD}${COLOR_BLACK} ${EMOJI_COMMANDS} COMMANDS ${COLOR_RESET}"
    echo -e "    ${COLOR_BRIGHT_PURPLE}generate${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}<template>${COLOR_RESET} ${COLOR_BRIGHT_CYAN}[data]${COLOR_RESET}    ${COLOR_BRIGHT_GREEN}Generate prompt from template${COLOR_RESET} ${EMOJI_TOOL}"
    echo -e "    ${COLOR_BRIGHT_PURPLE}list${COLOR_RESET}                          ${COLOR_BRIGHT_GREEN}List recently generated prompts${COLOR_RESET} ${EMOJI_LIST:-📋}"
    echo -e "    ${COLOR_BRIGHT_PURPLE}clear${COLOR_RESET}                         ${COLOR_BRIGHT_GREEN}Clear all logs${COLOR_RESET} ${EMOJI_CLEAR:-🧹}"
    echo -e "    ${COLOR_BRIGHT_PURPLE}config${COLOR_RESET} ${COLOR_BRIGHT_CYAN}[set|get|list]${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}[key]${COLOR_RESET} ${COLOR_BRIGHT_CYAN}[value]${COLOR_RESET}  ${COLOR_BRIGHT_GREEN}Manage configuration${COLOR_RESET} ${EMOJI_CONFIG:-⚙️}"
    echo -e "    ${COLOR_BRIGHT_PURPLE}template${COLOR_RESET} ${COLOR_BRIGHT_CYAN}[list|show|new|edit|delete|rename]${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}[args]${COLOR_RESET}  ${COLOR_BRIGHT_GREEN}Manage templates${COLOR_RESET} ${EMOJI_TEMPLATE:-📄}"
    echo -e "    ${COLOR_BRIGHT_PURPLE}upgrade${COLOR_RESET}                       ${COLOR_BRIGHT_GREEN}Upgrade mark to latest version${COLOR_RESET} ${EMOJI_UPGRADE:-⬆️}"
    echo -e "    ${COLOR_BRIGHT_PURPLE}uninstall${COLOR_RESET}                     ${COLOR_BRIGHT_GREEN}Uninstall mark from your system${COLOR_RESET} ${EMOJI_UNINSTALL:-🗑️}"
    echo -e "    ${COLOR_BRIGHT_PURPLE}version${COLOR_RESET}                       ${COLOR_BRIGHT_GREEN}Show version information${COLOR_RESET} ${EMOJI_VERSION}"
    echo -e "    ${COLOR_BRIGHT_PURPLE}help${COLOR_RESET}                          ${COLOR_BRIGHT_GREEN}Show this help message${COLOR_RESET} ${EMOJI_HELP:-❓}"
    echo ""
    
    echo -e "${COLOR_BG_ORANGE}${COLOR_BOLD}${COLOR_BLACK} ${EMOJI_FEATURES} FEATURES ${COLOR_RESET}"
    echo -e "    ${COLOR_BOLD}${COLOR_BRIGHT_CYAN}-${COLOR_RESET} ${COLOR_BRIGHT_GREEN}Placeholders${COLOR_RESET}: ${COLOR_BRIGHT_YELLOW}{{variable_name}}${COLOR_RESET} ${EMOJI_PLACEHOLDER:-📌}"
    echo -e "    ${COLOR_BOLD}${COLOR_BRIGHT_CYAN}-${COLOR_RESET} ${COLOR_BRIGHT_GREEN}File substitution${COLOR_RESET}: ${COLOR_BRIGHT_YELLOW}{{@file_path}}${COLOR_RESET} ${EMOJI_FILE:-📁}"
    echo -e "    ${COLOR_BOLD}${COLOR_BRIGHT_CYAN}-${COLOR_RESET} ${COLOR_BRIGHT_GREEN}Data files${COLOR_RESET}: ${COLOR_BRIGHT_YELLOW}key=value${COLOR_RESET} format ${EMOJI_DATA:-📝}"
    echo -e "    ${COLOR_BOLD}${COLOR_BRIGHT_CYAN}-${COLOR_RESET} ${COLOR_BRIGHT_GREEN}Environment variables${COLOR_RESET} ${EMOJI_ENV:-🌍}"
    echo -e "    ${COLOR_BOLD}${COLOR_BRIGHT_CYAN}-${COLOR_RESET} ${COLOR_BRIGHT_GREEN}Conditional blocks${COLOR_RESET}: ${COLOR_BRIGHT_YELLOW}{{#if condition}}...{{/if}}${COLOR_RESET} ${EMOJI_CONDITIONAL:-🔀}"
    echo -e "    ${COLOR_BOLD}${COLOR_BRIGHT_CYAN}-${COLOR_RESET} ${COLOR_BRIGHT_GREEN}Loop blocks${COLOR_RESET}: ${COLOR_BRIGHT_YELLOW}{{#each array}}...{{/each}}${COLOR_RESET} ${EMOJI_LOOP:-🔁}"
    echo ""
    
    echo -e "${COLOR_BG_PINK}${COLOR_BOLD}${COLOR_WHITE} ${EMOJI_WIZARD} WIZARD MODE ${COLOR_RESET}"
    echo -e "    ${COLOR_BOLD}${COLOR_BRIGHT_CYAN}-${COLOR_RESET} ${COLOR_BRIGHT_GREEN}Interactive generation${COLOR_RESET}: ${COLOR_BRIGHT_YELLOW}mark generate --interactive${COLOR_RESET} ${EMOJI_INTERACTIVE:-🎮}"
    echo -e "    ${COLOR_BOLD}${COLOR_BRIGHT_CYAN}-${COLOR_RESET} ${COLOR_BRIGHT_GREEN}Template creation wizard${COLOR_RESET}: ${COLOR_BRIGHT_YELLOW}mark template new <name> --wizard${COLOR_RESET} ${EMOJI_WIZARD_NEW:-🎨}"
    echo ""
    
    echo -e "${COLOR_BG_LIME}${COLOR_BOLD}${COLOR_BLACK} ${EMOJI_EXAMPLES} EXAMPLES ${COLOR_RESET}"
    echo -e "    ${COLOR_BRIGHT_BLUE}mark${COLOR_RESET} ${COLOR_BRIGHT_PURPLE}generate${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}my_template.md${COLOR_RESET}"
    echo -e "    ${COLOR_BRIGHT_BLUE}mark${COLOR_RESET} ${COLOR_BRIGHT_PURPLE}generate${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}my_template.md${COLOR_RESET} ${COLOR_BRIGHT_CYAN}data.md${COLOR_RESET}"
    echo -e "    ${COLOR_BRIGHT_BLUE}mark${COLOR_RESET} ${COLOR_BRIGHT_PURPLE}generate${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}--interactive${COLOR_RESET}"
    echo -e "    ${COLOR_BRIGHT_BLUE}mark${COLOR_RESET} ${COLOR_BRIGHT_PURPLE}list${COLOR_RESET}"
    echo -e "    ${COLOR_BRIGHT_BLUE}mark${COLOR_RESET} ${COLOR_BRIGHT_PURPLE}clear${COLOR_RESET}"
    echo -e "    ${COLOR_BRIGHT_BLUE}mark${COLOR_RESET} ${COLOR_BRIGHT_PURPLE}config${COLOR_RESET} ${COLOR_BRIGHT_GREEN}set${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}editor${COLOR_RESET} ${COLOR_BRIGHT_CYAN}nvim${COLOR_RESET}"
    echo -e "    ${COLOR_BRIGHT_BLUE}mark${COLOR_RESET} ${COLOR_BRIGHT_PURPLE}config${COLOR_RESET} ${COLOR_BRIGHT_GREEN}get${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}editor${COLOR_RESET}"
    echo -e "    ${COLOR_BRIGHT_BLUE}mark${COLOR_RESET} ${COLOR_BRIGHT_PURPLE}config${COLOR_RESET} ${COLOR_BRIGHT_GREEN}list${COLOR_RESET}"
    echo -e "    ${COLOR_BRIGHT_BLUE}mark${COLOR_RESET} ${COLOR_BRIGHT_PURPLE}template${COLOR_RESET} ${COLOR_BRIGHT_GREEN}list${COLOR_RESET}"
    echo -e "    ${COLOR_BRIGHT_BLUE}mark${COLOR_RESET} ${COLOR_BRIGHT_PURPLE}template${COLOR_RESET} ${COLOR_BRIGHT_GREEN}show${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}my_template.md${COLOR_RESET}"
    echo -e "    ${COLOR_BRIGHT_BLUE}mark${COLOR_RESET} ${COLOR_BRIGHT_PURPLE}template${COLOR_RESET} ${COLOR_BRIGHT_GREEN}new${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}my_new_template${COLOR_RESET} ${COLOR_BRIGHT_CYAN}--wizard${COLOR_RESET}"
    echo -e "    ${COLOR_BRIGHT_BLUE}mark${COLOR_RESET} ${COLOR_BRIGHT_PURPLE}template${COLOR_RESET} ${COLOR_BRIGHT_GREEN}edit${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}my_template.md${COLOR_RESET}"
    echo -e "    ${COLOR_BRIGHT_BLUE}mark${COLOR_RESET} ${COLOR_BRIGHT_PURPLE}template${COLOR_RESET} ${COLOR_BRIGHT_GREEN}delete${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}my_template.md${COLOR_RESET}"
    echo -e "    ${COLOR_BRIGHT_BLUE}mark${COLOR_RESET} ${COLOR_BRIGHT_PURPLE}template${COLOR_RESET} ${COLOR_BRIGHT_GREEN}rename${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}old_name${COLOR_RESET} ${COLOR_BRIGHT_CYAN}new_name${COLOR_RESET}"
    echo -e "    ${COLOR_BRIGHT_BLUE}mark${COLOR_RESET} ${COLOR_BRIGHT_PURPLE}upgrade${COLOR_RESET}"
    echo -e "    ${COLOR_BRIGHT_BLUE}mark${COLOR_RESET} ${COLOR_BRIGHT_PURPLE}uninstall${COLOR_RESET}"
    echo -e "    ${COLOR_BRIGHT_BLUE}mark${COLOR_RESET} ${COLOR_BRIGHT_PURPLE}version${COLOR_RESET}"
    echo -e "    ${COLOR_BRIGHT_BLUE}mark${COLOR_RESET} ${COLOR_BRIGHT_PURPLE}help${COLOR_RESET}"
    echo ""
    
    echo -e "${COLOR_BOLD}${COLOR_BRIGHT_GREEN}${EMOJI_INFO} For detailed help: ${COLOR_RESET}${COLOR_BRIGHT_YELLOW}mark help <command>${COLOR_RESET}"
}

# Detailed help for specific commands
show_detailed_help() {
    case "$1" in
        generate)
            echo -e "${COLOR_BG_MAGENTA}${COLOR_BOLD}${COLOR_WHITE} GENERATE - Create output from templates ${COLOR_RESET}"
            echo ""
            echo -e "${COLOR_BG_BLUE}${COLOR_BOLD}${COLOR_WHITE} USAGE ${COLOR_RESET}"
            echo -e "    ${COLOR_BRIGHT_GREEN}mark${COLOR_RESET} ${COLOR_BRIGHT_PURPLE}generate${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}<template_name>${COLOR_RESET} ${COLOR_BRIGHT_CYAN}[data_file]${COLOR_RESET} ${COLOR_BRIGHT_CYAN}[OPTIONS]${COLOR_RESET}"
            echo ""
            echo -e "${COLOR_BG_CYAN}${COLOR_BOLD}${COLOR_BLACK} DESCRIPTION ${COLOR_RESET}"
            echo -e "    ${COLOR_BRIGHT_GREEN}Generate output by processing a template with provided data.${COLOR_RESET}"
            echo ""
            echo -e "${COLOR_BG_ORANGE}${COLOR_BOLD}${COLOR_BLACK} OPTIONS ${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_BRIGHT_CYAN}--out${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}<file>${COLOR_RESET}          ${COLOR_BRIGHT_GREEN}Write output to file instead of stdout${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_BRIGHT_CYAN}--template-dir${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}<dir>${COLOR_RESET}  ${COLOR_BRIGHT_GREEN}Use additional template directory${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_BRIGHT_CYAN}--interactive${COLOR_RESET}         ${COLOR_BRIGHT_GREEN}Interactive mode with guided input${COLOR_RESET} ${EMOJI_INTERACTIVE:-🎮}"
            echo -e "    ${COLOR_BOLD}${COLOR_BRIGHT_CYAN}--fuzzy${COLOR_RESET}               ${COLOR_BRIGHT_GREEN}Use fuzzy finder for template selection${COLOR_RESET} ${EMOJI_FUZZY:-🎯}"
            echo -e "    ${COLOR_BOLD}${COLOR_BRIGHT_CYAN}--editor${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}<editor>${COLOR_RESET}     ${COLOR_BRIGHT_GREEN}Edit output in editor before saving${COLOR_RESET} ${EMOJI_EDITOR:-✏️}"
            echo -e "    ${COLOR_BOLD}${COLOR_BRIGHT_CYAN}--dry-run${COLOR_RESET}             ${COLOR_BRIGHT_GREEN}Show output without saving${COLOR_RESET} ${EMOJI_PREVIEW:-👁️}"
            echo -e "    ${COLOR_BOLD}${COLOR_BRIGHT_CYAN}--force${COLOR_RESET}               ${COLOR_BRIGHT_GREEN}Overwrite existing files without prompting${COLOR_RESET} ${EMOJI_FORCE:-⚡}"
            echo ""
            echo -e "${COLOR_BG_PINK}${COLOR_BOLD}${COLOR_WHITE} EXAMPLES ${COLOR_RESET}"
            echo -e "    ${COLOR_BRIGHT_BLUE}mark${COLOR_RESET} ${COLOR_BRIGHT_PURPLE}generate${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}welcome_email${COLOR_RESET} ${COLOR_BRIGHT_CYAN}user_data.txt${COLOR_RESET}"
            echo -e "    ${COLOR_BRIGHT_BLUE}mark${COLOR_RESET} ${COLOR_BRIGHT_PURPLE}generate${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}report_template${COLOR_RESET} ${COLOR_BRIGHT_CYAN}--out${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}final_report.txt${COLOR_RESET}"
            echo -e "    ${COLOR_BRIGHT_BLUE}mark${COLOR_RESET} ${COLOR_BRIGHT_PURPLE}generate${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}--interactive${COLOR_RESET} ${COLOR_BRIGHT_CYAN}--fuzzy${COLOR_RESET}"
            echo -e "    ${COLOR_BRIGHT_BLUE}mark${COLOR_RESET} ${COLOR_BRIGHT_PURPLE}generate${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}invoice${COLOR_RESET} ${COLOR_BRIGHT_CYAN}--template-dir${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}~/my-templates${COLOR_RESET}"
            ;;
        template)
            echo -e "${COLOR_BG_MAGENTA}${COLOR_BOLD}${COLOR_WHITE} TEMPLATE - Manage templates ${COLOR_RESET}"
            echo ""
            echo -e "${COLOR_BG_BLUE}${COLOR_BOLD}${COLOR_WHITE} USAGE ${COLOR_RESET}"
            echo -e "    ${COLOR_BRIGHT_GREEN}mark${COLOR_RESET} ${COLOR_BRIGHT_PURPLE}template${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}<SUBCOMMAND>${COLOR_RESET} ${COLOR_BRIGHT_CYAN}[ARGS]${COLOR_RESET} ${COLOR_BRIGHT_CYAN}[OPTIONS]${COLOR_RESET}"
            echo ""
            echo -e "${COLOR_BG_CYAN}${COLOR_BOLD}${COLOR_BLACK} SUBCOMMANDS ${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_BRIGHT_CYAN}list${COLOR_RESET}                  ${COLOR_BRIGHT_GREEN}List all templates${COLOR_RESET} ${EMOJI_LIST:-📋}"
            echo -e "    ${COLOR_BOLD}${COLOR_BRIGHT_CYAN}show${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}<name>${COLOR_RESET}           ${COLOR_BRIGHT_GREEN}Show template content${COLOR_RESET} ${EMOJI_SHOW:-👀}"
            echo -e "    ${COLOR_BOLD}${COLOR_BRIGHT_CYAN}new${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}<name>${COLOR_RESET}            ${COLOR_BRIGHT_GREEN}Create new template${COLOR_RESET} ${EMOJI_NEW:-➕}"
            echo -e "    ${COLOR_BOLD}${COLOR_BRIGHT_CYAN}new${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}<name>${COLOR_RESET} ${COLOR_BRIGHT_CYAN}--wizard${COLOR_RESET}   ${COLOR_BRIGHT_GREEN}Create new template with wizard${COLOR_RESET} ${EMOJI_WIZARD_NEW:-🎨}"
            echo -e "    ${COLOR_BOLD}${COLOR_BRIGHT_CYAN}edit${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}<name>${COLOR_RESET}           ${COLOR_BRIGHT_GREEN}Edit existing template${COLOR_RESET} ${EMOJI_EDIT:-✏️}"
            echo -e "    ${COLOR_BOLD}${COLOR_BRIGHT_CYAN}edit${COLOR_RESET} ${COLOR_BRIGHT_CYAN}--wizard${COLOR_RESET}         ${COLOR_BRIGHT_GREEN}Edit template with wizard${COLOR_RESET} ${EMOJI_WIZARD_EDIT:-🧙}"
            echo -e "    ${COLOR_BOLD}${COLOR_BRIGHT_CYAN}delete${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}<name>${COLOR_RESET}         ${COLOR_BRIGHT_GREEN}Delete template${COLOR_RESET} ${EMOJI_DELETE:-🗑️}"
            echo -e "    ${COLOR_BOLD}${COLOR_BRIGHT_CYAN}delete${COLOR_RESET} ${COLOR_BRIGHT_CYAN}--wizard${COLOR_RESET}       ${COLOR_BRIGHT_GREEN}Delete template with wizard${COLOR_RESET} ${EMOJI_WIZARD_DELETE:-🧙}"
            echo -e "    ${COLOR_BOLD}${COLOR_BRIGHT_CYAN}rename${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}<old>${COLOR_RESET} ${COLOR_BRIGHT_CYAN}<new>${COLOR_RESET}    ${COLOR_BRIGHT_GREEN}Rename template${COLOR_RESET} ${EMOJI_RENAME:-🏷️}"
            echo -e "    ${COLOR_BOLD}${COLOR_BRIGHT_CYAN}rename${COLOR_RESET} ${COLOR_BRIGHT_CYAN}--wizard${COLOR_RESET}       ${COLOR_BRIGHT_GREEN}Rename template with wizard${COLOR_RESET} ${EMOJI_WIZARD_RENAME:-🧙}"
            echo ""
            echo -e "${COLOR_BG_ORANGE}${COLOR_BOLD}${COLOR_BLACK} OPTIONS ${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_BRIGHT_CYAN}--template-dir${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}<dir>${COLOR_RESET}  ${COLOR_BRIGHT_GREEN}Use specific template directory${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_BRIGHT_CYAN}--editor${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}<editor>${COLOR_RESET}     ${COLOR_BRIGHT_GREEN}Use specific editor${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_BRIGHT_CYAN}--wizard${COLOR_RESET}              ${COLOR_BRIGHT_GREEN}Use guided wizard mode${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_BRIGHT_CYAN}--tag${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}<tag>${COLOR_RESET}           ${COLOR_BRIGHT_GREEN}Filter by or assign tags${COLOR_RESET}"
            echo ""
            echo -e "${COLOR_BG_PINK}${COLOR_BOLD}${COLOR_WHITE} EXAMPLES ${COLOR_RESET}"
            echo -e "    ${COLOR_BRIGHT_BLUE}mark${COLOR_RESET} ${COLOR_BRIGHT_PURPLE}template${COLOR_RESET} ${COLOR_BRIGHT_GREEN}list${COLOR_RESET}"
            echo -e "    ${COLOR_BRIGHT_BLUE}mark${COLOR_RESET} ${COLOR_BRIGHT_PURPLE}template${COLOR_RESET} ${COLOR_BRIGHT_GREEN}show${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}welcome_email${COLOR_RESET}"
            echo -e "    ${COLOR_BRIGHT_BLUE}mark${COLOR_RESET} ${COLOR_BRIGHT_PURPLE}template${COLOR_RESET} ${COLOR_BRIGHT_GREEN}new${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}sales_pitch${COLOR_RESET} ${COLOR_BRIGHT_CYAN}--wizard${COLOR_RESET}"
            echo -e "    ${COLOR_BRIGHT_BLUE}mark${COLOR_RESET} ${COLOR_BRIGHT_PURPLE}template${COLOR_RESET} ${COLOR_BRIGHT_GREEN}edit${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}my_template${COLOR_RESET}"
            echo -e "    ${COLOR_BRIGHT_BLUE}mark${COLOR_RESET} ${COLOR_BRIGHT_PURPLE}template${COLOR_RESET} ${COLOR_BRIGHT_GREEN}delete${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}old_template${COLOR_RESET}"
            echo -e "    ${COLOR_BRIGHT_BLUE}mark${COLOR_RESET} ${COLOR_BRIGHT_PURPLE}template${COLOR_RESET} ${COLOR_BRIGHT_GREEN}rename${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}current_name${COLOR_RESET} ${COLOR_BRIGHT_CYAN}new_name${COLOR_RESET}"
            ;;
        config)
            echo -e "${COLOR_BG_MAGENTA}${COLOR_BOLD}${COLOR_WHITE} CONFIG - Manage configuration ${COLOR_RESET}"
            echo ""
            echo -e "${COLOR_BG_BLUE}${COLOR_BOLD}${COLOR_WHITE} USAGE ${COLOR_RESET}"
            echo -e "    ${COLOR_BRIGHT_GREEN}mark${COLOR_RESET} ${COLOR_BRIGHT_PURPLE}config${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}<SUBCOMMAND>${COLOR_RESET} ${COLOR_BRIGHT_CYAN}[KEY]${COLOR_RESET} ${COLOR_BRIGHT_CYAN}[VALUE]${COLOR_RESET}"
            echo ""
            echo -e "${COLOR_BG_CYAN}${COLOR_BOLD}${COLOR_BLACK} SUBCOMMANDS ${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_BRIGHT_CYAN}set${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}<key>${COLOR_RESET} ${COLOR_BRIGHT_CYAN}<value>${COLOR_RESET}     ${COLOR_BRIGHT_GREEN}Set configuration value${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_BRIGHT_CYAN}get${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}<key>${COLOR_RESET}             ${COLOR_BRIGHT_GREEN}Get configuration value${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_BRIGHT_CYAN}list${COLOR_RESET}                  ${COLOR_BRIGHT_GREEN}List all configuration values${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_BRIGHT_CYAN}wizard${COLOR_RESET}                ${COLOR_BRIGHT_GREEN}Interactive configuration wizard${COLOR_RESET} ${EMOJI_WIZARD:-🧙}"
            echo ""
            echo -e "${COLOR_BG_ORANGE}${COLOR_BOLD}${COLOR_BLACK} CONFIGURABLE KEYS ${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_BRIGHT_CYAN}template_dirs${COLOR_RESET}         ${COLOR_BRIGHT_GREEN}List of template directories (colon-separated)${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_BRIGHT_CYAN}default_template_dir${COLOR_RESET}  ${COLOR_BRIGHT_GREEN}Directory to use by default for new templates${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_BRIGHT_CYAN}editor${COLOR_RESET}                ${COLOR_BRIGHT_GREEN}Default editor for template new/edit${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_BRIGHT_CYAN}use_fzf${COLOR_RESET}               ${COLOR_BRIGHT_GREEN}Whether to use fuzzy finder when selecting templates${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_BRIGHT_CYAN}data_file_formats${COLOR_RESET}     ${COLOR_BRIGHT_GREEN}Allowed formats for data input (json, yaml, toml)${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_BRIGHT_CYAN}wizard_questions${COLOR_RESET}      ${COLOR_BRIGHT_GREEN}Default questions for wizard mode templates${COLOR_RESET}"
            echo ""
            echo -e "${COLOR_BG_PINK}${COLOR_BOLD}${COLOR_WHITE} EXAMPLES ${COLOR_RESET}"
            echo -e "    ${COLOR_BRIGHT_BLUE}mark${COLOR_RESET} ${COLOR_BRIGHT_PURPLE}config${COLOR_RESET} ${COLOR_BRIGHT_GREEN}set${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}editor${COLOR_RESET} ${COLOR_BRIGHT_CYAN}nvim${COLOR_RESET}"
            echo -e "    ${COLOR_BRIGHT_BLUE}mark${COLOR_RESET} ${COLOR_BRIGHT_PURPLE}config${COLOR_RESET} ${COLOR_BRIGHT_GREEN}set${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}template_dirs${COLOR_RESET} ${COLOR_BRIGHT_CYAN}\"~/.mark/templates:/usr/share/mark\"${COLOR_RESET}"
            echo -e "    ${COLOR_BRIGHT_BLUE}mark${COLOR_RESET} ${COLOR_BRIGHT_PURPLE}config${COLOR_RESET} ${COLOR_BRIGHT_GREEN}get${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}editor${COLOR_RESET}"
            echo -e "    ${COLOR_BRIGHT_BLUE}mark${COLOR_RESET} ${COLOR_BRIGHT_PURPLE}config${COLOR_RESET} ${COLOR_BRIGHT_GREEN}list${COLOR_RESET}"
            echo -e "    ${COLOR_BRIGHT_BLUE}mark${COLOR_RESET} ${COLOR_BRIGHT_PURPLE}config${COLOR_RESET} ${COLOR_BRIGHT_GREEN}wizard${COLOR_RESET}"
            ;;
        upgrade)
            echo -e "${COLOR_BG_MAGENTA}${COLOR_BOLD}${COLOR_WHITE} UPGRADE - Upgrade mark to latest version ${COLOR_RESET}"
            echo ""
            echo -e "${COLOR_BG_BLUE}${COLOR_BOLD}${COLOR_WHITE} USAGE ${COLOR_RESET}"
            echo -e "    ${COLOR_BRIGHT_GREEN}mark${COLOR_RESET} ${COLOR_BRIGHT_PURPLE}upgrade${COLOR_RESET}"
            echo ""
            echo -e "${COLOR_BG_CYAN}${COLOR_BOLD}${COLOR_BLACK} DESCRIPTION ${COLOR_RESET}"
            echo -e "    ${COLOR_BRIGHT_GREEN}Upgrade mark CLI tool to the latest version from GitHub.${COLOR_RESET}"
            echo -e "    ${COLOR_BRIGHT_GREEN}Your templates and configuration will be preserved.${COLOR_RESET}"
            echo ""
            echo -e "${COLOR_BG_ORANGE}${COLOR_BOLD}${COLOR_BLACK} WHAT THIS DOES ${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_BRIGHT_CYAN}-${COLOR_RESET} ${COLOR_BRIGHT_GREEN}Downloads latest version from GitHub${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_BRIGHT_CYAN}-${COLOR_RESET} ${COLOR_BRIGHT_GREEN}Backs up current installation${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_BRIGHT_CYAN}-${COLOR_RESET} ${COLOR_BRIGHT_GREEN}Installs new version${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_BRIGHT_CYAN}-${COLOR_RESET} ${COLOR_BRIGHT_GREEN}Preserves templates and configuration${COLOR_RESET}"
            echo ""
            echo -e "${COLOR_BG_PINK}${COLOR_BOLD}${COLOR_WHITE} EXAMPLES ${COLOR_RESET}"
            echo -e "    ${COLOR_BRIGHT_BLUE}mark${COLOR_RESET} ${COLOR_BRIGHT_PURPLE}upgrade${COLOR_RESET}"
            ;;
        uninstall)
            echo -e "${COLOR_BG_MAGENTA}${COLOR_BOLD}${COLOR_WHITE} UNINSTALL - Remove mark from your system ${COLOR_RESET}"
            echo ""
            echo -e "${COLOR_BG_BLUE}${COLOR_BOLD}${COLOR_WHITE} USAGE ${COLOR_RESET}"
            echo -e "    ${COLOR_BRIGHT_GREEN}mark${COLOR_RESET} ${COLOR_BRIGHT_PURPLE}uninstall${COLOR_RESET}"
            echo ""
            echo -e "${COLOR_BG_CYAN}${COLOR_BOLD}${COLOR_BLACK} DESCRIPTION ${COLOR_RESET}"
            echo -e "    ${COLOR_BRIGHT_GREEN}Completely removes mark CLI tool from your system.${COLOR_RESET}"
            echo ""
            echo -e "${COLOR_BG_ORANGE}${COLOR_BOLD}${COLOR_BLACK} WHAT GETS REMOVED ${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_BRIGHT_CYAN}-${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}\$HOME/.local/bin/mark${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_BRIGHT_CYAN}-${COLOR_RESET} ${COLOR_BRIGHT_YELLOW}\$HOME/.local/lib/mark/${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_BRIGHT_CYAN}-${COLOR_RESET} ${COLOR_BRIGHT_GREEN}Configuration files in \$HOME/.mark/ (optional)${COLOR_RESET}"
            echo ""
            echo -e "${COLOR_BG_PINK}${COLOR_BOLD}${COLOR_WHITE} EXAMPLES ${COLOR_RESET}"
            echo -e "    ${COLOR_BRIGHT_BLUE}mark${COLOR_RESET} ${COLOR_BRIGHT_PURPLE}uninstall${COLOR_RESET}"
            ;;
        *)
            show_help
            ;;
    esac
}