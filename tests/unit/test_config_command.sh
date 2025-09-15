#!/bin/bash

# Test config command

# Test config set command
test_config_command_set() {
    # Create a test script that simulates the config command
    local test_script=$(mktemp)
    cat > "$test_script" << 'EOF'
#!/bin/bash
source "/home/rana/Documents/mark/lib/core/enhanced_config.sh"

# Simulate the config command
case "$1" in
    set)
        config_set "$2" "$3"
        echo "Set $2 to $3"
        ;;
    get)
        result=$(config_get "$2")
        echo "$result"
        ;;
    list)
        config_list
        ;;
    *)
        echo "Usage: mark config [set|get|list] [key] [value]"
        ;;
esac
EOF
    
    chmod +x "$test_script"
    
    # Create a temporary config directory
    local temp_config_dir=$(mktemp -d)
    local original_config="$CONFIG_FILE"
    CONFIG_FILE="$temp_config_dir/config.yml"
    
    # Test setting a value
    local output=$("$test_script" set editor code)
    
    if [[ "$output" == "Set editor to code" ]]; then
        echo "PASS: Config set command works"
    else
        echo "FAIL: Config set command failed"
        echo "Output: $output"
    fi
    
    # Test getting the value
    local result=$("$test_script" get editor)
    
    if [[ "$result" == "code" ]]; then
        echo "PASS: Config get command works"
    else
        echo "FAIL: Config get command failed. Expected 'code', got '$result'"
    fi
    
    # Restore original config and cleanup
    CONFIG_FILE="$original_config"
    rm -rf "$temp_config_dir" "$test_script"
}

# Run tests
echo "Running config command tests..."
test_config_command_set
echo "Config command tests completed."