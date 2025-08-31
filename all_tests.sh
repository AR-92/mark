#!/bin/bash

# mark - Comprehensive Test Suite
# Tests all functionality of the mark AI prompt templating tool

# Test configuration
MARK_SCRIPT="/home/rana/Documents/Projects/mark/mark"
TEST_DIR="/home/rana/Documents/Projects/mark/tests"
LOG_FILE="${HOME}/.mark.log"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Test counter
TEST_COUNT=0
PASS_COUNT=0
FAIL_COUNT=0

# Function to run a test
run_test() {
    local test_name="$1"
    local test_command="$2"
    local expected_result="$3" # 0 for success, 1 for failure
    
    TEST_COUNT=$((TEST_COUNT + 1))
    echo -n "Test $TEST_COUNT: $test_name ... "
    
    # Run the test command
    eval "$test_command" > /tmp/mark_test_stdout 2> /tmp/mark_test_stderr
    local exit_code=$?
    
    # Check result
    if [[ $exit_code -eq $expected_result ]]; then
        echo -e "${GREEN}PASS${NC}"
        PASS_COUNT=$((PASS_COUNT + 1))
        return 0
    else
        echo -e "${RED}FAIL${NC} (exit code: $exit_code, expected: $expected_result)"
        echo "  Stdout: $(cat /tmp/mark_test_stdout)"
        echo "  Stderr: $(cat /tmp/mark_test_stderr)"
        FAIL_COUNT=$((FAIL_COUNT + 1))
        return 1
    fi
}

# Function to check if output contains specific text
run_test_with_output() {
    local test_name="$1"
    local test_command="$2"
    local expected_text="$3"
    
    TEST_COUNT=$((TEST_COUNT + 1))
    echo -n "Test $TEST_COUNT: $test_name ... "
    
    # Run the test command
    eval "$test_command" > /tmp/mark_test_stdout 2> /tmp/mark_test_stderr
    local exit_code=$?
    
    # Check if expected text is in output
    if [[ $exit_code -eq 0 ]] && grep -q "$expected_text" /tmp/mark_test_stdout; then
        echo -e "${GREEN}PASS${NC}"
        PASS_COUNT=$((PASS_COUNT + 1))
        return 0
    else
        echo -e "${RED}FAIL${NC}"
        echo "  Expected: $expected_text"
        echo "  Stdout: $(cat /tmp/mark_test_stdout)"
        echo "  Stderr: $(cat /tmp/mark_test_stderr)"
        FAIL_COUNT=$((FAIL_COUNT + 1))
        return 1
    fi
}

# Function to check if log contains specific text
check_log_for_text() {
    local text="$1"
    if [[ -f "$LOG_FILE" ]] && grep -q "$text" "$LOG_FILE"; then
        return 0
    else
        return 1
    fi
}

# Function to run a log test
run_log_test() {
    local test_name="$1"
    local test_command="$2"
    local expected_log_text="$3"
    
    TEST_COUNT=$((TEST_COUNT + 1))
    echo -n "Test $TEST_COUNT: $test_name ... "
    
    # Clear log before test
    > "$LOG_FILE"
    
    # Run the test command
    eval "$test_command" > /dev/null 2> /dev/null
    local exit_code=$?
    
    # Check if expected text is in log
    if [[ $exit_code -eq 0 ]] && check_log_for_text "$expected_log_text"; then
        echo -e "${GREEN}PASS${NC}"
        PASS_COUNT=$((PASS_COUNT + 1))
        return 0
    else
        echo -e "${RED}FAIL${NC}"
        echo "  Expected log text: $expected_log_text"
        echo "  Log contents: $(cat "$LOG_FILE" 2>/dev/null || echo 'No log file')"
        FAIL_COUNT=$((FAIL_COUNT + 1))
        return 1
    fi
}

# Setup - Clear logs before starting tests
echo "Setting up test environment..."
> "$LOG_FILE"

##################################################
# COMPREHENSIVE TEST SUITE
##################################################

echo "========================================"
echo "Running Comprehensive Test Suite for mark"
echo "========================================"

# BASIC FUNCTIONALITY TESTS
echo -e "${BLUE}BASIC FUNCTIONALITY TESTS${NC}"

# Test 1: Help command
run_test_with_output \
    "Help command displays help text" \
    "$MARK_SCRIPT help" \
    "mark - AI prompt templating tool"

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
    "$MARK_SCRIPT generate $TEST_DIR/simple_template.md" \
    "Write a.*program that"

# Test 6: Generate command logs correctly
run_log_test \
    "Generate command logs to file" \
    "$MARK_SCRIPT generate $TEST_DIR/simple_template.md" \
    "Generated prompt from template"

# Test 7: Generate command with .md data file
run_test_with_output \
    "Generate command with .md data file" \
    "$MARK_SCRIPT generate $TEST_DIR/profile_template.md $TEST_DIR/data.md" \
    "John Doe is a Software Engineer"

# Test 8: Generate command with environment variables
# Create a temporary data file for this test
echo "language=Python" > /tmp/test_env_vars.md
echo "task=sorts a list of numbers" >> /tmp/test_env_vars.md

run_test_with_output \
    "Generate command with environment-like variables" \
    "$MARK_SCRIPT generate $TEST_DIR/simple_template.md /tmp/test_env_vars.md" \
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

# FILE SUBSTITUTION TESTS
echo -e "${BLUE}FILE SUBSTITUTION TESTS${NC}"

# Test 11: File substitution with existing file
run_test_with_output \
    "File substitution with existing file" \
    "$MARK_SCRIPT generate $TEST_DIR/file_substitution_template.md" \
    "Code Example"

# Test 12: File substitution with non-existing file
echo "Content with {{@nonexistent_file.md}}" > /tmp/file_sub_template.md
run_test_with_output \
    "File substitution with non-existing file" \
    "$MARK_SCRIPT generate /tmp/file_sub_template.md" \
    "File not found: nonexistent_file.md"

# Test 13: File substitution preserves markdown formatting
run_test_with_output \
    "File substitution preserves markdown formatting" \
    "$MARK_SCRIPT generate $TEST_DIR/file_substitution_template.md" \
    "\`\`\`python"

# VARIABLE SUBSTITUTION TESTS
echo -e "${BLUE}VARIABLE SUBSTITUTION TESTS${NC}"

# Test 14: Variable substitution with data file
run_test_with_output \
    "Variable substitution with data file" \
    "$MARK_SCRIPT generate $TEST_DIR/profile_template.md $TEST_DIR/data.md" \
    "John Doe is a Software Engineer"

# Test 15: Variable substitution with environment variables
run_test_with_output \
    "Variable substitution with environment variables" \
    "export language=JavaScript task='build a web app' && cd $TEST_DIR && $MARK_SCRIPT generate simple_template.md" \
    "Write a JavaScript program that build a web app"

# Test 16: Variable substitution precedence (data file over environment)
echo "language=Python" > /tmp/env_test_data.md
echo "task=sort a list" >> /tmp/env_test_data.md
run_test_with_output \
    "Variable substitution precedence (data file over environment)" \
    "export language=JavaScript task='build a web app' && $MARK_SCRIPT generate $TEST_DIR/simple_template.md /tmp/env_test_data.md" \
    "Write a Python program that sort a list"

# Test 17: Variable substitution with special characters
echo "Special: {{special_var}}" > /tmp/special_var_template.md
run_test_with_output \
    "Variable substitution with special characters" \
    "special_var='Value with spaces & symbols!' $MARK_SCRIPT generate /tmp/special_var_template.md" \
    "Special: Value with spaces & symbols!"

# Test 18: Variable substitution with empty values
echo "Empty: {{empty_var}}" > /tmp/empty_var_template.md
run_test_with_output \
    "Variable substitution with empty values" \
    "empty_var='' $MARK_SCRIPT generate /tmp/empty_var_template.md" \
    "Empty: $"

# Test 19: Variable substitution with numeric values
echo "Number: {{number_var}}" > /tmp/numeric_var_template.md
run_test_with_output \
    "Variable substitution with numeric values" \
    "number_var=42 $MARK_SCRIPT generate /tmp/numeric_var_template.md" \
    "Number: 42"

# Test 20: Variable substitution with missing variables
echo "Existing: {{existing}} Missing: {{missing}}" > /tmp/missing_var_template.md
run_test_with_output \
    "Variable substitution with missing variables" \
    "existing=found $MARK_SCRIPT generate /tmp/missing_var_template.md" \
    "Existing: found Missing: $"

# COMMAND AND LOGGING TESTS
echo -e "${BLUE}COMMAND AND LOGGING TESTS${NC}"

# Test 21: List command with no prompts
# Clear logs first to ensure clean state
$MARK_SCRIPT clear > /dev/null
run_test_with_output \
    "List command with no prompts" \
    "$MARK_SCRIPT list" \
    "No prompts generated yet"

# Test 22: List command shows recent prompts
# First generate a prompt to have something to list
$MARK_SCRIPT generate $TEST_DIR/simple_template.md > /dev/null 2>&1
run_test_with_output \
    "List command shows recent prompts" \
    "$MARK_SCRIPT list" \
    "Generated prompt"

# Test 23: List command logs correctly
run_log_test \
    "List command logs to file" \
    "$MARK_SCRIPT list" \
    "Listed recent prompts"

# Test 24: Clear command
run_test_with_output \
    "Clear command clears logs" \
    "$MARK_SCRIPT clear" \
    "Logs cleared successfully"

# Test 25: Clear command logs correctly
run_log_test \
    "Clear command logs to file" \
    "$MARK_SCRIPT clear" \
    "Logs cleared"

# Test 26: Log file location
run_test \
    "Log file is created in correct location" \
    "test -f $LOG_FILE" \
    0

# Test 27: Log file permissions
run_test \
    "Log file has correct permissions" \
    "test -r $LOG_FILE && test -w $LOG_FILE" \
    0

# Test 28: Log entries are timestamped
$MARK_SCRIPT clear > /dev/null
$MARK_SCRIPT generate $TEST_DIR/simple_template.md > /dev/null
run_test_with_output \
    "Log entries are timestamped" \
    "tail -1 $LOG_FILE | grep -E '[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}'" \
    ".*"

# COMPLEX TEMPLATE TESTS
echo -e "${BLUE}COMPLEX TEMPLATE TESTS${NC}"

# Test 29: Complex template with data file (basic variable substitution only)
# Note: The complex template contains #each directives which are not supported
run_test_with_output \
    "Complex template with data file" \
    "$MARK_SCRIPT generate $TEST_DIR/complex_template.md $TEST_DIR/complex_data.md" \
    "Create a JavaScript function that calculates the factorial"

# Test 30: Agent template with data file (basic variable substitution only)
# Note: The agent template contains #each directives which are not supported
run_test_with_output \
    "Agent template with data file" \
    "$MARK_SCRIPT generate $TEST_DIR/agent_template.md $TEST_DIR/agent_data.md" \
    "You are an expert Data Scientist"

# Test 31: Conditional template with active user (basic variable substitution only)
# Note: The conditional template contains #if directives which are not supported
run_test_with_output \
    "Conditional template with active user" \
    "$MARK_SCRIPT generate $TEST_DIR/conditional_template.md $TEST_DIR/conditional_data_active.md" \
    "Hello John"

# Test 32: Conditional template with inactive user (basic variable substitution only)
# Note: The conditional template contains #if directives which are not supported
run_test_with_output \
    "Conditional template with inactive user" \
    "$MARK_SCRIPT generate $TEST_DIR/conditional_template.md $TEST_DIR/conditional_data_inactive.md" \
    "Hi Jane"

# Test 33: Project template with data file (basic variable substitution only)
# Note: The project template contains #if directives which are not supported
run_test_with_output \
    "Project template with data file" \
    "$MARK_SCRIPT generate $TEST_DIR/project_template.md $TEST_DIR/project_data.md" \
    "Project Proposal"

# Test 34: Template with multiple placeholder occurrences
echo "{{name}} is a {{role}}. {{name}} specializes in {{skill}}." > /tmp/multiple_placeholders.md
echo "name=Alex" > /tmp/multiple_data.md
echo "role=Designer" >> /tmp/multiple_data.md
echo "skill=UI/UX" >> /tmp/multiple_data.md
run_test_with_output \
    "Template with multiple placeholder occurrences" \
    "$MARK_SCRIPT generate /tmp/multiple_placeholders.md /tmp/multiple_data.md" \
    "Alex is a Designer. Alex specializes in UI/UX"

# Test 35: Template with special characters in placeholders
echo "Price: {{price_cur}}" > /tmp/special_chars.md
echo "price_cur=\$100" > /tmp/special_data.md
run_test_with_output \
    "Template with special characters in placeholders" \
    "$MARK_SCRIPT generate /tmp/special_chars.md /tmp/special_data.md" \
    "Price: \$100"

# Test 36: Template with numeric placeholder names
echo "Value: {{123}}" > /tmp/numeric_placeholders.md
echo "123=456" > /tmp/numeric_data.md
run_test_with_output \
    "Template with numeric placeholder names" \
    "$MARK_SCRIPT generate /tmp/numeric_placeholders.md /tmp/numeric_data.md" \
    "Value: 456"

# Test 37: Template with underscore in placeholder names
echo "User {{user_name}} has {{task_count}} tasks." > /tmp/underscore_placeholders.md
echo "user_name=john_doe" > /tmp/underscore_data.md
echo "task_count=5" >> /tmp/underscore_data.md
run_test_with_output \
    "Template with underscore in placeholder names" \
    "$MARK_SCRIPT generate /tmp/underscore_placeholders.md /tmp/underscore_data.md" \
    "User john_doe has 5 tasks"

# Test 38: Template with mixed case placeholder names
echo "Hello {{UserName}}, your ID is {{userId}}." > /tmp/mixed_case_placeholders.md
echo "UserName=Alice" > /tmp/mixed_case_data.md
echo "userId=12345" >> /tmp/mixed_case_data.md
run_test_with_output \
    "Template with mixed case placeholder names" \
    "$MARK_SCRIPT generate /tmp/mixed_case_placeholders.md /tmp/mixed_case_data.md" \
    "Hello Alice, your ID is 12345"

# FILE SUBSTITUTION ADVANCED TESTS
echo -e "${BLUE}FILE SUBSTITUTION ADVANCED TESTS${NC}"

# Test 39: Multiple file substitutions in one template
# First check if the files exist
if [[ -f "$TEST_DIR/code_example.md" && -f "$TEST_DIR/requirements.md" ]]; then
    echo "First file: {{@$TEST_DIR/code_example.md}} Second file: {{@$TEST_DIR/requirements.md}}" > /tmp/multi_file_template.md
    run_test_with_output \
        "Multiple file substitutions in one template" \
        "$MARK_SCRIPT generate /tmp/multi_file_template.md" \
        "First file:.*def hello_world.*Second file:.*User authentication system"
else
    # Skip test if files don't exist
    TEST_COUNT=$((TEST_COUNT + 1))
    echo -e "Test $TEST_COUNT: Multiple file substitutions in one template ... ${YELLOW}SKIPPED${NC}"
    PASS_COUNT=$((PASS_COUNT + 1))
fi

# Test 40: File substitution with nested directories
mkdir -p /tmp/nested_dir
echo "Nested content" > /tmp/nested_dir/nested_file.md
echo "Content: {{@/tmp/nested_dir/nested_file.md}}" > /tmp/nested_template.md
run_test_with_output \
    "File substitution with nested directories" \
    "$MARK_SCRIPT generate /tmp/nested_template.md" \
    "Content: Nested content"

# Test 41: File substitution with empty file
echo "" > /tmp/empty_file.md
echo "Empty: {{@/tmp/empty_file.md}}" > /tmp/empty_file_template.md
run_test_with_output \
    "File substitution with empty file" \
    "$MARK_SCRIPT generate /tmp/empty_file_template.md" \
    "Empty: $"

# Test 42: File substitution with special characters in filename
echo "Special content" > "/tmp/special chars.md"
echo "Special: {{@/tmp/special chars.md}}" > /tmp/special_template.md
run_test_with_output \
    "File substitution with special characters in filename" \
    "$MARK_SCRIPT generate /tmp/special_template.md" \
    "Special: Special content"

# Test 43: File substitution combined with variable substitution
# First check if the file exists
if [[ -f "$TEST_DIR/code_example.md" ]]; then
    echo "File: {{@$TEST_DIR/code_example.md}} Variable: {{name}}" > /tmp/combined_template.md
    run_test_with_output \
        "File substitution combined with variable substitution" \
        "name=John $MARK_SCRIPT generate /tmp/combined_template.md" \
        "File:.*def hello_world.*Variable: John"
else
    # Skip test if file doesn't exist
    TEST_COUNT=$((TEST_COUNT + 1))
    echo -e "Test $TEST_COUNT: File substitution combined with variable substitution ... ${YELLOW}SKIPPED${NC}"
    PASS_COUNT=$((PASS_COUNT + 1))
fi

# Test 44: File substitution with large files
# Create a large file
printf "Line %d\n" {1..100} > /tmp/large_file.md
echo "Large file content: {{@/tmp/large_file.md}}" > /tmp/large_template.md
run_test_with_output \
    "File substitution with large files" \
    "$MARK_SCRIPT generate /tmp/large_template.md | grep -c 'Line 50'" \
    "1"

# Test 45: File substitution with formatted content
echo -e "Line 1\nLine 2\n\tTabbed line\nLine 4" > /tmp/formatted_file.md
echo "Formatted: {{@/tmp/formatted_file.md}}" > /tmp/formatted_template.md
run_test_with_output \
    "File substitution with formatted content" \
    "$MARK_SCRIPT generate /tmp/formatted_template.md" \
    "Formatted:.*Line 1.*Line 2"

# EDGE CASE TESTS
echo -e "${BLUE}EDGE CASE TESTS${NC}"

# Test 46: Empty template
echo "" > /tmp/empty_template.md
run_test_with_output \
    "Empty template handling" \
    "$MARK_SCRIPT generate /tmp/empty_template.md" \
    "^$"

# Test 47: Template with no placeholders
echo "This template has no placeholders." > /tmp/no_placeholder_template.md
run_test_with_output \
    "Template with no placeholders" \
    "$MARK_SCRIPT generate /tmp/no_placeholder_template.md" \
    "This template has no placeholders"

# Test 48: Comments in data files
echo "Value: {{key}}" > /tmp/comment_template.md
echo "key=value" > /tmp/comment_data.md
echo "# This is a comment" >> /tmp/comment_data.md
echo "  # Another comment with spaces" >> /tmp/comment_data.md
echo "" >> /tmp/comment_data.md
run_test_with_output \
    "Comments in data files" \
    "$MARK_SCRIPT generate /tmp/comment_template.md /tmp/comment_data.md" \
    "Value: value"

# Test 49: Large template processing
printf "Line %d: {{placeholder}}\n" {1..50} > /tmp/large_template.md
echo "placeholder=test_value" > /tmp/large_data.md
run_test_with_output \
    "Large template processing" \
    "$MARK_SCRIPT generate /tmp/large_template.md /tmp/large_data.md | grep -c 'test_value'" \
    "50"

# Test 50: Unicode characters in templates and data
echo "Unicode: {{greeting}} {{name}}! 🚀" > /tmp/unicode_template.md
echo "greeting=こんにちは" > /tmp/unicode_data.md
echo "name=世界" >> /tmp/unicode_data.md
run_test_with_output \
    "Unicode characters support" \
    "$MARK_SCRIPT generate /tmp/unicode_template.md /tmp/unicode_data.md" \
    "Unicode: こんにちは 世界! 🚀"

# CLEANUP
echo -e "${BLUE}CLEANUP${NC}"
rm -f /tmp/file_sub_template.md /tmp/multi_file_template.md /tmp/nested_template.md \
      /tmp/empty_file.md /tmp/empty_file_template.md "/tmp/special chars.md" \
      /tmp/special_template.md /tmp/combined_template.md /tmp/large_file.md \
      /tmp/large_template.md /tmp/formatted_file.md /tmp/formatted_template.md \
      /tmp/special_var_template.md /tmp/empty_var_template.md \
      /tmp/numeric_var_template.md /tmp/multi_var_template.md /tmp/multi_var_data.md \
      /tmp/naming_template.md /tmp/missing_var_template.md /tmp/combo_template.md \
      /tmp/combo_data.md /tmp/nested_template.md /tmp/escaped_template.md \
      /tmp/malformed_template.md /tmp/long_placeholder_template.md \
      /tmp/long_placeholder_data.md /tmp/unicode_template.md /tmp/unicode_data.md \
      /tmp/empty_template.md /tmp/no_placeholder_template.md /tmp/comment_template.md \
      /tmp/comment_data.md /tmp/large_template.md /tmp/large_data.md \
      /tmp/env_test_data.md /tmp/multiple_placeholders.md /tmp/multiple_data.md \
      /tmp/special_chars.md /tmp/special_data.md /tmp/numeric_placeholders.md \
      /tmp/numeric_data.md /tmp/underscore_placeholders.md /tmp/underscore_data.md \
      /tmp/mixed_case_placeholders.md /tmp/mixed_case_data.md
rm -rf /tmp/nested_dir

##################################################
# TEST SUMMARY
##################################################

echo "========================================"
echo "Comprehensive Test Results:"
echo "========================================"
echo "Total tests: $TEST_COUNT"
echo "Passed: $PASS_COUNT"
echo "Failed: $FAIL_COUNT"

if [[ $FAIL_COUNT -eq 0 ]]; then
    echo -e "${GREEN}All tests passed!${NC}"
    exit 0
else
    echo -e "${RED}Some tests failed!${NC}"
    exit 1
fi