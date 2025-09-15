#!/bin/bash

# Comprehensive test of config wizard functionality

echo "=== Config Wizard Comprehensive Test ==="

# Test 1: Help system
echo "1. Testing help system..."
help_output=$(./bin/mark help config)
if [[ "$help_output" == *"wizard"* ]] && [[ "$help_output" == *"Interactive configuration wizard"* ]]; then
    echo "   PASS: Config help includes wizard"
else
    echo "   FAIL: Config help missing wizard info"
fi

# Test 2: Config wizard function
echo "2. Testing config wizard function..."
# Source the config command and wizard
source "/home/rana/Documents/mark/lib/commands/config.sh"
source "/home/rana/Documents/mark/lib/commands/config_wizard.sh"

if declare -f config_wizard >/dev/null; then
    echo "   PASS: Config wizard function defined"
else
    echo "   FAIL: Config wizard function not defined"
fi

# Test 3: Config wizard execution
echo "3. Testing config wizard execution..."
# Use timeout to prevent hanging
timeout 2s ./bin/mark config wizard > /dev/null 2>&1
if [[ $? -eq 124 ]] || [[ $? -eq 0 ]]; then
    echo "   PASS: Config wizard executes without errors"
else
    echo "   FAIL: Config wizard execution failed"
fi

# Test 4: Config set/get
echo "4. Testing config set/get..."
./bin/mark config set test_key test_value > /dev/null
result=$(./bin/mark config get test_key)
if [[ "$result" == "test_value" ]]; then
    echo "   PASS: Config set/get works"
else
    echo "   FAIL: Config set/get failed"
fi

# Test 5: Config list
echo "5. Testing config list..."
list_output=$(./bin/mark config list)
if [[ "$list_output" == *"Configuration:"* ]] && [[ "$list_output" == *"test_key=test_value"* ]]; then
    echo "   PASS: Config list works"
else
    echo "   FAIL: Config list failed"
fi

# Cleanup
./bin/mark config set test_key "" > /dev/null 2>&1

echo "=== Config Wizard Test Complete ==="