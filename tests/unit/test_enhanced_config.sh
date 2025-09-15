#!/bin/bash

# Test enhanced config functionality

# Source the enhanced config
source "/home/rana/Documents/mark/lib/core/enhanced_config.sh"

# Test config set and get
test_config_set_get() {
    # Create a temporary config directory
    local temp_config_dir=$(mktemp -d)
    local original_config="$CONFIG_FILE"
    CONFIG_FILE="$temp_config_dir/config.yml"
    
    # Test setting a value
    config_set "editor" "nvim"
    
    # Test getting the value
    local result=$(config_get "editor")
    
    if [[ "$result" == "nvim" ]]; then
        echo "PASS: Config set and get functionality works"
    else
        echo "FAIL: Config set and get functionality failed. Expected 'nvim', got '$result'"
    fi
    
    # Restore original config and cleanup
    CONFIG_FILE="$original_config"
    rm -rf "$temp_config_dir"
}

# Test config list
test_config_list() {
    # Create a temporary config directory
    local temp_config_dir=$(mktemp -d)
    local original_config="$CONFIG_FILE"
    CONFIG_FILE="$temp_config_dir/config.yml"
    
    # Test listing config
    local output=$(config_list)
    
    if [[ "$output" == *"Configuration:"* ]] && [[ "$output" == *"editor=vim (default)"* ]]; then
        echo "PASS: Config list functionality works"
    else
        echo "FAIL: Config list functionality failed"
        echo "Output: $output"
    fi
    
    # Restore original config and cleanup
    CONFIG_FILE="$original_config"
    rm -rf "$temp_config_dir"
}

# Test default values
test_default_values() {
    # Create a temporary config directory
    local temp_config_dir=$(mktemp -d)
    local original_config="$CONFIG_FILE"
    CONFIG_FILE="$temp_config_dir/config.yml"
    
    # Test getting default values
    local editor=$(config_get "editor")
    local use_fzf=$(config_get "use_fzf")
    local template_dirs=$(config_get "template_dirs")
    
    local pass=true
    
    if [[ "$editor" != "vim" ]]; then
        echo "FAIL: Default editor is incorrect. Expected 'vim', got '$editor'"
        pass=false
    fi
    
    if [[ "$use_fzf" != "false" ]]; then
        echo "FAIL: Default use_fzf is incorrect. Expected 'false', got '$use_fzf'"
        pass=false
    fi
    
    if [[ "$template_dirs" != "${HOME}/.mark/templates" ]]; then
        echo "FAIL: Default template_dirs is incorrect. Expected '${HOME}/.mark/templates', got '$template_dirs'"
        pass=false
    fi
    
    if [[ "$pass" == true ]]; then
        echo "PASS: Default values are correct"
    fi
    
    # Restore original config and cleanup
    CONFIG_FILE="$original_config"
    rm -rf "$temp_config_dir"
}

# Run tests
echo "Running enhanced config tests..."
test_config_set_get
test_config_list
test_default_values
echo "Enhanced config tests completed."