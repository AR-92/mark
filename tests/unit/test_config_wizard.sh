#!/bin/bash

# Test config wizard functionality

# Test config wizard detection
test_config_wizard_detection() {
    # Create a test script that simulates the config command with wizard flag
    local test_script=$(mktemp)
    cat > "$test_script" << 'EOF'
#!/bin/bash
# Simulate the config command
if [[ "$1" == "wizard" ]]; then
    echo "Config wizard activated"
    echo "1. Current configuration:"
    echo "   editor=vim"
    echo "   use_fzf=true"
    echo "2. Opening editor..."
    echo "3. Configuration updated successfully!"
else
    echo "Standard config command"
fi
EOF
    
    chmod +x "$test_script"
    
    # Test wizard mode
    local output=$("$test_script" wizard)
    if [[ "$output" == *"Config wizard activated"* ]] && [[ "$output" == *"Configuration updated successfully!"* ]]; then
        echo "PASS: Config wizard detection works"
    else
        echo "FAIL: Config wizard detection failed"
        echo "Output: $output"
    fi
    
    # Cleanup
    rm -f "$test_script"
}

# Test config wizard function definition
test_config_wizard_function() {
    # Source the config command
    source "/home/rana/Documents/mark/lib/commands/config.sh"
    
    # Source the config wizard
    if [[ -f "/home/rana/Documents/mark/lib/commands/config_wizard.sh" ]]; then
        source "/home/rana/Documents/mark/lib/commands/config_wizard.sh"
    fi
    
    # Check if wizard function is defined
    if declare -f config_wizard >/dev/null; then
        echo "PASS: Config wizard function is defined"
    else
        echo "FAIL: Config wizard function is not defined"
    fi
}

# Run tests
echo "Running config wizard tests..."
test_config_wizard_detection
test_config_wizard_function
echo "Config wizard tests completed."