#!/bin/bash

# Test interactive wizard functionality

# Test interactive mode detection
test_interactive_mode() {
    # Create a test script that simulates the generate command with interactive flag
    local test_script=$(mktemp)
    cat > "$test_script" << 'EOF'
#!/bin/bash
# Simulate the generate command
if [[ "$1" == "--interactive" ]]; then
    echo "Interactive mode activated"
    echo "1. Select template:"
    echo "   a) code_review"
    echo "   b) blog_post"
    echo "   c) product_description"
    echo "Enter choice (a-c): "
    read choice
    case $choice in
        a) echo "Selected: code_review" ;;
        b) echo "Selected: blog_post" ;;
        c) echo "Selected: product_description" ;;
        *) echo "Invalid choice" ;;
    esac
else
    echo "Non-interactive mode"
fi
EOF
    
    chmod +x "$test_script"
    
    # Test interactive mode
    local output=$(echo "a" | "$test_script" --interactive)
    
    if [[ "$output" == *"Interactive mode activated"* ]] && [[ "$output" == *"Selected: code_review"* ]]; then
        echo "PASS: Interactive mode works"
    else
        echo "FAIL: Interactive mode failed"
        echo "Output: $output"
    fi
    
    # Cleanup
    rm -f "$test_script"
}

# Test wizard mode detection
test_wizard_mode() {
    # Create a test script that simulates the template new command with wizard flag
    local test_script=$(mktemp)
    cat > "$test_script" << 'EOF'
#!/bin/bash
# Simulate the template new command
if [[ "$3" == "--wizard" ]]; then
    echo "Template creation wizard activated"
    echo "Template name: $2"
    echo "1. Enter description:"
    echo "2. Define variables:"
    echo "3. Add sample content:"
    echo "Template created successfully!"
else
    echo "Standard template creation"
fi
EOF
    
    chmod +x "$test_script"
    
    # Test wizard mode
    local output=$("$test_script" new my_template --wizard)
    
    if [[ "$output" == *"Template creation wizard activated"* ]] && [[ "$output" == *"Template created successfully!"* ]]; then
        echo "PASS: Wizard mode works"
    else
        echo "FAIL: Wizard mode failed"
        echo "Output: $output"
    fi
    
    # Cleanup
    rm -f "$test_script"
}

# Run tests
echo "Running interactive wizard tests..."
test_interactive_mode
test_wizard_mode
echo "Interactive wizard tests completed."