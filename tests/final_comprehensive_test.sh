#!/bin/bash

# Comprehensive test of mark tool functionality

echo "=== Testing mark tool functionality ==="

# Test version command
echo "1. Testing version command..."
output=$(./bin/mark version)
if [[ "$output" == "mark 1.0.0" ]]; then
    echo "   PASS: Version command works"
else
    echo "   FAIL: Version command failed"
fi

# Test config commands
echo "2. Testing config commands..."
./bin/mark config set editor test_editor > /dev/null
output=$(./bin/mark config get editor)
if [[ "$output" == "test_editor" ]]; then
    echo "   PASS: Config set/get works"
else
    echo "   FAIL: Config set/get failed"
fi

output=$(./bin/mark config list)
if [[ "$output" == *"Configuration:"* ]]; then
    echo "   PASS: Config list works"
else
    echo "   FAIL: Config list failed"
fi

# Test template commands
echo "3. Testing template commands..."
output=$(./bin/mark template list)
if [[ "$output" == *"test.md"* ]]; then
    echo "   PASS: Template list works"
else
    echo "   FAIL: Template list failed"
fi

output=$(./bin/mark template show test)
if [[ "$output" == *"Test Template"* ]]; then
    echo "   PASS: Template show works"
else
    echo "   FAIL: Template show failed"
fi

# Test help command
echo "4. Testing help command..."
output=$(./bin/mark help)
if [[ "$output" == *"mark 1.0.0 - AI prompt templating tool"* ]]; then
    echo "   PASS: Help command works"
else
    echo "   FAIL: Help command failed"
fi

echo "=== Testing completed ==="