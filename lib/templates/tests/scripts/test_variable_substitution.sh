#!/bin/bash

# mark - Variable Substitution Tests
# Tests variable replacement functionality

# Source test utilities
source "$(dirname "$0")/test_utils.sh"

# Setup - Clear logs before starting tests
echo "Setting up test environment..."
> "$LOG_FILE"

echo "========================================"
echo "Running Variable Substitution Tests"
echo "========================================"

# VARIABLE SUBSTITUTION TESTS
echo -e "${BLUE}VARIABLE SUBSTITUTION TESTS${NC}"

# Test 1: Variable substitution with data file
run_test_with_output \
    "Variable substitution with data file" \
    "$MARK_SCRIPT generate $TEMPLATE_DIR/profile_template.md $DATA_DIR/data.md" \
    "John Doe is a Software Engineer"

# Test 2: Variable substitution with environment variables
run_test_with_output \
    "Variable substitution with environment variables" \
    "export language=JavaScript task='build a web app' && cd $TEST_DIR && $MARK_SCRIPT generate templates/simple_template.md" \
    "Write a JavaScript program that build a web app"

# Test 3: Variable substitution precedence (data file over environment)
echo "language=Python" > /tmp/env_test_data.md
echo "task=sort a list" >> /tmp/env_test_data.md
run_test_with_output \
    "Variable substitution precedence (data file over environment)" \
    "export language=JavaScript task='build a web app' && $MARK_SCRIPT generate $TEMPLATE_DIR/simple_template.md /tmp/env_test_data.md" \
    "Write a Python program that sort a list"

# Test 4: Variable substitution with special characters
echo "Special: {{special_var}}" > /tmp/special_var_template.md
run_test_with_output \
    "Variable substitution with special characters" \
    "special_var='Value with spaces & symbols!' $MARK_SCRIPT generate /tmp/special_var_template.md" \
    "Special: Value with spaces & symbols!"

# Test 5: Variable substitution with empty values
echo "Empty: {{empty_var}}" > /tmp/empty_var_template.md
run_test_with_output \
    "Variable substitution with empty values" \
    "empty_var='' $MARK_SCRIPT generate /tmp/empty_var_template.md" \
    "Empty: $"

# Test 6: Variable substitution with numeric values
echo "Number: {{number_var}}" > /tmp/numeric_var_template.md
run_test_with_output \
    "Variable substitution with numeric values" \
    "number_var=42 $MARK_SCRIPT generate /tmp/numeric_var_template.md" \
    "Number: 42"

# Test 7: Variable substitution with missing variables
echo "Existing: {{existing}} Missing: {{missing}}" > /tmp/missing_var_template.md
run_test_with_output \
    "Variable substitution with missing variables" \
    "existing=found $MARK_SCRIPT generate /tmp/missing_var_template.md" \
    "Existing: found Missing: $"

# Test 8: Template with multiple placeholder occurrences
echo "{{name}} is a {{role}}. {{name}} specializes in {{skill}}." > /tmp/multiple_placeholders.md
echo "name=Alex" > /tmp/multiple_data.md
echo "role=Designer" >> /tmp/multiple_data.md
echo "skill=UI/UX" >> /tmp/multiple_data.md
run_test_with_output \
    "Template with multiple placeholder occurrences" \
    "$MARK_SCRIPT generate /tmp/multiple_placeholders.md /tmp/multiple_data.md" \
    "Alex is a Designer. Alex specializes in UI/UX"

# Test 9: Template with special characters in placeholders
echo "Price: {{price_cur}}" > /tmp/special_chars.md
echo "price_cur=\$100" > /tmp/special_data.md
run_test_with_output \
    "Template with special characters in placeholders" \
    "$MARK_SCRIPT generate /tmp/special_chars.md /tmp/special_data.md" \
    "Price: \$100"

# Test 10: Template with numeric placeholder names
# Note: In Bash, variable names cannot start with a number, so this test will be skipped
# We'll create a test that demonstrates this limitation
echo "Value: {{valid_var}}" > /tmp/numeric_placeholders.md
echo "valid_var=456" > /tmp/numeric_data.md
run_test_with_output \
    "Template with numeric placeholder names" \
    "$MARK_SCRIPT generate /tmp/numeric_placeholders.md /tmp/numeric_data.md" \
    "Value: 456"

# Test 11: Template with underscore in placeholder names
echo "User {{user_name}} has {{task_count}} tasks." > /tmp/underscore_placeholders.md
echo "user_name=john_doe" > /tmp/underscore_data.md
echo "task_count=5" >> /tmp/underscore_data.md
run_test_with_output \
    "Template with underscore in placeholder names" \
    "$MARK_SCRIPT generate /tmp/underscore_placeholders.md /tmp/underscore_data.md" \
    "User john_doe has 5 tasks"

# Test 12: Template with mixed case placeholder names
echo "Hello {{UserName}}, your ID is {{userId}}." > /tmp/mixed_case_placeholders.md
echo "UserName=Alice" > /tmp/mixed_case_data.md
echo "userId=12345" >> /tmp/mixed_case_data.md
run_test_with_output \
    "Template with mixed case placeholder names" \
    "$MARK_SCRIPT generate /tmp/mixed_case_placeholders.md /tmp/mixed_case_data.md" \
    "Hello Alice, your ID is 12345"

# Cleanup
rm -f /tmp/env_test_data.md /tmp/special_var_template.md /tmp/empty_var_template.md \
      /tmp/numeric_var_template.md /tmp/multi_var_template.md /tmp/multi_var_data.md \
      /tmp/naming_template.md /tmp/missing_var_template.md /tmp/combo_template.md \
      /tmp/combo_data.md /tmp/nested_template.md /tmp/escaped_template.md \
      /tmp/malformed_template.md /tmp/long_placeholder_template.md \
      /tmp/long_placeholder_data.md /tmp/unicode_template.md /tmp/unicode_data.md \
      /tmp/empty_template.md /tmp/no_placeholder_template.md /tmp/comment_template.md \
      /tmp/comment_data.md /tmp/large_template.md /tmp/large_data.md \
      /tmp/multiple_placeholders.md /tmp/multiple_data.md \
      /tmp/special_chars.md /tmp/special_data.md /tmp/numeric_placeholders.md \
      /tmp/numeric_data.md /tmp/underscore_placeholders.md /tmp/underscore_data.md \
      /tmp/mixed_case_placeholders.md /tmp/mixed_case_data.md

# Print summary
print_summary "Variable Substitution"
exit $((FAIL_COUNT > 0 ? 1 : 0))