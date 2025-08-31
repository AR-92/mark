#!/bin/bash

# mark - Command and Logging Tests
# Tests command execution and logging functionality

# Source test utilities
source "$(dirname "$0")/test_utils.sh"

# Setup - Clear logs before starting tests
echo "Setting up test environment..."
> "$LOG_FILE"

echo "========================================"
echo "Running Command and Logging Tests"
echo "========================================"

# COMMAND AND LOGGING TESTS
echo -e "${BLUE}COMMAND AND LOGGING TESTS${NC}"

# Test 1: List command with no prompts
# Clear logs first to ensure clean state
$MARK_SCRIPT clear > /dev/null
run_test_with_output \
    "List command with no prompts" \
    "$MARK_SCRIPT list" \
    "No prompts generated yet"

# Test 2: List command shows recent prompts
# First generate a prompt to have something to list
$MARK_SCRIPT generate $TEMPLATE_DIR/simple_template.md > /dev/null 2>&1
run_test_with_output \
    "List command shows recent prompts" \
    "$MARK_SCRIPT list" \
    "Generated prompt"

# Test 3: List command logs correctly
run_log_test \
    "List command logs to file" \
    "$MARK_SCRIPT list" \
    "Listed recent prompts"

# Test 4: Clear command
run_test_with_output \
    "Clear command clears logs" \
    "$MARK_SCRIPT clear" \
    "Logs cleared successfully"

# Test 5: Clear command logs correctly
run_log_test \
    "Clear command logs to file" \
    "$MARK_SCRIPT clear" \
    "Logs cleared"

# Test 6: Log file location
run_test \
    "Log file is created in correct location" \
    "test -f $LOG_FILE" \
    0

# Test 7: Log file permissions
run_test \
    "Log file has correct permissions" \
    "test -r $LOG_FILE && test -w $LOG_FILE" \
    0

# Test 8: Log entries are timestamped
$MARK_SCRIPT clear > /dev/null
$MARK_SCRIPT generate $TEMPLATE_DIR/simple_template.md > /dev/null
run_test_with_output \
    "Log entries are timestamped" \
    "tail -1 $LOG_FILE | grep -E '[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}'" \
    ".*"

# Print summary
print_summary "Command and Logging"
exit $((FAIL_COUNT > 0 ? 1 : 0))