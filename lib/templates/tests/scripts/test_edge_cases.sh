#!/bin/bash

# mark - Edge Case Tests
# Tests edge cases and special scenarios

# Source test utilities
source "$(dirname "$0")/test_utils.sh"

# Setup - Clear logs before starting tests
echo "Setting up test environment..."
> "$LOG_FILE"

echo "========================================"
echo "Running Edge Case Tests"
echo "========================================"

# EDGE CASE TESTS
echo -e "${BLUE}EDGE CASE TESTS${NC}"

# Test 1: Empty template
echo "" > /tmp/empty_template.md
run_test_with_output \
    "Empty template handling" \
    "$MARK_SCRIPT generate /tmp/empty_template.md" \
    "^$"

# Test 2: Template with no placeholders
echo "This template has no placeholders." > /tmp/no_placeholder_template.md
run_test_with_output \
    "Template with no placeholders" \
    "$MARK_SCRIPT generate /tmp/no_placeholder_template.md" \
    "This template has no placeholders"

# Test 3: Comments in data files
echo "Value: {{key}}" > /tmp/comment_template.md
echo "key=value" > /tmp/comment_data.md
echo "# This is a comment" >> /tmp/comment_data.md
echo "  # Another comment with spaces" >> /tmp/comment_data.md
echo "" >> /tmp/comment_data.md
run_test_with_output \
    "Comments in data files" \
    "$MARK_SCRIPT generate /tmp/comment_template.md /tmp/comment_data.md" \
    "Value: value"

# Test 4: Large template processing
printf "Line %d: {{placeholder}}\n" {1..50} > /tmp/large_template.md
echo "placeholder=test_value" > /tmp/large_data.md
run_test_with_output \
    "Large template processing" \
    "$MARK_SCRIPT generate /tmp/large_template.md /tmp/large_data.md | grep -c 'test_value'" \
    "50"

# Test 5: Unicode characters in templates and data
echo "Unicode: {{greeting}} {{name}}! 🚀" > /tmp/unicode_template.md
echo "greeting=こんにちは" > /tmp/unicode_data.md
echo "name=世界" >> /tmp/unicode_data.md
run_test_with_output \
    "Unicode characters support" \
    "$MARK_SCRIPT generate /tmp/unicode_template.md /tmp/unicode_data.md" \
    "Unicode: こんにちは 世界! 🚀"

# Cleanup
rm -f /tmp/empty_template.md /tmp/no_placeholder_template.md /tmp/comment_template.md \
      /tmp/comment_data.md /tmp/large_template.md /tmp/large_data.md \
      /tmp/unicode_template.md /tmp/unicode_data.md

# Print summary
print_summary "Edge Cases"
exit $((FAIL_COUNT > 0 ? 1 : 0))