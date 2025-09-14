#!/bin/bash

# mark - Test Utilities
# Common functions and configuration for all test modules

# Get the absolute path of this script's directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Navigate up to the project root (4 levels up from scripts/test_utils.sh)
PROJECT_ROOT="$(dirname "$(dirname "$(dirname "$(dirname "$SCRIPT_DIR")")")")"

# Test configuration using relative paths
MARK_SCRIPT="$PROJECT_ROOT/bin/mark"
TEST_DIR="$PROJECT_ROOT/lib/templates/tests"
TEMPLATE_DIR="$TEST_DIR/templates"
DATA_DIR="$TEST_DIR/data"
LOG_FILE="${HOME}/.mark.log"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Test counter (global variables)
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

# Function to reset test counters
reset_counters() {
    TEST_COUNT=0
    PASS_COUNT=0
    FAIL_COUNT=0
}

# Function to print test summary
print_summary() {
    local module_name="$1"
    echo "========================================"
    echo "Test Results for $module_name:"
    echo "========================================"
    echo "Total tests: $TEST_COUNT"
    echo "Passed: $PASS_COUNT"
    echo "Failed: $FAIL_COUNT"
    
    # Export results for the main runner
    cat > /tmp/mark_module_results <<EOF
TEST_COUNT=$TEST_COUNT
PASS_COUNT=$PASS_COUNT
FAIL_COUNT=$FAIL_COUNT
EOF
    
    if [[ $FAIL_COUNT -eq 0 ]]; then
        echo -e "${GREEN}All tests passed!${NC}"
        return 0
    else
        echo -e "${RED}Some tests failed!${NC}"
        return 1
    fi
}