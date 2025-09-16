#!/bin/bash

# Comprehensive integration test

echo "=== Comprehensive Integration Test ==="

# Test 1: Help system
echo "1. Testing help system..."
./bin/mark help > /dev/null && echo "   PASS: Basic help works"
./bin/mark help generate > /dev/null && echo "   PASS: Detailed generate help works"
./bin/mark help template > /dev/null && echo "   PASS: Detailed template help works"
./bin/mark help config > /dev/null && echo "   PASS: Detailed config help works"

# Test 2: Configuration management
echo "2. Testing configuration management..."
./bin/mark config set editor test_editor > /dev/null
result=$(./bin/mark config get editor)
if [[ "$result" == "test_editor" ]]; then
    echo "   PASS: Config set/get works"
else
    echo "   FAIL: Config set/get failed"
fi

./bin/mark config list > /dev/null && echo "   PASS: Config list works"

# Test 3: Template management
echo "3. Testing template management..."
# Create a test template directory
mkdir -p $HOME/.mark/templates

# Create a test template
echo "# Test Template

Hello {{name}}!" > $HOME/.mark/templates/test.md

# Test template list
./bin/mark template list > /dev/null && echo "   PASS: Template list works"

# Test template show
./bin/mark template show test > /dev/null && echo "   PASS: Template show works"

# Test 4: Configuration
echo "4. Testing configuration..."
# Test configuration
./bin/mark config set test_key test_value > /dev/null 2>&1 && echo "   PASS: Configuration set works" || echo "   FAIL: Configuration set failed"
./bin/mark config get test_key > /dev/null 2>&1 && echo "   PASS: Configuration get works" || echo "   FAIL: Configuration get failed"
./bin/mark config list > /dev/null 2>&1 && echo "   PASS: Configuration list works" || echo "   FAIL: Configuration list failed"

# Test 5: Version command
echo "5. Testing version command..."
result=$(./bin/mark version)
if [[ "$result" == "mark 1.0.0" ]]; then
    echo "   PASS: Version command works"
else
    echo "   FAIL: Version command failed"
fi

# Cleanup
rm -f $HOME/.mark/templates/test.md

echo "=== Integration Test Complete ==="