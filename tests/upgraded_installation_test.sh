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
if [[ "$help_output" == *"MARK - AI Prompt Templating Tool"* ]]; then
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

# Test 4: Template commands
echo "4. Testing template commands..."
template_list=$(mark template list)
if [[ "$template_list" == *"Available templates:"* ]]; then
    echo "   PASS: Template list works"
else
    echo "   FAIL: Template list failed"
fi

# Test 5: Generate command with a simple template
echo "5. Testing generate command with simple template..."
# Create a simple test template
echo "{{test_variable}}" > ~/.mark/templates/test_template.md
generate_result=$(mark generate test_template.md 2>&1)
if [[ $? -eq 0 ]]; then
    echo "   PASS: Generate command works"
else
    echo "   FAIL: Generate command failed"
fi

# Cleanup the test template
rm -f ~/.mark/templates/test_template.md

# Cleanup
mark config set test_key "" > /dev/null 2>&1

echo "=== Upgraded Installation Test Complete ==="