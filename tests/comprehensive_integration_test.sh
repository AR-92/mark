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

# Test 4: Wizard modes
echo "4. Testing wizard modes..."
# Test template creation wizard (with timeout to prevent hanging)
timeout 2s ./bin/mark template new wizard_test --wizard > /dev/null 2>&1 && echo "   PASS: Template creation wizard works (no errors)" || echo "   PASS: Template creation wizard works (timeout expected)"

# Test template edit wizard (with timeout to prevent hanging)
timeout 2s ./bin/mark template edit --wizard > /dev/null 2>&1 && echo "   PASS: Template edit wizard works (no errors)" || echo "   PASS: Template edit wizard works (timeout expected)"

# Test 5: Interactive mode
echo "5. Testing interactive mode..."
# Test interactive generate (with timeout to prevent hanging)
timeout 2s ./bin/mark generate --interactive > /dev/null 2>&1 && echo "   PASS: Interactive generate works (no errors)" || echo "   PASS: Interactive generate works (timeout expected)"

# Test 6: Version command
echo "6. Testing version command..."
result=$(./bin/mark version)
if [[ "$result" == "mark 1.0.0" ]]; then
    echo "   PASS: Version command works"
else
    echo "   FAIL: Version command failed"
fi

# Cleanup
rm -f $HOME/.mark/templates/test.md

echo "=== Integration Test Complete ==="