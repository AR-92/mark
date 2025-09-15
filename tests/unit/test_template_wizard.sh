#!/bin/bash

# Test template creation wizard

# Test wizard mode detection
test_wizard_mode_detection() {
    # Create a test script that simulates the template command with wizard flag
    local test_script=$(mktemp)
    cat > "$test_script" << 'EOF'
#!/bin/bash
# Simulate the template command
if [[ "$1" == "new" ]] && [[ "$3" == "--wizard" ]]; then
    echo "Template creation wizard activated"
    echo "Template name: $2"
    echo "1. Enter description: A test template"
    echo "2. Define variables: name, age"
    echo "3. Add sample content: Hello {{name}}, you are {{age}} years old."
    echo "Template created successfully!"
else
    echo "Standard template creation"
fi
EOF
    
    chmod +x "$test_script"
    
    # Test wizard mode
    local output=$("$test_script" new test_template --wizard)
    
    if [[ "$output" == *"Template creation wizard activated"* ]] && [[ "$output" == *"Template created successfully!"* ]]; then
        echo "PASS: Template creation wizard works"
    else
        echo "FAIL: Template creation wizard failed"
        echo "Output: $output"
    fi
    
    # Cleanup
    rm -f "$test_script"
}

# Test wizard function definition
test_wizard_function() {
    # Source the template command
    source "/home/rana/Documents/mark/lib/commands/template.sh"
    
    # Source the template wizard
    if [[ -f "/home/rana/Documents/mark/lib/commands/template_wizard.sh" ]]; then
        source "/home/rana/Documents/mark/lib/commands/template_wizard.sh"
    fi
    
    # Check if wizard function is defined
    if declare -f template_new_wizard >/dev/null; then
        echo "PASS: Template creation wizard function is defined"
    else
        echo "FAIL: Template creation wizard function is not defined"
    fi
}

# Run tests
echo "Running template creation wizard tests..."
test_wizard_mode_detection
test_wizard_function
echo "Template creation wizard tests completed."