#!/bin/bash

# gum_theme.sh - Default Gum theme implementation
# Implements consistent default Gum styling throughout the application

# Default Gum theme constants
GUM_DEFAULT_FG="255"
GUM_DEFAULT_BG="default"
GUM_ACCENT_FG="212"  # Pink accent color
GUM_ACCENT_BG="default"
GUM_SUCCESS_FG="46"  # Green for success
GUM_SUCCESS_BG="default"
GUM_WARNING_FG="220" # Yellow for warnings
GUM_WARNING_BG="default"
GUM_ERROR_FG="196"   # Red for errors
GUM_ERROR_BG="default"
GUM_INFO_FG="240"    # Gray for info text
GUM_INFO_BG="default"

# Header styling (centered, bold)
gum_header() {
    local text="$1"
    gum style --align center --bold "$text"
}

# Section heading (bold)
gum_section() {
    local text="$1"
    gum style --bold "$text"
}

# Info text (gray)
gum_info() {
    local text="$1"
    gum style --foreground $GUM_INFO_FG "$text"
}

# Success message (green)
gum_success() {
    local text="$1"
    gum style --foreground $GUM_SUCCESS_FG "$text"
}

# Warning message (yellow)
gum_warning() {
    local text="$1"
    gum style --foreground $GUM_WARNING_FG "$text"
}

# Error message (red)
gum_error() {
    local text="$1"
    gum style --foreground $GUM_ERROR_FG "$text"
}

# Accent text (pink)
gum_accent() {
    local text="$1"
    gum style --foreground $GUM_ACCENT_FG "$text"
}

# Clear screen with header
gum_clear_screen() {
    clear
    gum_header "MARK - AI Prompt Templating Tool"
    echo ""
}

# Show loading spinner with default styling
gum_loading() {
    local title="$1"
    shift
    gum spin --title="$title" -- "$@"
}

# Show loading spinner with output
gum_loading_output() {
    local title="$1"
    shift
    gum spin --title="$title" --show-output -- "$@"
}

# Show confirmation dialog
gum_confirm_action() {
    local question="$1"
    gum confirm "$question"
}

# Show input prompt
gum_input_prompt() {
    local placeholder="$1"
    local default_value="$2"
    if [[ -n "$default_value" ]]; then
        gum input --placeholder="$placeholder" --value="$default_value"
    else
        gum input --placeholder="$placeholder"
    fi
}

# Show choice selection
gum_choose_option() {
    local header="$1"
    shift
    local options=("$@")
    printf '%s\n' "${options[@]}" | gum choose --header="$header"
}

# Show filtered selection
gum_filter_option() {
    local placeholder="$1"
    shift
    local options=("$@")
    printf '%s\n' "${options[@]}" | gum filter --placeholder="$placeholder"
}

# Format markdown content
gum_format_md() {
    gum format -t markdown
}

# Format code content
gum_format_code() {
    gum format -t code
}

# Show bordered content
gum_border_content() {
    local content="$1"
    echo "$content" | gum style --border normal --padding "1 2"
}

# Show table content
gum_table_content() {
    local content="$1"
    echo "$content" | gum table --border rounded
}