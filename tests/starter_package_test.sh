#!/bin/bash

# Comprehensive test of mark starter package

echo "=== mark Starter Package Comprehensive Test ==="

# Test 1: List templates
echo "1. Testing template listing..."
templates=$(./bin/mark template list)
template_count=$(echo "$templates" | grep -c "\.md")
if [[ "$template_count" -ge 10 ]]; then
    echo "   PASS: Found $template_count templates"
else
    echo "   FAIL: Expected at least 10 templates, found $template_count"
fi

# Test 2: Show a template
echo "2. Testing template show..."
template_content=$(./bin/mark template show code-review 2>/dev/null)
if [[ "$template_content" == *"Professional code review prompt"* ]]; then
    echo "   PASS: Template show works"
else
    echo "   FAIL: Template show failed"
fi

# Test 3: Generate a prompt
echo "3. Testing prompt generation..."
# Use timeout to prevent hanging
generated=$(timeout 5s ./bin/mark generate $HOME/.mark/templates/code-review.md starter/data/code-review-data.txt 2>/dev/null)
if [[ "$generated" == *"Customer Portal Redesign"* ]] && [[ "$generated" == *"JavaScript developer"* ]]; then
    echo "   PASS: Prompt generation works"
else
    echo "   FAIL: Prompt generation failed"
fi

# Test 4: Configuration
echo "4. Testing configuration..."
config_list=$(./bin/mark config list 2>/dev/null)
if [[ "$config_list" == *"template_dirs"* ]] && [[ "$config_list" == *"editor"* ]]; then
    echo "   PASS: Configuration works"
else
    echo "   FAIL: Configuration failed"
fi

# Test 5: Help system
echo "5. Testing help system..."
help_output=$(./bin/mark help 2>/dev/null)
if [[ "$help_output" == *"mark 1.0.0"* ]] && [[ "$help_output" == *"generate"* ]] && [[ "$help_output" == *"template"* ]]; then
    echo "   PASS: Help system works"
else
    echo "   FAIL: Help system failed"
fi

# Test 6: Version
echo "6. Testing version..."
version_output=$(./bin/mark version 2>/dev/null)
if [[ "$version_output" == "mark 1.0.0" ]]; then
    echo "   PASS: Version works"
else
    echo "   FAIL: Version failed"
fi

echo "=== Comprehensive Test Complete ==="