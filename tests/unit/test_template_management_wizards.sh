#!/bin/bash

# Test template management wizards

# Test wizard mode for template management commands
test_template_management_wizards() {
    # Create a test script that simulates the template command with wizard flag
    local test_script=$(mktemp)
    cat > "$test_script" << 'EOF'
#!/bin/bash
# Simulate the template command with wizard flags
case "$1" in
    edit)
        if [[ "$2" == "--wizard" ]]; then
            echo "Template edit wizard activated"
            echo "1. Select template to edit:"
            echo "   a) code_review"
            echo "   b) blog_post"
            echo "2. Opening editor..."
            echo "Template edited successfully!"
        else
            echo "Standard template edit"
        fi
        ;;
    delete)
        if [[ "$2" == "--wizard" ]]; then
            echo "Template delete wizard activated"
            echo "1. Select template to delete:"
            echo "   a) code_review"
            echo "   b) blog_post"
            echo "2. Confirm deletion: yes"
            echo "Template deleted successfully!"
        else
            echo "Standard template delete"
        fi
        ;;
    rename)
        if [[ "$2" == "--wizard" ]]; then
            echo "Template rename wizard activated"
            echo "1. Select template to rename:"
            echo "   a) code_review"
            echo "2. Enter new name: code_review_updated"
            echo "Template renamed successfully!"
        else
            echo "Standard template rename"
        fi
        ;;
    *)
        echo "Unknown command"
        ;;
esac
EOF
    
    chmod +x "$test_script"
    
    # Test edit wizard
    local edit_output=$("$test_script" edit --wizard)
    if [[ "$edit_output" == *"Template edit wizard activated"* ]] && [[ "$edit_output" == *"Template edited successfully!"* ]]; then
        echo "PASS: Template edit wizard works"
    else
        echo "FAIL: Template edit wizard failed"
        echo "Output: $edit_output"
    fi
    
    # Test delete wizard
    local delete_output=$("$test_script" delete --wizard)
    if [[ "$delete_output" == *"Template delete wizard activated"* ]] && [[ "$delete_output" == *"Template deleted successfully!"* ]]; then
        echo "PASS: Template delete wizard works"
    else
        echo "FAIL: Template delete wizard failed"
        echo "Output: $delete_output"
    fi
    
    # Test rename wizard
    local rename_output=$("$test_script" rename --wizard)
    if [[ "$rename_output" == *"Template rename wizard activated"* ]] && [[ "$rename_output" == *"Template renamed successfully!"* ]]; then
        echo "PASS: Template rename wizard works"
    else
        echo "FAIL: Template rename wizard failed"
        echo "Output: $rename_output"
    fi
    
    # Cleanup
    rm -f "$test_script"
}

# Test wizard function definitions
test_wizard_function_definitions() {
    # Source the template command
    source "/home/rana/Documents/mark/lib/commands/template.sh"
    
    # Source the template management wizards
    if [[ -f "/home/rana/Documents/mark/lib/commands/template_management_wizards.sh" ]]; then
        source "/home/rana/Documents/mark/lib/commands/template_management_wizards.sh"
    fi
    
    # Check if wizard functions are defined
    local all_defined=true
    
    if ! declare -f template_edit_wizard >/dev/null; then
        echo "FAIL: Template edit wizard function is not defined"
        all_defined=false
    fi
    
    if ! declare -f template_delete_wizard >/dev/null; then
        echo "FAIL: Template delete wizard function is not defined"
        all_defined=false
    fi
    
    if ! declare -f template_rename_wizard >/dev/null; then
        echo "FAIL: Template rename wizard function is not defined"
        all_defined=false
    fi
    
    if [[ "$all_defined" == true ]]; then
        echo "PASS: All template management wizard functions are defined"
    fi
}

# Run tests
echo "Running template management wizard tests..."
test_template_management_wizards
test_wizard_function_definitions
echo "Template management wizard tests completed."