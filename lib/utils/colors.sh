#!/bin/bash

# ANSI Color Codes for styling terminal output
# Foreground Colors
COLOR_RESET='\033[0m'
COLOR_BLACK='\033[0;30m'
COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[0;33m'
COLOR_BLUE='\033[0;34m'
COLOR_PURPLE='\033[0;35m'
COLOR_CYAN='\033[0;36m'
COLOR_WHITE='\033[0;37m'

# Bold Colors
COLOR_BOLD_BLACK='\033[1;30m'
COLOR_BOLD_RED='\033[1;31m'
COLOR_BOLD_GREEN='\033[1;32m'
COLOR_BOLD_YELLOW='\033[1;33m'
COLOR_BOLD_BLUE='\033[1;34m'
COLOR_BOLD_PURPLE='\033[1;35m'
COLOR_BOLD_CYAN='\033[1;36m'
COLOR_BOLD_WHITE='\033[1;37m'

# Background Colors
COLOR_BG_BLACK='\033[40m'
COLOR_BG_RED='\033[41m'
COLOR_BG_GREEN='\033[42m'
COLOR_BG_YELLOW='\033[43m'
COLOR_BG_BLUE='\033[44m'
COLOR_BG_PURPLE='\033[45m'
COLOR_BG_CYAN='\033[46m'
COLOR_BG_WHITE='\033[47m'

# High Intensity Colors
COLOR_HI_BLACK='\033[0;90m'
COLOR_HI_RED='\033[0;91m'
COLOR_HI_GREEN='\033[0;92m'
COLOR_HI_YELLOW='\033[0;93m'
COLOR_HI_BLUE='\033[0;94m'
COLOR_HI_PURPLE='\033[0;95m'
COLOR_HI_CYAN='\033[0;96m'
COLOR_HI_WHITE='\033[0;97m'

# Bold High Intensity Colors
COLOR_BOLD_HI_BLACK='\033[1;90m'
COLOR_BOLD_HI_RED='\033[1;91m'
COLOR_BOLD_HI_GREEN='\033[1;92m'
COLOR_BOLD_HI_YELLOW='\033[1;93m'
COLOR_BOLD_HI_BLUE='\033[1;94m'
COLOR_BOLD_HI_PURPLE='\033[1;95m'
COLOR_BOLD_HI_CYAN='\033[1;96m'
COLOR_BOLD_HI_WHITE='\033[1;97m'

# High Intensity Backgrounds
COLOR_BG_HI_BLACK='\033[0;100m'
COLOR_BG_HI_RED='\033[0;101m'
COLOR_BG_HI_GREEN='\033[0;102m'
COLOR_BG_HI_YELLOW='\033[0;103m'
COLOR_BG_HI_BLUE='\033[0;104m'
COLOR_BG_HI_PURPLE='\033[0;105m'
COLOR_BG_HI_CYAN='\033[0;106m'
COLOR_BG_HI_WHITE='\033[0;107m'

# Text Styles
COLOR_BOLD='\033[1m'
COLOR_DIM='\033[2m'
COLOR_UNDERLINE='\033[4m'
COLOR_BLINK='\033[5m'
COLOR_REVERSE='\033[7m'
COLOR_HIDDEN='\033[8m'

# Function to print colored text
print_color() {
    local color="$1"
    local text="$2"
    echo -e "${color}${text}${COLOR_RESET}"
}

# Function to print a line with background color
print_bg() {
    local bg_color="$1"
    local text="$2"
    echo -e "${bg_color} ${text} ${COLOR_RESET}"
}

# Function to print header with background and text colors
print_header() {
    local bg_color="$1"
    local text_color="$2"
    local text="$3"
    echo -e "${bg_color}${text_color} ${text} ${COLOR_RESET}"
}