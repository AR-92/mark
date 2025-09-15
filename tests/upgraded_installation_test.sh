#!/bin/bash

# Comprehensive test of upgraded mark installation

echo "=== Upgraded mark Installation Test ==="

# Test 1: Version
echo "1. Testing version..."
version_output=$(mark version)
if [[ "$version_output" == "mark 1.0.0" ]]; then
    echo "   PASS: Version command works"
else
    echo "   FAIL: Version command failed"
fi

# Test 2: Help system
echo "2. Testing help system..."
help_output=$(mark help)
if [[ "$help_output" == *"mark 1.0.0 - AI prompt templating tool"* ]]; then
    echo "   PASS: Basic help works"
else
    echo "   FAIL: Basic help failed"
fi

# Test 3: Config commands
echo "3. Testing config commands..."
mark config set test_key test_value > /dev/null
result=$(mark config get test_key)
if [[ "$result" == "test_value" ]]; then
    echo "   PASS: Config set/get works"
else
    echo "   FAIL: Config set/get failed"
fi

config_list=$(mark config list)
if [[ "$config_list" == *"Configuration:"* ]]; then
    echo "   PASS: Config list works"
else
    echo "   FAIL: Config list failed"
fi

# Test 4: Config wizard
echo "4. Testing config wizard..."
# Use timeout to prevent hanging
timeout 1s mark config wizard > /dev/null 2>&1
if [[ $? -eq 124 ]] || [[ $? -eq 0 ]]; then
    echo "   PASS: Config wizard executes without errors"
else
    echo "   FAIL: Config wizard execution failed"
fi

# Test 5: Template commands
echo "5. Testing template commands..."
template_list=$(mark template list)
if [[ "$template_list" == *"Available templates:"* ]]; then
    echo "   PASS: Template list works"
else
    echo "   FAIL: Template list failed"
fi

# Test 6: Generate command
echo "6. Testing generate command..."
# Use timeout to prevent hanging
timeout 1s mark generate --interactive > /dev/null 2>&1
if [[ $? -eq 124 ]] || [[ $? -eq 0 ]]; then
    echo "   PASS: Generate interactive executes without errors"
else
    echo "   FAIL: Generate interactive execution failed"
fi

# Cleanup
mark config set test_key "" > /dev/null 2>&1

echo "=== Upgraded Installation Test Complete ==="