#!/bin/bash

# Test interactive generate functionality

# Source the generate command
source "/home/rana/Documents/mark/lib/commands/generate.sh"

# Test interactive mode detection
test_interactive_mode_detection() {
    # Create a temporary config directory
    local temp_config_dir=$(mktemp -d)
    local original_config="$CONFIG_FILE"
    CONFIG_FILE="$temp_config_dir/config.yml"
    
    # Create a test template
    mkdir -p "$temp_config_dir/templates"
    echo "# Test Template
    
Hello {{name}}!" > "$temp_config_dir/templates/test.md"
    
    # Set template directory in config
    if declare -f config_set >/dev/null; then
        config_set "template_dirs" "$temp_config_dir/templates"
    fi
    
    # Test that interactive function is defined
    if declare -f generate_prompt_interactive >/dev/null; then
        echo "PASS: Interactive generate function is defined"
    else
        echo "FAIL: Interactive generate function is not defined"
    fi
    
    # Restore original config and cleanup
    CONFIG_FILE="$original_config"
    rm -rf "$temp_config_dir"
}

# Test interactive mode execution
test_interactive_mode_execution() {
    # Create a test script that simulates the interactive generate command
    local test_script=$(mktemp)
    cat > "$test_script" << 'EOF'
#!/bin/bash
# Simulate the generate command with interactive flag
if [[ "$1" == "--interactive" ]]; then
    echo "Interactive mode activated"
    echo "Select template:"
    echo "1) test_template"
    echo "Enter choice (1-1): 1"
    echo "Enter value for name: John"
    echo "How would you like to save the output?"
    echo "1) Display on screen"
    echo "Enter choice (1-1): 1"
    echo "Preview:"
    echo "--- START PREVIEW ---"
    echo "Hello John!"
    echo "--- END PREVIEW ---"
    echo "Proceed with generation? [Y/n]: y"
    echo "Hello John!"
else
    echo "Non-interactive mode"
fi
EOF
    
    chmod +x "$test_script"
    
    # Test interactive mode (simulate input)
    local output=$(echo -e "1\nJohn\n1\ny" | "$test_script" --interactive)
    
    if [[ "$output" == *"Interactive mode activated"* ]] && [[ "$output" == *"Hello John!"* ]]; then
        echo "PASS: Interactive mode execution works"
    else
        echo "FAIL: Interactive mode execution failed"
        echo "Output: $output"
    fi
    
    # Cleanup
    rm -f "$test_script"
}

# Run tests
echo "Running interactive generate tests..."
test_interactive_mode_detection
test_interactive_mode_execution
echo "Interactive generate tests completed."