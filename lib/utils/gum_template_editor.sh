#!/bin/bash

# gum_template_editor.sh - Enhanced template management with Gum and nvim integration
# Provides intuitive template management with nvim editing capabilities

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

# Check if nvim is installed
check_nvim() {
    command -v nvim &> /dev/null
}

# Check if vim is installed (fallback)
check_vim() {
    command -v vim &> /dev/null
}

# Get preferred editor
get_preferred_editor() {
    # Try to get from config first
    local editor=$(./bin/mark config get editor 2>/dev/null)
    
    # If not set in config, check environment
    if [[ -z "$editor" ]]; then
        editor="${EDITOR:-vim}"
    fi
    
    # Validate editor
    if [[ "$editor" == "nvim" ]] && check_nvim; then
        echo "nvim"
    elif [[ "$editor" == "vim" ]] && check_vim; then
        echo "vim"
    elif check_nvim; then
        echo "nvim"
    elif check_vim; then
        echo "vim"
    else
        echo ""
    fi
}

# Show templates with Gum formatting
show_templates_formatted() {
    local templates_data="$1"
    
    if check_gum; then
        if declare -f gum_section >/dev/null; then
            gum_section "Available Templates"
        else
            gum style --bold "Available Templates:"
        fi
        echo ""
        
        # Format as table if possible
        if echo "$templates_data" | grep -q "\\.md"; then
            # Convert to table format
            echo "$templates_data" | while read -r line; do
                if [[ -n "$line" ]] && [[ "$line" != *"No templates found"* ]]; then
                    printf "%s\n" "$line"
                fi
            done | gum table --border rounded --columns "Template Name"
        else
            echo "$templates_data" | gum format
        fi
    else
        echo "Available Templates:"
        echo "===================="
        echo ""
        echo "$templates_data"
    fi
}

# Edit template with nvim/vim integration
edit_template_with_editor() {
    local template_name="$1"
    local template_path="$2"
    
    # Get preferred editor
    local editor
    editor=$(get_preferred_editor)
    
    if [[ -z "$editor" ]]; then
        if check_gum; then
            if declare -f gum_error >/dev/null; then
                gum_error "No editor found. Please install nvim or vim."
            else
                gum style --foreground 196 "No editor found. Please install nvim or vim."
            fi
        else
            echo "No editor found. Please install nvim or vim."
        fi
        return 1
    fi
    
    # Confirm before editing
    if check_gum; then
        if declare -f gum_confirm_action >/dev/null; then
            if ! gum_confirm_action "Edit template '$template_name' with $editor?"; then
                if declare -f gum_info >/dev/null; then
                    gum_info "Edit cancelled"
                else
                    echo "Edit cancelled"
                fi
                return 0
            fi
        else
            if ! gum confirm "Edit template '$template_name' with $editor?"; then
                if declare -f gum_info >/dev/null; then
                    gum_info "Edit cancelled"
                else
                    echo "Edit cancelled"
                fi
                return 0
            fi
        fi
    else
        echo "Edit template '$template_name' with $editor? (y/N)"
        read -p "" edit_confirm </dev/null
        if [[ ! "$edit_confirm" =~ ^[Yy]$ ]]; then
            echo "Edit cancelled"
            return 0
        fi
    fi
    
    # Show loading message
    if check_gum; then
        if declare -f gum_info >/dev/null; then
            gum_info "Opening $template_name with $editor..."
        else
            echo "Opening $template_name with $editor..."
        fi
    else
        echo "Opening $template_name with $editor..."
    fi
    
    # Edit template
    if [[ "$editor" == "nvim" ]]; then
        nvim "$template_path"
    else
        vim "$template_path"
    fi
    
    # Show success message
    if check_gum; then
        if declare -f gum_success >/dev/null; then
            gum_success "Template '$template_name' edited successfully!"
        else
            gum style --foreground 46 "Template '$template_name' edited successfully!"
        fi
    else
        echo "Template '$template_name' edited successfully!"
    fi
}

# Create template with editor integration
create_template_with_editor() {
    local template_name="$1"
    local template_path="$2"
    
    # Confirm before creating
    if check_gum; then
        if declare -f gum_confirm_action >/dev/null; then
            if ! gum_confirm_action "Create new template '$template_name'?"; then
                if declare -f gum_info >/dev/null; then
                    gum_info "Creation cancelled"
                else
                    echo "Creation cancelled"
                fi
                return 0
            fi
        else
            if ! gum confirm "Create new template '$template_name'?"; then
                if declare -f gum_info >/dev/null; then
                    gum_info "Creation cancelled"
                else
                    echo "Creation cancelled"
                fi
                return 0
            fi
        fi
    else
        echo "Create new template '$template_name'? (y/N)"
        read -p "" create_confirm </dev/null
        if [[ ! "$create_confirm" =~ ^[Yy]$ ]]; then
            echo "Creation cancelled"
            return 0
        fi
    fi
    
    # Create template
    if ./bin/mark template new "$template_name"; then
        if check_gum; then
            if declare -f gum_success >/dev/null; then
                gum_success "Template '$template_name' created successfully!"
            else
                gum style --foreground 46 "Template '$template_name' created successfully!"
            fi
        else
            echo "Template '$template_name' created successfully!"
        fi
        
        # Ask if user wants to edit
        echo ""
        if check_gum; then
            if declare -f gum_confirm_action >/dev/null; then
                if gum_confirm_action "Edit the new template now?"; then
                    edit_template_with_editor "$template_name" "$template_path"
                fi
            else
                if gum confirm "Edit the new template now?"; then
                    edit_template_with_editor "$template_name" "$template_path"
                fi
            fi
        else
            echo "Edit the new template now? (y/N)"
            read -p "" edit_now </dev/null
            if [[ "$edit_now" =~ ^[Yy]$ ]]; then
                edit_template_with_editor "$template_name" "$template_path"
            fi
        fi
    else
        if check_gum; then
            if declare -f gum_error >/dev/null; then
                gum_error "Failed to create template '$template_name'"
            else
                gum style --foreground 196 "Failed to create template '$template_name'"
            fi
        else
            echo "Failed to create template '$template_name'"
        fi
    fi
}

# Delete template with confirmation
delete_template_with_confirmation() {
    local template_name="$1"
    
    # Show warning
    if check_gum; then
        if declare -f gum_warning >/dev/null; then
            gum_warning "🚨 WARNING: This will permanently delete '$template_name'!"
        else
            gum style --foreground 220 --bold "🚨 WARNING: This will permanently delete '$template_name'!"
        fi
        echo ""
        
        if declare -f gum_confirm_action >/dev/null; then
            if gum_confirm_action "Are you absolutely sure you want to delete '$template_name'?"; then
                if gum_confirm_action "This action cannot be undone. Continue?"; then
                    # Delete template
                    ./bin/mark template delete "$template_name"
                    if declare -f gum_success >/dev/null; then
                        gum_success "Template '$template_name' deleted successfully!"
                    else
                        echo "Template '$template_name' deleted successfully!"
                    fi
                else
                    if declare -f gum_info >/dev/null; then
                        gum_info "Deletion cancelled"
                    else
                        echo "Deletion cancelled"
                    fi
                fi
            else
                if declare -f gum_info >/dev/null; then
                    gum_info "Deletion cancelled"
                else
                    echo "Deletion cancelled"
                fi
            fi
        else
            if gum confirm "Are you absolutely sure you want to delete '$template_name'?"; then
                if gum confirm "This action cannot be undone. Continue?"; then
                    # Delete template
                    ./bin/mark template delete "$template_name"
                    if declare -f gum_success >/dev/null; then
                        gum_success "Template '$template_name' deleted successfully!"
                    else
                        echo "Template '$template_name' deleted successfully!"
                    fi
                else
                    if declare -f gum_info >/dev/null; then
                        gum_info "Deletion cancelled"
                    else
                        echo "Deletion cancelled"
                    fi
                fi
            else
                if declare -f gum_info >/dev/null; then
                    gum_info "Deletion cancelled"
                else
                    echo "Deletion cancelled"
                fi
            fi
        fi
    else
        echo "🚨 WARNING: This will permanently delete '$template_name'!"
        echo ""
        echo "Are you absolutely sure you want to delete '$template_name'? (y/N)"
        read -p "" delete_confirm </dev/null
        if [[ "$delete_confirm" =~ ^[Yy]$ ]]; then
            echo "This action cannot be undone. Continue? (y/N)"
            read -p "" final_confirm </dev/null
            if [[ "$final_confirm" =~ ^[Yy]$ ]]; then
                # Delete template
                ./bin/mark template delete "$template_name"
                echo "Template '$template_name' deleted successfully!"
            else
                echo "Deletion cancelled"
            fi
        else
            echo "Deletion cancelled"
        fi
    fi
}

# Show template menu with Gum
show_template_menu() {
    if ! check_gum; then
        echo "Template Management"
        echo "==================="
        echo "1. List Templates"
        echo "2. View Template"
        echo "3. Create Template"
        echo "4. Edit Template"
        echo "5. Delete Template"
        echo "6. Back to Main Menu"
        echo ""
        read -p "Select option (1-6): " choice </dev/null
        case "$choice" in
            1) 
                echo "Available Templates:"
                echo "===================="
                echo ""
                ./bin/mark template list
                echo ""
                read -p "Press Enter to continue..." </dev/null
                show_template_menu
                ;;
            2)
                read -p "Enter template name: " template </dev/null
                if [[ -n "$template" ]]; then
                    echo ""
                    ./bin/mark template show "$template"
                else
                    echo "No template name provided"
                fi
                echo ""
                read -p "Press Enter to continue..." </dev/null
                show_template_menu
                ;;
            3)
                read -p "Enter template name (e.g., my_template.md): " template </dev/null
                if [[ -n "$template" ]]; then
                    ./bin/mark template new "$template"
                    echo "Template '$template' created successfully!"
                else
                    echo "No template name provided"
                fi
                echo ""
                read -p "Press Enter to continue..." </dev/null
                show_template_menu
                ;;
            4)
                read -p "Enter template name: " template </dev/null
                if [[ -n "$template" ]]; then
                    # Try to edit with nvim
                    if command -v nvim &> /dev/null; then
                        nvim "$HOME/.mark/templates/$template" 2>/dev/null || vim "$HOME/.mark/templates/$template"
                    elif command -v vim &> /dev/null; then
                        vim "$HOME/.mark/templates/$template"
                    else
                        echo "No editor found. Edit template manually at: $HOME/.mark/templates/$template"
                    fi
                    echo "Template '$template' edited successfully!"
                else
                    echo "No template name provided"
                fi
                echo ""
                read -p "Press Enter to continue..." </dev/null
                show_template_menu
                ;;
            5)
                read -p "Enter template name: " template </dev/null
                if [[ -n "$template" ]]; then
                    echo "Delete template '$template'? This cannot be undone. (y/N)"
                    read -p "" delete_confirm </dev/null
                    if [[ "$delete_confirm" =~ ^[Yy]$ ]]; then
                        ./bin/mark template delete "$template"
                        echo "Template '$template' deleted successfully!"
                    else
                        echo "Deletion cancelled"
                    fi
                else
                    echo "No template name provided"
                fi
                echo ""
                read -p "Press Enter to continue..." </dev/null
                show_template_menu
                ;;
            6) return ;;
            *)
                echo "Invalid option"
                read -p "Press Enter to continue..." </dev/null
                show_template_menu
                ;;
        esac
        return
    fi
    
    # Show template menu with Gum
    if declare -f gum_section >/dev/null; then
        gum_section "Template Management"
    else
        gum style --bold "Template Management"
    fi
    echo ""
    
    # Show options
    local options=("List Templates" "View Template" "Create Template" "Edit Template" "Delete Template" "Back to Main Menu")
    local choice
    
    if declare -f gum_filter_option >/dev/null; then
        choice=$(gum_filter_option "Select template action..." "${options[@]}")
    else
        choice=$(printf '%s\n' "${options[@]}" | gum filter --placeholder="Select template action...")
    fi
    
    case "$choice" in
        "List Templates")
            clear_screen
            if declare -f gum_section >/dev/null; then
                gum_section "Available Templates"
            else
                gum style --bold "Available Templates:"
            fi
            echo ""
            # Show loading spinner
            if declare -f gum_loading_output >/dev/null; then
                gum_loading_output "Loading templates..." ./bin/mark template list
            else
                gum spin --title="Loading templates..." --show-output -- ./bin/mark template list
            fi
            echo ""
            if declare -f gum_info >/dev/null; then
                gum_info "Press Enter to continue..."
            else
                echo "Press Enter to continue..."
            fi
            gum input --placeholder="" --width=1 > /dev/null
            show_template_menu
            ;;
        "View Template")
            clear_screen
            if declare -f gum_section >/dev/null; then
                gum_section "View Template"
            else
                gum style --bold "View Template:"
            fi
            echo ""
            
            if declare -f gum_input_prompt >/dev/null; then
                template=$(gum_input_prompt "Enter template name")
            else
                template=$(gum input --placeholder="Enter template name")
            fi
            
            if [[ -n "$template" ]]; then
                echo ""
                # Show loading spinner
                if declare -f gum_loading_output >/dev/null; then
                    gum_loading_output "Loading template..." ./bin/mark template show "$template"
                else
                    gum spin --title="Loading template..." --show-output -- ./bin/mark template show "$template"
                fi
            else
                if declare -f gum_error >/dev/null; then
                    gum_error "No template name provided"
                else
                    gum style --foreground 196 "No template name provided"
                fi
            fi
            
            echo ""
            if declare -f gum_info >/dev/null; then
                gum_info "Press Enter to continue..."
            else
                echo "Press Enter to continue..."
            fi
            gum input --placeholder="" --width=1 > /dev/null
            show_template_menu
            ;;
        "Create Template")
            clear_screen
            if declare -f gum_section >/dev/null; then
                gum_section "Create Template"
            else
                gum style --bold "Create Template:"
            fi
            echo ""
            
            if declare -f gum_input_prompt >/dev/null; then
                template=$(gum_input_prompt "Enter template name (e.g., my_template.md)")
            else
                template=$(gum input --placeholder="Enter template name (e.g., my_template.md)")
            fi
            
            if [[ -n "$template" ]]; then
                # Get template path
                local template_path="$HOME/.mark/templates/$template"
                
                # Create template with editor integration
                create_template_with_editor "$template" "$template_path"
            else
                if declare -f gum_error >/dev/null; then
                    gum_error "No template name provided"
                else
                    gum style --foreground 196 "No template name provided"
                fi
            fi
            
            echo ""
            if declare -f gum_info >/dev/null; then
                gum_info "Press Enter to continue..."
            else
                echo "Press Enter to continue..."
            fi
            gum input --placeholder="" --width=1 > /dev/null
            show_template_menu
            ;;
        "Edit Template")
            clear_screen
            if declare -f gum_section >/dev/null; then
                gum_section "Edit Template"
            else
                gum style --bold "Edit Template:"
            fi
            echo ""
            
            if declare -f gum_input_prompt >/dev/null; then
                template=$(gum_input_prompt "Enter template name")
            else
                template=$(gum input --placeholder="Enter template name")
            fi
            
            if [[ -n "$template" ]]; then
                # Get template path
                local template_path="$HOME/.mark/templates/$template"
                
                # Edit template with editor integration
                edit_template_with_editor "$template" "$template_path"
            else
                if declare -f gum_error >/dev/null; then
                    gum_error "No template name provided"
                else
                    gum style --foreground 196 "No template name provided"
                fi
            fi
            
            echo ""
            if declare -f gum_info >/dev/null; then
                gum_info "Press Enter to continue..."
            else
                echo "Press Enter to continue..."
            fi
            gum input --placeholder="" --width=1 > /dev/null
            show_template_menu
            ;;
        "Delete Template")
            clear_screen
            if declare -f gum_section >/dev/null; then
                gum_section "Delete Template"
            else
                gum style --bold "Delete Template:"
            fi
            echo ""
            
            if declare -f gum_input_prompt >/dev/null; then
                template=$(gum_input_prompt "Enter template name")
            else
                template=$(gum input --placeholder="Enter template name")
            fi
            
            if [[ -n "$template" ]]; then
                # Delete template with confirmation
                delete_template_with_confirmation "$template"
            else
                if declare -f gum_error >/dev/null; then
                    gum_error "No template name provided"
                else
                    gum style --foreground 196 "No template name provided"
                fi
            fi
            
            echo ""
            if declare -f gum_info >/dev/null; then
                gum_info "Press Enter to continue..."
            else
                echo "Press Enter to continue..."
            fi
            gum input --placeholder="" --width=1 > /dev/null
            show_template_menu
            ;;
        "Back to Main Menu"|*)
            return
            ;;
    esac
}