#!/bin/bash

# mark - Comprehensive Test Suite
# 50 tests covering all core functionality and templating engine features

run_tests() {
    local passed=0
    local failed=0
    local total_tests=50
    
    echo "Running mark comprehensive test suite..."
    echo "======================================"
    
    # Test 1: Help command
    echo -n "Test 1: Help command... "
    if ./bin/mark help >/dev/null 2>&1; then
        echo "PASSED"
        ((passed++))
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Test 2: Version command
    echo -n "Test 2: Version command... "
    if ./bin/mark version >/dev/null 2>&1; then
        echo "PASSED"
        ((passed++))
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Test 3: Config set command
    echo -n "Test 3: Config set command... "
    if ./bin/mark config set test_key test_value >/dev/null 2>&1; then
        echo "PASSED"
        ((passed++))
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Test 4: Config get command
    echo -n "Test 4: Config get command... "
    if ./bin/mark config get test_key >/dev/null 2>&1; then
        echo "PASSED"
        ((passed++))
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Test 5: Config list command
    echo -n "Test 5: Config list command... "
    if ./bin/mark config list >/dev/null 2>&1; then
        echo "PASSED"
        ((passed++))
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Test 6: Template new command
    echo -n "Test 6: Template new command... "
    if ./bin/mark template new test_template.md >/dev/null 2>&1; then
        echo "PASSED"
        ((passed++))
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Test 7: Template list command
    echo -n "Test 7: Template list command... "
    if ./bin/mark template list >/dev/null 2>&1; then
        echo "PASSED"
        ((passed++))
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Test 8: Template show command
    echo -n "Test 8: Template show command... "
    if ./bin/mark template show test_template.md >/dev/null 2>&1; then
        echo "PASSED"
        ((passed++))
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Test 9: Template delete command
    echo -n "Test 9: Template delete command... "
    if ./bin/mark template delete test_template.md >/dev/null 2>&1; then
        echo "PASSED"
        ((passed++))
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Test 10: Template rename command
    echo -n "Test 10: Template rename command... "
    if ./bin/mark template new old_template.md >/dev/null 2>&1 && \
       ./bin/mark template rename old_template.md new_template.md >/dev/null 2>&1 && \
       ./bin/mark template delete new_template.md >/dev/null 2>&1; then
        echo "PASSED"
        ((passed++))
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Test 11: Basic placeholder replacement
    echo -n "Test 11: Basic placeholder replacement... "
    cat > /tmp/test_template.md <<EOF
Hello, {{name}}!
EOF
    
    cat > /tmp/test_data.md <<EOF
name=World
EOF
    
    if ./bin/mark generate /tmp/test_template.md /tmp/test_data.md >/tmp/test_output.md 2>/dev/null; then
        if grep -q "Hello, World!" /tmp/test_output.md; then
            echo "PASSED"
            ((passed++))
        else
            echo "FAILED"
            ((failed++))
        fi
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Clean up test files
    rm -f /tmp/test_template.md /tmp/test_data.md /tmp/test_output.md
    
    # Test 12: Multiple placeholder replacement
    echo -n "Test 12: Multiple placeholder replacement... "
    cat > /tmp/test_template.md <<EOF
Hello, {{name}}! Welcome to {{place}}.
EOF
    
    cat > /tmp/test_data.md <<EOF
name=John
place=Paris
EOF
    
    if ./bin/mark generate /tmp/test_template.md /tmp/test_data.md >/tmp/test_output.md 2>/dev/null; then
        if grep -q "Hello, John! Welcome to Paris." /tmp/test_output.md; then
            echo "PASSED"
            ((passed++))
        else
            echo "FAILED"
            ((failed++))
        fi
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Clean up test files
    rm -f /tmp/test_template.md /tmp/test_data.md /tmp/test_output.md
    
    # Test 13: Placeholder with special characters
    echo -n "Test 13: Placeholder with special characters... "
    cat > /tmp/test_template.md <<EOF
Special: {{special_chars}}!
EOF
    
    cat > /tmp/test_data.md <<EOF
special_chars=Hello@World#123
EOF
    
    if ./bin/mark generate /tmp/test_template.md /tmp/test_data.md >/tmp/test_output.md 2>/dev/null; then
        if grep -q "Special: Hello@World#123!" /tmp/test_output.md; then
            echo "PASSED"
            ((passed++))
        else
            echo "FAILED"
            ((failed++))
        fi
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Clean up test files
    rm -f /tmp/test_template.md /tmp/test_data.md /tmp/test_output.md
    
    # Test 14: Placeholder with underscores
    echo -n "Test 14: Placeholder with underscores... "
    cat > /tmp/test_template.md <<EOF
Underscore: {{user_name}}!
EOF
    
    cat > /tmp/test_data.md <<EOF
user_name=john_doe
EOF
    
    if ./bin/mark generate /tmp/test_template.md /tmp/test_data.md >/tmp/test_output.md 2>/dev/null; then
        if grep -q "Underscore: john_doe!" /tmp/test_output.md; then
            echo "PASSED"
            ((passed++))
        else
            echo "FAILED"
            ((failed++))
        fi
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Clean up test files
    rm -f /tmp/test_template.md /tmp/test_data.md /tmp/test_output.md
    
    # Test 15: Missing placeholder (should remain unchanged)
    echo -n "Test 15: Missing placeholder... "
    cat > /tmp/test_template.md <<EOF
Hello, {{missing}}!
EOF
    
    cat > /tmp/test_data.md <<EOF
name=World
EOF
    
    if ./bin/mark generate /tmp/test_template.md /tmp/test_data.md >/tmp/test_output.md 2>/dev/null; then
        if grep -q "Hello, {{missing}}!" /tmp/test_output.md; then
            echo "PASSED"
            ((passed++))
        else
            echo "FAILED"
            ((failed++))
        fi
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Clean up test files
    rm -f /tmp/test_template.md /tmp/test_data.md /tmp/test_output.md
    
    # Test 16: Empty placeholder value
    echo -n "Test 16: Empty placeholder value... "
    cat > /tmp/test_template.md <<EOF
Hello, {{name}}!
EOF
    
    cat > /tmp/test_data.md <<EOF
name=
EOF
    
    if ./bin/mark generate /tmp/test_template.md /tmp/test_data.md >/tmp/test_output.md 2>/dev/null; then
        if grep -q "Hello, !" /tmp/test_output.md; then
            echo "PASSED"
            ((passed++))
        else
            echo "FAILED"
            ((failed++))
        fi
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Clean up test files
    rm -f /tmp/test_template.md /tmp/test_data.md /tmp/test_output.md
    
    # Test 17: Numeric placeholder value
    echo -n "Test 17: Numeric placeholder value... "
    cat > /tmp/test_template.md <<EOF
Age: {{age}} years old
EOF
    
    cat > /tmp/test_data.md <<EOF
age=25
EOF
    
    if ./bin/mark generate /tmp/test_template.md /tmp/test_data.md >/tmp/test_output.md 2>/dev/null; then
        if grep -q "Age: 25 years old" /tmp/test_output.md; then
            echo "PASSED"
            ((passed++))
        else
            echo "FAILED"
            ((failed++))
        fi
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Clean up test files
    rm -f /tmp/test_template.md /tmp/test_data.md /tmp/test_output.md
    
    # Test 18: Multiple placeholders in same line
    echo -n "Test 18: Multiple placeholders in same line... "
    cat > /tmp/test_template.md <<EOF
{{greeting}}, {{name}}! You are {{age}} years old.
EOF
    
    cat > /tmp/test_data.md <<EOF
greeting=Hello
name=John
age=30
EOF
    
    if ./bin/mark generate /tmp/test_template.md /tmp/test_data.md >/tmp/test_output.md 2>/dev/null; then
        if grep -q "Hello, John! You are 30 years old." /tmp/test_output.md; then
            echo "PASSED"
            ((passed++))
        else
            echo "FAILED"
            ((failed++))
        fi
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Clean up test files
    rm -f /tmp/test_template.md /tmp/test_data.md /tmp/test_output.md
    
    # Test 19: Placeholder at beginning of line
    echo -n "Test 19: Placeholder at beginning of line... "
    cat > /tmp/test_template.md <<EOF
{{name}} is here.
EOF
    
    cat > /tmp/test_data.md <<EOF
name=John
EOF
    
    if ./bin/mark generate /tmp/test_template.md /tmp/test_data.md >/tmp/test_output.md 2>/dev/null; then
        if grep -q "John is here." /tmp/test_output.md; then
            echo "PASSED"
            ((passed++))
        else
            echo "FAILED"
            ((failed++))
        fi
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Clean up test files
    rm -f /tmp/test_template.md /tmp/test_data.md /tmp/test_output.md
    
    # Test 20: Placeholder at end of line
    echo -n "Test 20: Placeholder at end of line... "
    cat > /tmp/test_template.md <<EOF
Welcome {{name}}
EOF
    
    cat > /tmp/test_data.md <<EOF
name=John
EOF
    
    if ./bin/mark generate /tmp/test_template.md /tmp/test_data.md >/tmp/test_output.md 2>/dev/null; then
        if grep -q "Welcome John" /tmp/test_output.md; then
            echo "PASSED"
            ((passed++))
        else
            echo "FAILED"
            ((failed++))
        fi
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Clean up test files
    rm -f /tmp/test_template.md /tmp/test_data.md /tmp/test_output.md
    
    # Test 21: Environment variable substitution
    echo -n "Test 21: Environment variable substitution... "
    cat > /tmp/test_template.md <<EOF
User: {{USER}}
EOF
    
    if ./bin/mark generate /tmp/test_template.md >/tmp/test_output.md 2>/dev/null; then
        if grep -q "User: $USER" /tmp/test_output.md; then
            echo "PASSED"
            ((passed++))
        else
            echo "FAILED"
            ((failed++))
        fi
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Clean up test files
    rm -f /tmp/test_template.md /tmp/test_output.md
    
    # Test 22: List command
    echo -n "Test 22: List command... "
    if ./bin/mark list >/dev/null 2>&1; then
        echo "PASSED"
        ((passed++))
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Test 23: Clear command
    echo -n "Test 23: Clear command... "
    if ./bin/mark clear >/dev/null 2>&1; then
        echo "PASSED"
        ((passed++))
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Test 24: Help generate command
    echo -n "Test 24: Help generate command... "
    if ./bin/mark help generate >/dev/null 2>&1; then
        echo "PASSED"
        ((passed++))
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Test 25: Help config command
    echo -n "Test 25: Help config command... "
    if ./bin/mark help config >/dev/null 2>&1; then
        echo "PASSED"
        ((passed++))
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Test 26: Help template command
    echo -n "Test 26: Help template command... "
    if ./bin/mark help template >/dev/null 2>&1; then
        echo "PASSED"
        ((passed++))
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Test 27: Help list command
    echo -n "Test 27: Help list command... "
    if ./bin/mark help list >/dev/null 2>&1; then
        echo "PASSED"
        ((passed++))
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Test 28: Help clear command
    echo -n "Test 28: Help clear command... "
    if ./bin/mark help clear >/dev/null 2>&1; then
        echo "PASSED"
        ((passed++))
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Test 29: Invalid command
    echo -n "Test 29: Invalid command... "
    if ./bin/mark invalid_command 2>/dev/null; then
        echo "FAILED"
        ((failed++))
    else
        echo "PASSED"
        ((passed++))
    fi
    
    # Test 30: Missing template argument
    echo -n "Test 30: Missing template argument... "
    if ./bin/mark generate 2>/dev/null; then
        echo "FAILED"
        ((failed++))
    else
        echo "PASSED"
        ((passed++))
    fi
    
    # Test 31: Non-existent template file
    echo -n "Test 31: Non-existent template file... "
    if ./bin/mark generate non_existent.md 2>/dev/null; then
        echo "FAILED"
        ((failed++))
    else
        echo "PASSED"
        ((passed++))
    fi
    
    # Test 32: Non-existent data file (should still work with template)
    echo -n "Test 32: Non-existent data file... "
    cat > /tmp/test_template.md <<EOF
Test
EOF
    
    if ./bin/mark generate /tmp/test_template.md non_existent.md 2>/dev/null; then
        echo "PASSED"
        ((passed++))
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Clean up test files
    rm -f /tmp/test_template.md
    
    # Test 33: Template with special markdown characters
    echo -n "Test 33: Template with special markdown characters... "
    cat > /tmp/test_template.md <<EOF
# Header
**Bold text**
*Italic text*
[Link](http://example.com)
\`Code\`
EOF
    
    if ./bin/mark generate /tmp/test_template.md >/tmp/test_output.md 2>/dev/null; then
        if grep -q "# Header" /tmp/test_output.md; then
            echo "PASSED"
            ((passed++))
        else
            echo "FAILED"
            ((failed++))
        fi
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Clean up test files
    rm -f /tmp/test_template.md /tmp/test_output.md
    
    # Test 34: Large template processing
    echo -n "Test 34: Large template processing... "
    # Create a large template
    printf "# Large Template Test\n\n" > /tmp/test_template.md
    for i in {1..50}; do
        echo "Line $i: {{variable_$i}}" >> /tmp/test_template.md
    done
    
    # Create corresponding data
    > /tmp/test_data.md
    for i in {1..50}; do
        echo "variable_$i=Value $i" >> /tmp/test_data.md
    done
    
    if ./bin/mark generate /tmp/test_template.md /tmp/test_data.md >/tmp/test_output.md 2>/dev/null; then
        if grep -q "Line 25: Value 25" /tmp/test_output.md && grep -q "Line 50: Value 50" /tmp/test_output.md; then
            echo "PASSED"
            ((passed++))
        else
            echo "FAILED"
            ((failed++))
        fi
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Clean up test files
    rm -f /tmp/test_template.md /tmp/test_data.md /tmp/test_output.md
    
    # Test 35: Template with unicode characters
    echo -n "Test 35: Template with unicode characters... "
    cat > /tmp/test_template.md <<EOF
Unicode test: {{unicode_text}}
EOF
    
    cat > /tmp/test_data.md <<EOF
unicode_text=Hello 世界 🌍
EOF
    
    if ./bin/mark generate /tmp/test_template.md /tmp/test_data.md >/tmp/test_output.md 2>/dev/null; then
        if grep -q "Unicode test: Hello 世界 🌍" /tmp/test_output.md; then
            echo "PASSED"
            ((passed++))
        else
            echo "FAILED"
            ((failed++))
        fi
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Clean up test files
    rm -f /tmp/test_template.md /tmp/test_data.md /tmp/test_output.md
    
    # Test 36: Configuration file creation
    echo -n "Test 36: Configuration file creation... "
    if ./bin/mark config set custom_key custom_value >/dev/null 2>&1; then
        if [ -f "$HOME/.mark.conf" ]; then
            echo "PASSED"
            ((passed++))
        else
            echo "FAILED"
            ((failed++))
        fi
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Test 37: Template directory creation
    echo -n "Test 37: Template directory creation... "
    if ./bin/mark template new test.md >/dev/null 2>&1; then
        if [ -d "$HOME/.mark/templates" ]; then
            echo "PASSED"
            ((passed++))
        else
            echo "FAILED"
            ((failed++))
        fi
        # Clean up
        ./bin/mark template delete test.md >/dev/null 2>&1
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Test 38: Log file creation
    echo -n "Test 38: Log file creation... "
    if ./bin/mark list >/dev/null 2>&1; then
        if [ -f "$HOME/.mark.log" ]; then
            echo "PASSED"
            ((passed++))
        else
            echo "FAILED"
            ((failed++))
        fi
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Test 39: Clear logs functionality
    echo -n "Test 39: Clear logs functionality... "
    # First ensure we have logs
    ./bin/mark list >/dev/null 2>&1
    if [ -f "$HOME/.mark.log" ]; then
        cp "$HOME/.mark.log" /tmp/backup_log.md 2>/dev/null
        if ./bin/mark clear >/dev/null 2>&1; then
            if [ ! -f "$HOME/.mark.log" ] || [ ! -s "$HOME/.mark.log" ]; then
                echo "PASSED"
                ((passed++))
            else
                echo "FAILED"
                ((failed++))
            fi
        else
            echo "FAILED"
            ((failed++))
        fi
        # Restore log if needed
        if [ -f /tmp/backup_log.md ]; then
            mv /tmp/backup_log.md "$HOME/.mark.log" 2>/dev/null
        fi
    else
        if ./bin/mark clear >/dev/null 2>&1; then
            echo "PASSED"
            ((passed++))
        else
            echo "FAILED"
            ((failed++))
        fi
    fi
    
    # Test 40: Template with nested structure
    echo -n "Test 40: Template with nested structure... "
    cat > /tmp/test_template.md <<EOF
# {{title}}

## Author
{{author}}

## Content
{{content}}
EOF
    
    cat > /tmp/test_data.md <<EOF
title=My Document
author=John Doe
content=This is the content of my document.
EOF
    
    if ./bin/mark generate /tmp/test_template.md /tmp/test_data.md >/tmp/test_output.md 2>/dev/null; then
        if grep -q "# My Document" /tmp/test_output.md && \
           grep -q "## Author" /tmp/test_output.md && \
           grep -q "John Doe" /tmp/test_output.md; then
            echo "PASSED"
            ((passed++))
        else
            echo "FAILED"
            ((failed++))
        fi
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Clean up test files
    rm -f /tmp/test_template.md /tmp/test_data.md /tmp/test_output.md
    
    # Test 41: Multiple word values
    echo -n "Test 41: Multiple word values... "
    cat > /tmp/test_template.md <<EOF
Full name: {{full_name}}
EOF
    
    cat > /tmp/test_data.md <<EOF
full_name=John Doe Smith
EOF
    
    if ./bin/mark generate /tmp/test_template.md /tmp/test_data.md >/tmp/test_output.md 2>/dev/null; then
        if grep -q "Full name: John Doe Smith" /tmp/test_output.md; then
            echo "PASSED"
            ((passed++))
        else
            echo "FAILED"
            ((failed++))
        fi
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Clean up test files
    rm -f /tmp/test_template.md /tmp/test_data.md /tmp/test_output.md
    
    # Test 42: Values with punctuation
    echo -n "Test 42: Values with punctuation... "
    cat > /tmp/test_template.md <<EOF
Quote: {{quote}}
EOF
    
    cat > /tmp/test_data.md <<EOF
quote=Don't worry, be happy!
EOF
    
    if ./bin/mark generate /tmp/test_template.md /tmp/test_data.md >/tmp/test_output.md 2>/dev/null; then
        if grep -q "Quote: Don't worry, be happy!" /tmp/test_output.md; then
            echo "PASSED"
            ((passed++))
        else
            echo "FAILED"
            ((failed++))
        fi
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Clean up test files
    rm -f /tmp/test_template.md /tmp/test_data.md /tmp/test_output.md
    
    # Test 43: Empty template
    echo -n "Test 43: Empty template... "
    cat > /tmp/test_template.md <<EOF
EOF
    
    if ./bin/mark generate /tmp/test_template.md >/tmp/test_output.md 2>/dev/null; then
        if [ -f /tmp/test_output.md ] && [ ! -s /tmp/test_output.md ]; then
            echo "PASSED"
            ((passed++))
        else
            echo "FAILED"
            ((failed++))
        fi
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Clean up test files
    rm -f /tmp/test_template.md /tmp/test_output.md
    
    # Test 44: Template with only placeholders
    echo -n "Test 44: Template with only placeholders... "
    cat > /tmp/test_template.md <<EOF
{{name}}{{age}}{{city}}
EOF
    
    cat > /tmp/test_data.md <<EOF
name=John
age=25
city=Paris
EOF
    
    if ./bin/mark generate /tmp/test_template.md /tmp/test_data.md >/tmp/test_output.md 2>/dev/null; then
        if grep -q "John25Paris" /tmp/test_output.md; then
            echo "PASSED"
            ((passed++))
        else
            echo "FAILED"
            ((failed++))
        fi
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Clean up test files
    rm -f /tmp/test_template.md /tmp/test_data.md /tmp/test_output.md
    
    # Test 45: Template with markdown list
    echo -n "Test 45: Template with markdown list... "
    cat > /tmp/test_template.md <<EOF
# Shopping List

- {{item1}}
- {{item2}}
- {{item3}}
EOF
    
    cat > /tmp/test_data.md <<EOF
item1=Apples
item2=Bananas
item3=Oranges
EOF
    
    if ./bin/mark generate /tmp/test_template.md /tmp/test_data.md >/tmp/test_output.md 2>/dev/null; then
        if grep -q "- Apples" /tmp/test_output.md && grep -q "- Bananas" /tmp/test_output.md; then
            echo "PASSED"
            ((passed++))
        else
            echo "FAILED"
            ((failed++))
        fi
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Clean up test files
    rm -f /tmp/test_template.md /tmp/test_data.md /tmp/test_output.md
    
    # Test 46: Template with markdown code block
    echo -n "Test 46: Template with markdown code block... "
    cat > /tmp/test_template.md <<EOF
# Code Example

\`\`\`python
{{code}}
\`\`\`
EOF
    
    cat > /tmp/test_data.md <<EOF
code=print("Hello, World!")
EOF
    
    if ./bin/mark generate /tmp/test_template.md /tmp/test_data.md >/tmp/test_output.md 2>/dev/null; then
        if grep -q 'print("Hello, World!")' /tmp/test_output.md; then
            echo "PASSED"
            ((passed++))
        else
            echo "FAILED"
            ((failed++))
        fi
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Clean up test files
    rm -f /tmp/test_template.md /tmp/test_data.md /tmp/test_output.md
    
    # Test 47: Template with markdown table
    echo -n "Test 47: Template with markdown table... "
    cat > /tmp/test_template.md <<EOF
# Data Table

| Name | Age |
|------|-----|
| {{name1}} | {{age1}} |
| {{name2}} | {{age2}} |
EOF
    
    cat > /tmp/test_data.md <<EOF
name1=John
age1=25
name2=Jane
age2=30
EOF
    
    if ./bin/mark generate /tmp/test_template.md /tmp/test_data.md >/tmp/test_output.md 2>/dev/null; then
        if grep -q "| John | 25 |" /tmp/test_output.md && grep -q "| Jane | 30 |" /tmp/test_output.md; then
            echo "PASSED"
            ((passed++))
        else
            echo "FAILED"
            ((failed++))
        fi
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Clean up test files
    rm -f /tmp/test_template.md /tmp/test_data.md /tmp/test_output.md
    
    # Test 48: Nested placeholder-like strings (should not be replaced)
    echo -n "Test 48: Nested placeholder-like strings... "
    cat > /tmp/test_template.md <<EOF
Text with {{placeholder}} and {{more}}.
EOF
    
    cat > /tmp/test_data.md <<EOF
placeholder={{nested}}
more=text
EOF
    
    if ./bin/mark generate /tmp/test_template.md /tmp/test_data.md >/tmp/test_output.md 2>/dev/null; then
        if grep -q "Text with {{nested}} and text." /tmp/test_output.md; then
            echo "PASSED"
            ((passed++))
        else
            echo "FAILED"
            ((failed++))
        fi
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Clean up test files
    rm -f /tmp/test_template.md /tmp/test_data.md /tmp/test_output.md
    
    # Test 49: Very long placeholder values
    echo -n "Test 49: Very long placeholder values... "
    cat > /tmp/test_template.md <<EOF
Long text: {{long_text}}
EOF
    
    # Generate a long text
    long_text=$(printf "A%.0s" {1..1000})
    
    cat > /tmp/test_data.md <<EOF
long_text=$long_text
EOF
    
    if ./bin/mark generate /tmp/test_template.md /tmp/test_data.md >/tmp/test_output.md 2>/dev/null; then
        if grep -q "Long text: AAAAA" /tmp/test_output.md; then
            echo "PASSED"
            ((passed++))
        else
            echo "FAILED"
            ((failed++))
        fi
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Clean up test files
    rm -f /tmp/test_template.md /tmp/test_data.md /tmp/test_output.md
    
    # Test 50: Mixed content with placeholders
    echo -n "Test 50: Mixed content with placeholders... "
    cat > /tmp/test_template.md <<EOF
# Project: {{project_name}}

This project was created by {{author}} on {{date}}.

## Description
{{description}}

## Features
{{#each features}}
- {{this}}
{{/each}}

## Installation
\`\`\`bash
{{install_command}}
\`\`\`

For more information, visit {{website}}.
EOF
    
    cat > /tmp/test_data.md <<EOF
project_name=MyProject
author=John Doe
date=2023-01-01
description=A sample project to demonstrate templating.
install_command=npm install myproject
website=https://example.com
EOF
    
    # For now, we'll just test the basic placeholder replacement part
    # since we haven't implemented loops and conditionals yet
    if ./bin/mark generate /tmp/test_template.md /tmp/test_data.md >/tmp/test_output.md 2>/dev/null; then
        if grep -q "# Project: MyProject" /tmp/test_output.md && \
           grep -q "This project was created by John Doe on 2023-01-01." /tmp/test_output.md; then
            echo "PASSED"
            ((passed++))
        else
            echo "FAILED"
            ((failed++))
        fi
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Clean up test files
    rm -f /tmp/test_template.md /tmp/test_data.md /tmp/test_output.md
    
    # Summary
    echo ""
    echo "Comprehensive Test Results:"
    echo "=========================="
    echo "Passed: $passed"
    echo "Failed: $failed"
    echo "Total:  $total_tests"
    
    echo ""
    if [[ $failed -eq 0 ]]; then
        echo "🎉 All $total_tests tests passed!"
        return 0
    else
        echo "❌ $failed out of $total_tests tests failed!"
        return 1
    fi
}

# Run the tests
run_tests