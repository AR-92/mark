#!/bin/bash

# Test actual config command implementation

# Source the config command
source "/home/rana/Documents/mark/lib/commands/config.sh"

# Test config command set
test_config_command_set() {
    # Create a temporary config directory
    local temp_config_dir=$(mktemp -d)
    local original_config="$CONFIG_FILE"
    CONFIG_FILE="$temp_config_dir/config.yml"
    
    # Test setting a value
    output=$(config_command set editor nvim 2>&1)
    
    if [[ "$output" == "Configuration 'editor' set to 'nvim'" ]]; then
        echo "PASS: Config command set works"
    else
        echo "FAIL: Config command set failed"
        echo "Output: $output"
    fi
    
    # Restore original config and cleanup
    CONFIG_FILE="$original_config"
    rm -rf "$temp_config_dir"
}

# Test config command get
test_config_command_get() {
    # Create a temporary config directory
    local temp_config_dir=$(mktemp -d)
    local original_config="$CONFIG_FILE"
    CONFIG_FILE="$temp_config_dir/config.yml"
    
    # Set a value first
    config_set "editor" "code"
    
    # Test getting the value
    output=$(config_command get editor 2>&1)
    
    if [[ "$output" == "code" ]]; then
        echo "PASS: Config command get works"
    else
        echo "FAIL: Config command get failed. Expected 'code', got '$output'"
    fi
    
    # Restore original config and cleanup
    CONFIG_FILE="$original_config"
    rm -rf "$temp_config_dir"
}

# Test config command list
test_config_command_list() {
    # Create a temporary config directory
    local temp_config_dir=$(mktemp -d)
    local original_config="$CONFIG_FILE"
    CONFIG_FILE="$temp_config_dir/config.yml"
    
    # Test listing config
    output=$(config_command list 2>&1)
    
    if [[ "$output" == *"Configuration:"* ]]; then
        echo "PASS: Config command list works"
    else
        echo "FAIL: Config command list failed"
        echo "Output: $output"
    fi
    
    # Restore original config and cleanup
    CONFIG_FILE="$original_config"
    rm -rf "$temp_config_dir"
}

# Test config command with no arguments
test_config_command_help() {
    # Test help output
    output=$(config_command 2>&1)
    
    if [[ "$output" == *"Usage: mark config"* ]] && [[ "$output" == *"Configurable keys:"* ]]; then
        echo "PASS: Config command help works"
    else
        echo "FAIL: Config command help failed"
        echo "Output: $output"
    fi
}

# Run tests
echo "Running actual config command tests..."
test_config_command_set
test_config_command_get
test_config_command_list
test_config_command_help
echo "Actual config command tests completed."