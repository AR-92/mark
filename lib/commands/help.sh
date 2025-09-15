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

# Solaris-inspired color palette (blues, cyans, and complementary colors)
: ${COLOR_SOLAR_BLUE:='\033[38;5;33m'}
: ${COLOR_SOLAR_CYAN:='\033[38;5;45m'}
: ${COLOR_SOLAR_DARK_BLUE:='\033[38;5;25m'}
: ${COLOR_SOLAR_LIGHT_BLUE:='\033[38;5;117m'}
: ${COLOR_SOLAR_TEAL:='\033[38;5;43m'}
: ${COLOR_SOLAR_SKY: '\033[38;5;111m'}
: ${COLOR_SOLAR_NAVY: '\033[38;5;18m'}
: ${COLOR_SOLAR_AQUA: '\033[38;5;51m'}
: ${COLOR_SOLAR_STEEL: '\033[38;5;67m'}
: ${COLOR_BG_SOLAR_BLUE: '\033[48;5;25m'}
: ${COLOR_BG_SOLAR_CYAN: '\033[48;5;33m'}
: ${COLOR_BG_SOLAR_DARK: '\033[48;5;235m'}
: ${COLOR_BG_SOLAR_NAVY: '\033[48;5;18m'}
: ${COLOR_BG_SOLAR_STEEL: '\033[48;5;67m'}

# Help function with colors and emojis
show_help() {
    echo -e "${COLOR_BG_SOLAR_BLUE}${COLOR_BOLD}${COLOR_WHITE} ${EMOJI_TOOL} mark 1.0.0 - AI prompt templating tool ${COLOR_RESET}"
    echo ""
    
    echo -e "${COLOR_BG_SOLAR_CYAN}${COLOR_BOLD}${COLOR_WHITE} ${EMOJI_USAGE} USAGE ${COLOR_RESET}"
    echo -e "    ${COLOR_SOLAR_LIGHT_BLUE}mark${COLOR_RESET} ${COLOR_SOLAR_SKY}<COMMAND>${COLOR_RESET} ${COLOR_SOLAR_AQUA}[OPTIONS]${COLOR_RESET}"
    echo ""
    
    echo -e "${COLOR_BG_SOLAR_NAVY}${COLOR_BOLD}${COLOR_WHITE} ${EMOJI_COMMANDS} COMMANDS ${COLOR_RESET}"
    echo -e "    ${COLOR_SOLAR_CYAN}generate${COLOR_RESET} ${COLOR_SOLAR_SKY}<template>${COLOR_RESET} ${COLOR_SOLAR_AQUA}[data]${COLOR_RESET}    ${COLOR_SOLAR_TEAL}Generate prompt from template${COLOR_RESET} ${EMOJI_TOOL}"
    echo -e "    ${COLOR_SOLAR_CYAN}list${COLOR_RESET}                          ${COLOR_SOLAR_TEAL}List recently generated prompts${COLOR_RESET} ${EMOJI_LIST:-📋}"
    echo -e "    ${COLOR_SOLAR_CYAN}clear${COLOR_RESET}                         ${COLOR_SOLAR_TEAL}Clear all logs${COLOR_RESET} ${EMOJI_CLEAR:-🧹}"
    echo -e "    ${COLOR_SOLAR_CYAN}config${COLOR_RESET} ${COLOR_SOLAR_AQUA}[set|get|list]${COLOR_RESET} ${COLOR_SOLAR_SKY}[key]${COLOR_RESET} ${COLOR_SOLAR_AQUA}[value]${COLOR_RESET}  ${COLOR_SOLAR_TEAL}Manage configuration${COLOR_RESET} ${EMOJI_CONFIG:-⚙️}"
    echo -e "    ${COLOR_SOLAR_CYAN}template${COLOR_RESET} ${COLOR_SOLAR_AQUA}[list|show|new|edit|delete|rename]${COLOR_RESET} ${COLOR_SOLAR_SKY}[args]${COLOR_RESET}  ${COLOR_SOLAR_TEAL}Manage templates${COLOR_RESET} ${EMOJI_TEMPLATE:-📄}"
    echo -e "    ${COLOR_SOLAR_CYAN}upgrade${COLOR_RESET}                       ${COLOR_SOLAR_TEAL}Upgrade mark to latest version${COLOR_RESET} ${EMOJI_UPGRADE:-⬆️}"
    echo -e "    ${COLOR_SOLAR_CYAN}uninstall${COLOR_RESET}                     ${COLOR_SOLAR_TEAL}Uninstall mark from your system${COLOR_RESET} ${EMOJI_UNINSTALL:-🗑️}"
    echo -e "    ${COLOR_SOLAR_CYAN}version${COLOR_RESET}                       ${COLOR_SOLAR_TEAL}Show version information${COLOR_RESET} ${EMOJI_VERSION}"
    echo -e "    ${COLOR_SOLAR_CYAN}help${COLOR_RESET}                          ${COLOR_SOLAR_TEAL}Show this help message${COLOR_RESET} ${EMOJI_HELP:-❓}"
    echo ""
    
    echo -e "${COLOR_BG_SOLAR_DARK}${COLOR_BOLD}${COLOR_WHITE} ${EMOJI_FEATURES} FEATURES ${COLOR_RESET}"
    echo -e "    ${COLOR_BOLD}${COLOR_SOLAR_AQUA}-${COLOR_RESET} ${COLOR_SOLAR_TEAL}Placeholders${COLOR_RESET}: ${COLOR_SOLAR_SKY}{{variable_name}}${COLOR_RESET} ${EMOJI_PLACEHOLDER:-📌}"
    echo -e "    ${COLOR_BOLD}${COLOR_SOLAR_AQUA}-${COLOR_RESET} ${COLOR_SOLAR_TEAL}File substitution${COLOR_RESET}: ${COLOR_SOLAR_SKY}{{@file_path}}${COLOR_RESET} ${EMOJI_FILE:-📁}"
    echo -e "    ${COLOR_BOLD}${COLOR_SOLAR_AQUA}-${COLOR_RESET} ${COLOR_SOLAR_TEAL}Data files${COLOR_RESET}: ${COLOR_SOLAR_SKY}key=value${COLOR_RESET} format ${EMOJI_DATA:-📝}"
    echo -e "    ${COLOR_BOLD}${COLOR_SOLAR_AQUA}-${COLOR_RESET} ${COLOR_SOLAR_TEAL}Environment variables${COLOR_RESET} ${EMOJI_ENV:-🌍}"
    echo -e "    ${COLOR_BOLD}${COLOR_SOLAR_AQUA}-${COLOR_RESET} ${COLOR_SOLAR_TEAL}Conditional blocks${COLOR_RESET}: ${COLOR_SOLAR_SKY}{{#if condition}}...{{/if}}${COLOR_RESET} ${EMOJI_CONDITIONAL:-🔀}"
    echo -e "    ${COLOR_BOLD}${COLOR_SOLAR_AQUA}-${COLOR_RESET} ${COLOR_SOLAR_TEAL}Loop blocks${COLOR_RESET}: ${COLOR_SOLAR_SKY}{{#each array}}...{{/each}}${COLOR_RESET} ${EMOJI_LOOP:-🔁}"
    echo ""
    
    echo -e "${COLOR_BG_SOLAR_STEEL}${COLOR_BOLD}${COLOR_WHITE} ${EMOJI_WIZARD} WIZARD MODE ${COLOR_RESET}"
    echo -e "    ${COLOR_BOLD}${COLOR_SOLAR_AQUA}-${COLOR_RESET} ${COLOR_SOLAR_TEAL}Interactive generation${COLOR_RESET}: ${COLOR_SOLAR_SKY}mark generate --interactive${COLOR_RESET} ${EMOJI_INTERACTIVE:-🎮}"
    echo -e "    ${COLOR_BOLD}${COLOR_SOLAR_AQUA}-${COLOR_RESET} ${COLOR_SOLAR_TEAL}Template creation wizard${COLOR_RESET}: ${COLOR_SOLAR_SKY}mark template new <name> --wizard${COLOR_RESET} ${EMOJI_WIZARD_NEW:-🎨}"
    echo ""
    
    echo -e "${COLOR_BG_SOLAR_CYAN}${COLOR_BOLD}${COLOR_BLACK} ${EMOJI_EXAMPLES} EXAMPLES ${COLOR_RESET}"
    echo -e "    ${COLOR_SOLAR_LIGHT_BLUE}mark${COLOR_RESET} ${COLOR_SOLAR_CYAN}generate${COLOR_RESET} ${COLOR_SOLAR_SKY}my_template.md${COLOR_RESET}"
    echo -e "    ${COLOR_SOLAR_LIGHT_BLUE}mark${COLOR_RESET} ${COLOR_SOLAR_CYAN}generate${COLOR_RESET} ${COLOR_SOLAR_SKY}my_template.md${COLOR_RESET} ${COLOR_SOLAR_AQUA}data.md${COLOR_RESET}"
    echo -e "    ${COLOR_SOLAR_LIGHT_BLUE}mark${COLOR_RESET} ${COLOR_SOLAR_CYAN}generate${COLOR_RESET} ${COLOR_SOLAR_SKY}--interactive${COLOR_RESET}"
    echo -e "    ${COLOR_SOLAR_LIGHT_BLUE}mark${COLOR_RESET} ${COLOR_SOLAR_CYAN}list${COLOR_RESET}"
    echo -e "    ${COLOR_SOLAR_LIGHT_BLUE}mark${COLOR_RESET} ${COLOR_SOLAR_CYAN}clear${COLOR_RESET}"
    echo -e "    ${COLOR_SOLAR_LIGHT_BLUE}mark${COLOR_RESET} ${COLOR_SOLAR_CYAN}config${COLOR_RESET} ${COLOR_SOLAR_TEAL}set${COLOR_RESET} ${COLOR_SOLAR_SKY}editor${COLOR_RESET} ${COLOR_SOLAR_AQUA}nvim${COLOR_RESET}"
    echo -e "    ${COLOR_SOLAR_LIGHT_BLUE}mark${COLOR_RESET} ${COLOR_SOLAR_CYAN}config${COLOR_RESET} ${COLOR_SOLAR_TEAL}get${COLOR_RESET} ${COLOR_SOLAR_SKY}editor${COLOR_RESET}"
    echo -e "    ${COLOR_SOLAR_LIGHT_BLUE}mark${COLOR_RESET} ${COLOR_SOLAR_CYAN}config${COLOR_RESET} ${COLOR_SOLAR_TEAL}list${COLOR_RESET}"
    echo -e "    ${COLOR_SOLAR_LIGHT_BLUE}mark${COLOR_RESET} ${COLOR_SOLAR_CYAN}template${COLOR_RESET} ${COLOR_SOLAR_TEAL}list${COLOR_RESET}"
    echo -e "    ${COLOR_SOLAR_LIGHT_BLUE}mark${COLOR_RESET} ${COLOR_SOLAR_CYAN}template${COLOR_RESET} ${COLOR_SOLAR_TEAL}show${COLOR_RESET} ${COLOR_SOLAR_SKY}my_template.md${COLOR_RESET}"
    echo -e "    ${COLOR_SOLAR_LIGHT_BLUE}mark${COLOR_RESET} ${COLOR_SOLAR_CYAN}template${COLOR_RESET} ${COLOR_SOLAR_TEAL}new${COLOR_RESET} ${COLOR_SOLAR_SKY}my_new_template${COLOR_RESET} ${COLOR_SOLAR_AQUA}--wizard${COLOR_RESET}"
    echo -e "    ${COLOR_SOLAR_LIGHT_BLUE}mark${COLOR_RESET} ${COLOR_SOLAR_CYAN}template${COLOR_RESET} ${COLOR_SOLAR_TEAL}edit${COLOR_RESET} ${COLOR_SOLAR_SKY}my_template.md${COLOR_RESET}"
    echo -e "    ${COLOR_SOLAR_LIGHT_BLUE}mark${COLOR_RESET} ${COLOR_SOLAR_CYAN}template${COLOR_RESET} ${COLOR_SOLAR_TEAL}delete${COLOR_RESET} ${COLOR_SOLAR_SKY}my_template.md${COLOR_RESET}"
    echo -e "    ${COLOR_SOLAR_LIGHT_BLUE}mark${COLOR_RESET} ${COLOR_SOLAR_CYAN}template${COLOR_RESET} ${COLOR_SOLAR_TEAL}rename${COLOR_RESET} ${COLOR_SOLAR_SKY}old_name${COLOR_RESET} ${COLOR_SOLAR_AQUA}new_name${COLOR_RESET}"
    echo -e "    ${COLOR_SOLAR_LIGHT_BLUE}mark${COLOR_RESET} ${COLOR_SOLAR_CYAN}upgrade${COLOR_RESET}"
    echo -e "    ${COLOR_SOLAR_LIGHT_BLUE}mark${COLOR_RESET} ${COLOR_SOLAR_CYAN}uninstall${COLOR_RESET}"
    echo -e "    ${COLOR_SOLAR_LIGHT_BLUE}mark${COLOR_RESET} ${COLOR_SOLAR_CYAN}version${COLOR_RESET}"
    echo -e "    ${COLOR_SOLAR_LIGHT_BLUE}mark${COLOR_RESET} ${COLOR_SOLAR_CYAN}help${COLOR_RESET}"
    echo ""
    
    echo -e "${COLOR_BOLD}${COLOR_SOLAR_TEAL}${EMOJI_INFO} For detailed help: ${COLOR_RESET}${COLOR_SOLAR_SKY}mark help <command>${COLOR_RESET}"
}

# Detailed help for specific commands
show_detailed_help() {
    case "$1" in
        generate)
            echo -e "${COLOR_BG_SOLAR_BLUE}${COLOR_BOLD}${COLOR_WHITE} GENERATE - Create output from templates ${COLOR_RESET}"
            echo ""
            echo -e "${COLOR_BG_SOLAR_CYAN}${COLOR_BOLD}${COLOR_WHITE} USAGE ${COLOR_RESET}"
            echo -e "    ${COLOR_SOLAR_LIGHT_BLUE}mark${COLOR_RESET} ${COLOR_SOLAR_CYAN}generate${COLOR_RESET} ${COLOR_SOLAR_SKY}<template_name>${COLOR_RESET} ${COLOR_SOLAR_AQUA}[data_file]${COLOR_RESET} ${COLOR_SOLAR_AQUA}[OPTIONS]${COLOR_RESET}"
            echo ""
            echo -e "${COLOR_BG_SOLAR_NAVY}${COLOR_BOLD}${COLOR_WHITE} DESCRIPTION ${COLOR_RESET}"
            echo -e "    ${COLOR_SOLAR_TEAL}Generate output by processing a template with provided data.${COLOR_RESET}"
            echo ""
            echo -e "${COLOR_BG_SOLAR_DARK}${COLOR_BOLD}${COLOR_WHITE} OPTIONS ${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_SOLAR_AQUA}--out${COLOR_RESET} ${COLOR_SOLAR_SKY}<file>${COLOR_RESET}          ${COLOR_SOLAR_TEAL}Write output to file instead of stdout${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_SOLAR_AQUA}--template-dir${COLOR_RESET} ${COLOR_SOLAR_SKY}<dir>${COLOR_RESET}  ${COLOR_SOLAR_TEAL}Use additional template directory${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_SOLAR_AQUA}--interactive${COLOR_RESET}         ${COLOR_SOLAR_TEAL}Interactive mode with guided input${COLOR_RESET} ${EMOJI_INTERACTIVE:-🎮}"
            echo -e "    ${COLOR_BOLD}${COLOR_SOLAR_AQUA}--fuzzy${COLOR_RESET}               ${COLOR_SOLAR_TEAL}Use fuzzy finder for template selection${COLOR_RESET} ${EMOJI_FUZZY:-🎯}"
            echo -e "    ${COLOR_BOLD}${COLOR_SOLAR_AQUA}--editor${COLOR_RESET} ${COLOR_SOLAR_SKY}<editor>${COLOR_RESET}     ${COLOR_SOLAR_TEAL}Edit output in editor before saving${COLOR_RESET} ${EMOJI_EDITOR:-✏️}"
            echo -e "    ${COLOR_BOLD}${COLOR_SOLAR_AQUA}--dry-run${COLOR_RESET}             ${COLOR_SOLAR_TEAL}Show output without saving${COLOR_RESET} ${EMOJI_PREVIEW:-👁️}"
            echo -e "    ${COLOR_BOLD}${COLOR_SOLAR_AQUA}--force${COLOR_RESET}               ${COLOR_SOLAR_TEAL}Overwrite existing files without prompting${COLOR_RESET} ${EMOJI_FORCE:-⚡}"
            echo ""
            echo -e "${COLOR_BG_SOLAR_STEEL}${COLOR_BOLD}${COLOR_WHITE} EXAMPLES ${COLOR_RESET}"
            echo -e "    ${COLOR_SOLAR_LIGHT_BLUE}mark${COLOR_RESET} ${COLOR_SOLAR_CYAN}generate${COLOR_RESET} ${COLOR_SOLAR_SKY}welcome_email${COLOR_RESET} ${COLOR_SOLAR_AQUA}user_data.txt${COLOR_RESET}"
            echo -e "    ${COLOR_SOLAR_LIGHT_BLUE}mark${COLOR_RESET} ${COLOR_SOLAR_CYAN}generate${COLOR_RESET} ${COLOR_SOLAR_SKY}report_template${COLOR_RESET} ${COLOR_SOLAR_AQUA}--out${COLOR_RESET} ${COLOR_SOLAR_SKY}final_report.txt${COLOR_RESET}"
            echo -e "    ${COLOR_SOLAR_LIGHT_BLUE}mark${COLOR_RESET} ${COLOR_SOLAR_CYAN}generate${COLOR_RESET} ${COLOR_SOLAR_SKY}--interactive${COLOR_RESET} ${COLOR_SOLAR_AQUA}--fuzzy${COLOR_RESET}"
            echo -e "    ${COLOR_SOLAR_LIGHT_BLUE}mark${COLOR_RESET} ${COLOR_SOLAR_CYAN}generate${COLOR_RESET} ${COLOR_SOLAR_SKY}invoice${COLOR_RESET} ${COLOR_SOLAR_AQUA}--template-dir${COLOR_RESET} ${COLOR_SOLAR_SKY}~/my-templates${COLOR_RESET}"
            ;;
        template)
            echo -e "${COLOR_BG_SOLAR_BLUE}${COLOR_BOLD}${COLOR_WHITE} TEMPLATE - Manage templates ${COLOR_RESET}"
            echo ""
            echo -e "${COLOR_BG_SOLAR_CYAN}${COLOR_BOLD}${COLOR_WHITE} USAGE ${COLOR_RESET}"
            echo -e "    ${COLOR_SOLAR_LIGHT_BLUE}mark${COLOR_RESET} ${COLOR_SOLAR_CYAN}template${COLOR_RESET} ${COLOR_SOLAR_SKY}<SUBCOMMAND>${COLOR_RESET} ${COLOR_SOLAR_AQUA}[ARGS]${COLOR_RESET} ${COLOR_SOLAR_AQUA}[OPTIONS]${COLOR_RESET}"
            echo ""
            echo -e "${COLOR_BG_SOLAR_NAVY}${COLOR_BOLD}${COLOR_WHITE} SUBCOMMANDS ${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_SOLAR_AQUA}list${COLOR_RESET}                  ${COLOR_SOLAR_TEAL}List all templates${COLOR_RESET} ${EMOJI_LIST:-📋}"
            echo -e "    ${COLOR_BOLD}${COLOR_SOLAR_AQUA}show${COLOR_RESET} ${COLOR_SOLAR_SKY}<name>${COLOR_RESET}           ${COLOR_SOLAR_TEAL}Show template content${COLOR_RESET} ${EMOJI_SHOW:-👀}"
            echo -e "    ${COLOR_BOLD}${COLOR_SOLAR_AQUA}new${COLOR_RESET} ${COLOR_SOLAR_SKY}<name>${COLOR_RESET}            ${COLOR_SOLAR_TEAL}Create new template${COLOR_RESET} ${EMOJI_NEW:-➕}"
            echo -e "    ${COLOR_BOLD}${COLOR_SOLAR_AQUA}new${COLOR_RESET} ${COLOR_SOLAR_SKY}<name>${COLOR_RESET} ${COLOR_SOLAR_AQUA}--wizard${COLOR_RESET}   ${COLOR_SOLAR_TEAL}Create new template with wizard${COLOR_RESET} ${EMOJI_WIZARD_NEW:-🎨}"
            echo -e "    ${COLOR_BOLD}${COLOR_SOLAR_AQUA}edit${COLOR_RESET} ${COLOR_SOLAR_SKY}<name>${COLOR_RESET}           ${COLOR_SOLAR_TEAL}Edit existing template${COLOR_RESET} ${EMOJI_EDIT:-✏️}"
            echo -e "    ${COLOR_BOLD}${COLOR_SOLAR_AQUA}edit${COLOR_RESET} ${COLOR_SOLAR_AQUA}--wizard${COLOR_RESET}         ${COLOR_SOLAR_TEAL}Edit template with wizard${COLOR_RESET} ${EMOJI_WIZARD_EDIT:-🧙}"
            echo -e "    ${COLOR_BOLD}${COLOR_SOLAR_AQUA}delete${COLOR_RESET} ${COLOR_SOLAR_SKY}<name>${COLOR_RESET}         ${COLOR_SOLAR_TEAL}Delete template${COLOR_RESET} ${EMOJI_DELETE:-🗑️}"
            echo -e "    ${COLOR_BOLD}${COLOR_SOLAR_AQUA}delete${COLOR_RESET} ${COLOR_SOLAR_AQUA}--wizard${COLOR_RESET}       ${COLOR_SOLAR_TEAL}Delete template with wizard${COLOR_RESET} ${EMOJI_WIZARD_DELETE:-🧙}"
            echo -e "    ${COLOR_BOLD}${COLOR_SOLAR_AQUA}rename${COLOR_RESET} ${COLOR_SOLAR_SKY}<old>${COLOR_RESET} ${COLOR_SOLAR_AQUA}<new>${COLOR_RESET}    ${COLOR_SOLAR_TEAL}Rename template${COLOR_RESET} ${EMOJI_RENAME:-🏷️}"
            echo -e "    ${COLOR_BOLD}${COLOR_SOLAR_AQUA}rename${COLOR_RESET} ${COLOR_SOLAR_AQUA}--wizard${COLOR_RESET}       ${COLOR_SOLAR_TEAL}Rename template with wizard${COLOR_RESET} ${EMOJI_WIZARD_RENAME:-🧙}"
            echo ""
            echo -e "${COLOR_BG_SOLAR_DARK}${COLOR_BOLD}${COLOR_WHITE} OPTIONS ${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_SOLAR_AQUA}--template-dir${COLOR_RESET} ${COLOR_SOLAR_SKY}<dir>${COLOR_RESET}  ${COLOR_SOLAR_TEAL}Use specific template directory${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_SOLAR_AQUA}--editor${COLOR_RESET} ${COLOR_SOLAR_SKY}<editor>${COLOR_RESET}     ${COLOR_SOLAR_TEAL}Use specific editor${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_SOLAR_AQUA}--wizard${COLOR_RESET}              ${COLOR_SOLAR_TEAL}Use guided wizard mode${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_SOLAR_AQUA}--tag${COLOR_RESET} ${COLOR_SOLAR_SKY}<tag>${COLOR_RESET}           ${COLOR_SOLAR_TEAL}Filter by or assign tags${COLOR_RESET}"
            echo ""
            echo -e "${COLOR_BG_SOLAR_STEEL}${COLOR_BOLD}${COLOR_WHITE} EXAMPLES ${COLOR_RESET}"
            echo -e "    ${COLOR_SOLAR_LIGHT_BLUE}mark${COLOR_RESET} ${COLOR_SOLAR_CYAN}template${COLOR_RESET} ${COLOR_SOLAR_TEAL}list${COLOR_RESET}"
            echo -e "    ${COLOR_SOLAR_LIGHT_BLUE}mark${COLOR_RESET} ${COLOR_SOLAR_CYAN}template${COLOR_RESET} ${COLOR_SOLAR_TEAL}show${COLOR_RESET} ${COLOR_SOLAR_SKY}welcome_email${COLOR_RESET}"
            echo -e "    ${COLOR_SOLAR_LIGHT_BLUE}mark${COLOR_RESET} ${COLOR_SOLAR_CYAN}template${COLOR_RESET} ${COLOR_SOLAR_TEAL}new${COLOR_RESET} ${COLOR_SOLAR_SKY}sales_pitch${COLOR_RESET} ${COLOR_SOLAR_AQUA}--wizard${COLOR_RESET}"
            echo -e "    ${COLOR_SOLAR_LIGHT_BLUE}mark${COLOR_RESET} ${COLOR_SOLAR_CYAN}template${COLOR_RESET} ${COLOR_SOLAR_TEAL}edit${COLOR_RESET} ${COLOR_SOLAR_SKY}my_template${COLOR_RESET}"
            echo -e "    ${COLOR_SOLAR_LIGHT_BLUE}mark${COLOR_RESET} ${COLOR_SOLAR_CYAN}template${COLOR_RESET} ${COLOR_SOLAR_TEAL}delete${COLOR_RESET} ${COLOR_SOLAR_SKY}old_template${COLOR_RESET}"
            echo -e "    ${COLOR_SOLAR_LIGHT_BLUE}mark${COLOR_RESET} ${COLOR_SOLAR_CYAN}template${COLOR_RESET} ${COLOR_SOLAR_TEAL}rename${COLOR_RESET} ${COLOR_SOLAR_SKY}current_name${COLOR_RESET} ${COLOR_SOLAR_AQUA}new_name${COLOR_RESET}"
            ;;
        config)
            echo -e "${COLOR_BG_SOLAR_BLUE}${COLOR_BOLD}${COLOR_WHITE} CONFIG - Manage configuration ${COLOR_RESET}"
            echo ""
            echo -e "${COLOR_BG_SOLAR_CYAN}${COLOR_BOLD}${COLOR_WHITE} USAGE ${COLOR_RESET}"
            echo -e "    ${COLOR_SOLAR_LIGHT_BLUE}mark${COLOR_RESET} ${COLOR_SOLAR_CYAN}config${COLOR_RESET} ${COLOR_SOLAR_SKY}<SUBCOMMAND>${COLOR_RESET} ${COLOR_SOLAR_AQUA}[KEY]${COLOR_RESET} ${COLOR_SOLAR_AQUA}[VALUE]${COLOR_RESET}"
            echo ""
            echo -e "${COLOR_BG_SOLAR_NAVY}${COLOR_BOLD}${COLOR_WHITE} SUBCOMMANDS ${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_SOLAR_AQUA}set${COLOR_RESET} ${COLOR_SOLAR_SKY}<key>${COLOR_RESET} ${COLOR_SOLAR_AQUA}<value>${COLOR_RESET}     ${COLOR_SOLAR_TEAL}Set configuration value${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_SOLAR_AQUA}get${COLOR_RESET} ${COLOR_SOLAR_SKY}<key>${COLOR_RESET}             ${COLOR_SOLAR_TEAL}Get configuration value${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_SOLAR_AQUA}list${COLOR_RESET}                  ${COLOR_SOLAR_TEAL}List all configuration values${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_SOLAR_AQUA}wizard${COLOR_RESET}                ${COLOR_SOLAR_TEAL}Interactive configuration wizard${COLOR_RESET} ${EMOJI_WIZARD:-🧙}"
            echo ""
            echo -e "${COLOR_BG_SOLAR_DARK}${COLOR_BOLD}${COLOR_WHITE} CONFIGURABLE KEYS ${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_SOLAR_AQUA}template_dirs${COLOR_RESET}         ${COLOR_SOLAR_TEAL}List of template directories (colon-separated)${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_SOLAR_AQUA}default_template_dir${COLOR_RESET}  ${COLOR_SOLAR_TEAL}Directory to use by default for new templates${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_SOLAR_AQUA}editor${COLOR_RESET}                ${COLOR_SOLAR_TEAL}Default editor for template new/edit${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_SOLAR_AQUA}use_fzf${COLOR_RESET}               ${COLOR_SOLAR_TEAL}Whether to use fuzzy finder when selecting templates${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_SOLAR_AQUA}data_file_formats${COLOR_RESET}     ${COLOR_SOLAR_TEAL}Allowed formats for data input (json, yaml, toml)${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_SOLAR_AQUA}wizard_questions${COLOR_RESET}      ${COLOR_SOLAR_TEAL}Default questions for wizard mode templates${COLOR_RESET}"
            echo ""
            echo -e "${COLOR_BG_SOLAR_STEEL}${COLOR_BOLD}${COLOR_WHITE} EXAMPLES ${COLOR_RESET}"
            echo -e "    ${COLOR_SOLAR_LIGHT_BLUE}mark${COLOR_RESET} ${COLOR_SOLAR_CYAN}config${COLOR_RESET} ${COLOR_SOLAR_TEAL}set${COLOR_RESET} ${COLOR_SOLAR_SKY}editor${COLOR_RESET} ${COLOR_SOLAR_AQUA}nvim${COLOR_RESET}"
            echo -e "    ${COLOR_SOLAR_LIGHT_BLUE}mark${COLOR_RESET} ${COLOR_SOLAR_CYAN}config${COLOR_RESET} ${COLOR_SOLAR_TEAL}set${COLOR_RESET} ${COLOR_SOLAR_SKY}template_dirs${COLOR_RESET} ${COLOR_SOLAR_AQUA}\"~/.mark/templates:/usr/share/mark\"${COLOR_RESET}"
            echo -e "    ${COLOR_SOLAR_LIGHT_BLUE}mark${COLOR_RESET} ${COLOR_SOLAR_CYAN}config${COLOR_RESET} ${COLOR_SOLAR_TEAL}get${COLOR_RESET} ${COLOR_SOLAR_SKY}editor${COLOR_RESET}"
            echo -e "    ${COLOR_SOLAR_LIGHT_BLUE}mark${COLOR_RESET} ${COLOR_SOLAR_CYAN}config${COLOR_RESET} ${COLOR_SOLAR_TEAL}list${COLOR_RESET}"
            echo -e "    ${COLOR_SOLAR_LIGHT_BLUE}mark${COLOR_RESET} ${COLOR_SOLAR_CYAN}config${COLOR_RESET} ${COLOR_SOLAR_TEAL}wizard${COLOR_RESET}"
            ;;
        upgrade)
            echo -e "${COLOR_BG_SOLAR_BLUE}${COLOR_BOLD}${COLOR_WHITE} UPGRADE - Upgrade mark to latest version ${COLOR_RESET}"
            echo ""
            echo -e "${COLOR_BG_SOLAR_CYAN}${COLOR_BOLD}${COLOR_WHITE} USAGE ${COLOR_RESET}"
            echo -e "    ${COLOR_SOLAR_LIGHT_BLUE}mark${COLOR_RESET} ${COLOR_SOLAR_CYAN}upgrade${COLOR_RESET}"
            echo ""
            echo -e "${COLOR_BG_SOLAR_NAVY}${COLOR_BOLD}${COLOR_WHITE} DESCRIPTION ${COLOR_RESET}"
            echo -e "    ${COLOR_SOLAR_TEAL}Upgrade mark CLI tool to the latest version from GitHub.${COLOR_RESET}"
            echo -e "    ${COLOR_SOLAR_TEAL}Your templates and configuration will be preserved.${COLOR_RESET}"
            echo ""
            echo -e "${COLOR_BG_SOLAR_DARK}${COLOR_BOLD}${COLOR_WHITE} WHAT THIS DOES ${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_SOLAR_AQUA}-${COLOR_RESET} ${COLOR_SOLAR_TEAL}Downloads latest version from GitHub${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_SOLAR_AQUA}-${COLOR_RESET} ${COLOR_SOLAR_TEAL}Backs up current installation${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_SOLAR_AQUA}-${COLOR_RESET} ${COLOR_SOLAR_TEAL}Installs new version${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_SOLAR_AQUA}-${COLOR_RESET} ${COLOR_SOLAR_TEAL}Preserves templates and configuration${COLOR_RESET}"
            echo ""
            echo -e "${COLOR_BG_SOLAR_STEEL}${COLOR_BOLD}${COLOR_WHITE} EXAMPLES ${COLOR_RESET}"
            echo -e "    ${COLOR_SOLAR_LIGHT_BLUE}mark${COLOR_RESET} ${COLOR_SOLAR_CYAN}upgrade${COLOR_RESET}"
            ;;
        uninstall)
            echo -e "${COLOR_BG_SOLAR_BLUE}${COLOR_BOLD}${COLOR_WHITE} UNINSTALL - Remove mark from your system ${COLOR_RESET}"
            echo ""
            echo -e "${COLOR_BG_SOLAR_CYAN}${COLOR_BOLD}${COLOR_WHITE} USAGE ${COLOR_RESET}"
            echo -e "    ${COLOR_SOLAR_LIGHT_BLUE}mark${COLOR_RESET} ${COLOR_SOLAR_CYAN}uninstall${COLOR_RESET}"
            echo ""
            echo -e "${COLOR_BG_SOLAR_NAVY}${COLOR_BOLD}${COLOR_WHITE} DESCRIPTION ${COLOR_RESET}"
            echo -e "    ${COLOR_SOLAR_TEAL}Completely removes mark CLI tool from your system.${COLOR_RESET}"
            echo ""
            echo -e "${COLOR_BG_SOLAR_DARK}${COLOR_BOLD}${COLOR_WHITE} WHAT GETS REMOVED ${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_SOLAR_AQUA}-${COLOR_RESET} ${COLOR_SOLAR_SKY}\$HOME/.local/bin/mark${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_SOLAR_AQUA}-${COLOR_RESET} ${COLOR_SOLAR_SKY}\$HOME/.local/lib/mark/${COLOR_RESET}"
            echo -e "    ${COLOR_BOLD}${COLOR_SOLAR_AQUA}-${COLOR_RESET} ${COLOR_SOLAR_TEAL}Configuration files in \$HOME/.mark/ (optional)${COLOR_RESET}"
            echo ""
            echo -e "${COLOR_BG_SOLAR_STEEL}${COLOR_BOLD}${COLOR_WHITE} EXAMPLES ${COLOR_RESET}"
            echo -e "    ${COLOR_SOLAR_LIGHT_BLUE}mark${COLOR_RESET} ${COLOR_SOLAR_CYAN}uninstall${COLOR_RESET}"
            ;;
        *)
            show_help
            ;;
    esac
}