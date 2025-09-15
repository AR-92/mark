#!/bin/bash

# mark - Basic Functionality Tests
# Tests basic commands and functionality

# Source test utilities
source "$(dirname "$0")/test_utils.sh"

# Setup - Clear logs before starting tests
echo "Setting up test environment..."
> "$LOG_FILE"

echo "========================================"
echo "Running Basic Functionality Tests"
echo "========================================"

# BASIC FUNCTIONALITY TESTS
echo -e "${BLUE}BASIC FUNCTIONALITY TESTS${NC}"

# Test 1: Help command
run_test_with_output \
    "Help command displays help text" \
    "$MARK_SCRIPT help" \
    "mark 1.0.0 - AI prompt templating tool"

# Test 2: Help command logs correctly
run_log_test \
    "Help command logs to file" \
    "$MARK_SCRIPT help" \
    "Help displayed"

# Test 3: No command provided
run_test \
    "No command provided returns error" \
    "$MARK_SCRIPT" \
    1

# Test 4: Unknown command
run_test \
    "Unknown command returns error" \
    "$MARK_SCRIPT unknown" \
    1

# Test 5: Generate command with .md template
run_test_with_output \
    "Generate command with .md template" \
    "$MARK_SCRIPT generate $TEMPLATE_DIR/simple_template.md" \
    "Write a.*program that"

# Test 6: Generate command logs correctly
run_log_test \
    "Generate command logs to file" \
    "$MARK_SCRIPT generate $TEMPLATE_DIR/simple_template.md" \
    "Generated prompt from template"

# Test 7: Generate command with .md data file
run_test_with_output \
    "Generate command with .md data file" \
    "$MARK_SCRIPT generate $TEMPLATE_DIR/profile_template.md $DATA_DIR/data.md" \
    "John Doe is a Software Engineer"

# Test 8: Generate command with environment variables
# Create a temporary data file for this test
echo "language=Python" > /tmp/test_env_vars.md
echo "task=sorts a list of numbers" >> /tmp/test_env_vars.md

run_test_with_output \
    "Generate command with environment-like variables" \
    "$MARK_SCRIPT generate $TEMPLATE_DIR/simple_template.md /tmp/test_env_vars.md" \
    "Write a Python program that sorts a list of numbers"

# Clean up
rm -f /tmp/test_env_vars.md

# Test 9: Generate command with missing .md template file
run_test \
    "Generate command with missing .md template returns error" \
    "$MARK_SCRIPT generate nonexistent_template.md" \
    1

# Test 10: Generate command logs error for missing .md template
run_log_test \
    "Generate command logs error for missing .md template" \
    "$MARK_SCRIPT generate nonexistent_template.md || true" \
    "ERROR: Template file.*not found"

# Print summary
print_summary "Basic Functionality"
exit $((FAIL_COUNT > 0 ? 1 : 0))