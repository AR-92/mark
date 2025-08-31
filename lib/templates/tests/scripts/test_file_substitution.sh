#!/bin/bash

# mark - File Substitution Tests
# Tests file inclusion functionality

# Source test utilities
source "$(dirname "$0")/test_utils.sh"

# Setup - Clear logs before starting tests
echo "Setting up test environment..."
> "$LOG_FILE"

echo "========================================"
echo "Running File Substitution Tests"
echo "========================================"

# FILE SUBSTITUTION TESTS
echo -e "${BLUE}FILE SUBSTITUTION TESTS${NC}"

# Test 11: File substitution with existing file
run_test_with_output \
    "File substitution with existing file" \
    "$MARK_SCRIPT generate $TEMPLATE_DIR/file_substitution_template.md" \
    "Code Example"

# Test 12: File substitution with non-existing file
echo "Content with {{@nonexistent_file.md}}" > /tmp/file_sub_template.md
run_test_with_output \
    "File substitution with non-existing file" \
    "$MARK_SCRIPT generate /tmp/file_sub_template.md" \
    "\[File not found: nonexistent_file.md\]"

# Test 13: File substitution preserves markdown formatting
run_test_with_output \
    "File substitution preserves markdown formatting" \
    "$MARK_SCRIPT generate $TEMPLATE_DIR/file_substitution_template.md" \
    "\`\`\`python"

# FILE SUBSTITUTION ADVANCED TESTS
echo -e "${BLUE}FILE SUBSTITUTION ADVANCED TESTS${NC}"

# Test 14: Multiple file substitutions in one template
# First check if the files exist
if [[ -f "$DATA_DIR/code_example.md" && -f "$DATA_DIR/requirements.md" ]]; then
    echo "First file: {{@$DATA_DIR/code_example.md}} Second file: {{@$DATA_DIR/requirements.md}}" > /tmp/multi_file_template.md
    run_test_with_output \
        "Multiple file substitutions in one template" \
        "$MARK_SCRIPT generate /tmp/multi_file_template.md" \
        "First file: # Code Example"
else
    # Skip test if files don't exist
    TEST_COUNT=$((TEST_COUNT + 1))
    echo -e "Test $TEST_COUNT: Multiple file substitutions in one template ... ${YELLOW}SKIPPED${NC}"
    PASS_COUNT=$((PASS_COUNT + 1))
fi

# Test 15: File substitution with nested directories
mkdir -p /tmp/nested_dir
echo "Nested content" > /tmp/nested_dir/nested_file.md
echo "Content: {{@/tmp/nested_dir/nested_file.md}}" > /tmp/nested_template.md
run_test_with_output \
    "File substitution with nested directories" \
    "$MARK_SCRIPT generate /tmp/nested_template.md" \
    "Content: Nested content"

# Test 16: File substitution with empty file
echo "" > /tmp/empty_file.md
echo "Empty: {{@/tmp/empty_file.md}}" > /tmp/empty_file_template.md
run_test_with_output \
    "File substitution with empty file" \
    "$MARK_SCRIPT generate /tmp/empty_file_template.md" \
    "^Empty: $"

# Test 17: File substitution with special characters in filename
echo "Special content" > "/tmp/special chars.md"
echo "Special: {{@/tmp/special chars.md}}" > /tmp/special_template.md
run_test_with_output \
    "File substitution with special characters in filename" \
    "$MARK_SCRIPT generate /tmp/special_template.md" \
    "Special: Special content"

# Test 18: File substitution combined with variable substitution
# First check if the file exists
if [[ -f "$DATA_DIR/code_example.md" ]]; then
    echo "File: {{@$DATA_DIR/code_example.md}} Variable: {{name}}" > /tmp/combined_template.md
    run_test_with_output \
        "File substitution combined with variable substitution" \
        "name=John $MARK_SCRIPT generate /tmp/combined_template.md" \
        "File: # Code Example"
else
    # Skip test if file doesn't exist
    TEST_COUNT=$((TEST_COUNT + 1))
    echo -e "Test $TEST_COUNT: File substitution combined with variable substitution ... ${YELLOW}SKIPPED${NC}"
    PASS_COUNT=$((PASS_COUNT + 1))
fi

# Test 19: File substitution with large files
# Create a large file
printf "Line %d\n" {1..100} > /tmp/large_file.md
echo "Large file content: {{@/tmp/large_file.md}}" > /tmp/large_template.md
run_test_with_output \
    "File substitution with large files" \
    "$MARK_SCRIPT generate /tmp/large_template.md | grep -c 'Line 50'" \
    "1"

# Test 20: File substitution with formatted content
echo -e "Line 1\nLine 2\n\tTabbed line\nLine 4" > /tmp/formatted_file.md
echo "Formatted: {{@/tmp/formatted_file.md}}" > /tmp/formatted_template.md
run_test_with_output \
    "File substitution with formatted content" \
    "$MARK_SCRIPT generate /tmp/formatted_template.md" \
    "Formatted: Line 1"

# Cleanup
rm -f /tmp/file_sub_template.md /tmp/multi_file_template.md /tmp/nested_template.md \
      /tmp/empty_file.md /tmp/empty_file_template.md "/tmp/special chars.md" \
      /tmp/special_template.md /tmp/combined_template.md /tmp/large_file.md \
      /tmp/large_template.md /tmp/formatted_file.md /tmp/formatted_template.md
rm -rf /tmp/nested_dir

# Print summary
print_summary "File Substitution"
exit $((FAIL_COUNT > 0 ? 1 : 0))