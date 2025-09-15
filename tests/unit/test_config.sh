#!/bin/bash

# Test config functionality
# We need to source config.sh in a way that mimics how it's used in the main script

# Test that config file is loaded if it exists
test_config_loads_file() {
    # Create a temporary config file
    local temp_config=$(mktemp)
    echo "TEST_VAR=test_value" > "$temp_config"
    
    # Create a temporary script to test config loading
    local test_script=$(mktemp)
    cat > "$test_script" << 'EOF'
#!/bin/bash
CONFIG_FILE="$1"
if [[ -f "$CONFIG_FILE" ]]; then
    source "$CONFIG_FILE"
fi
echo "$TEST_VAR"
EOF
    
    chmod +x "$test_script"
    
    # Run the test script with our temp config
    local result=$("$test_script" "$temp_config")
    
    # Check if the variable was loaded
    if [[ "$result" == "test_value" ]]; then
        echo "PASS: Config file loaded correctly"
    else
        echo "FAIL: Config file not loaded correctly"
    fi
    
    # Cleanup
    rm -f "$temp_config" "$test_script"
}

# Test default values are set
test_default_values() {
    # Source the actual config file
    source "/home/rana/Documents/mark/lib/core/config.sh"
    
    # Check if default values are set
    if [[ -n "$LOG_FILE" ]] && [[ -n "$TEMPLATE_DIR" ]]; then
        echo "PASS: Default values are set"
    else
        echo "FAIL: Default values are not set correctly"
    fi
}

# Run tests
echo "Running config tests..."
test_config_loads_file
test_default_values
echo "Config tests completed."