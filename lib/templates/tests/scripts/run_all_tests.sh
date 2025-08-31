#!/bin/bash

# mark - Modular Test Suite Runner
# Runs all modular test suites and aggregates results

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Test counters
TOTAL_TESTS=0
TOTAL_PASSED=0
TOTAL_FAILED=0
MODULES_RUN=0
MODULES_PASSED=0

echo "========================================"
echo "Running Complete Modular Test Suite for mark"
echo "========================================"

# Function to run a test module
run_module() {
    local module_name="$1"
    local module_script="$2"
    
    MODULES_RUN=$((MODULES_RUN + 1))
    echo -e "\n${BLUE}Running $module_name...${NC}"
    
    # Run the module and capture exit code
    "$module_script"
    local exit_code=$?
    
    # Parse the results from the module
    if [[ -f "/tmp/mark_module_results" ]]; then
        source /tmp/mark_module_results
        rm -f /tmp/mark_module_results
    fi
    
    # Update total counters
    TOTAL_TESTS=$((TOTAL_TESTS + TEST_COUNT))
    TOTAL_PASSED=$((TOTAL_PASSED + PASS_COUNT))
    TOTAL_FAILED=$((TOTAL_FAILED + FAIL_COUNT))
    
    if [[ $exit_code -eq 0 ]]; then
        MODULES_PASSED=$((MODULES_PASSED + 1))
        echo -e "${GREEN}$module_name: PASSED${NC}"
    else
        echo -e "${RED}$module_name: FAILED${NC}"
    fi
}

# Function to run all modules
run_all_modules() {
    # Run each test module
    run_module "Basic Functionality Tests" "$(dirname "$0")/test_basic.sh"
    run_module "File Substitution Tests" "$(dirname "$0")/test_file_substitution.sh"
    run_module "Variable Substitution Tests" "$(dirname "$0")/test_variable_substitution.sh"
    run_module "Command and Logging Tests" "$(dirname "$0")/test_commands.sh"
    run_module "Complex Template Tests" "$(dirname "$0")/test_complex.sh"
    run_module "Edge Case Tests" "$(dirname "$0")/test_edge_cases.sh"
    
    # Print final summary
    echo -e "\n========================================"
    echo "Final Test Results:"
    echo "========================================"
    echo "Modules run: $MODULES_RUN"
    echo "Modules passed: $MODULES_PASSED"
    echo "Modules failed: $((MODULES_RUN - MODULES_PASSED))"
    echo "Total tests: $TOTAL_TESTS"
    echo "Total passed: $TOTAL_PASSED"
    echo "Total failed: $TOTAL_FAILED"
    
    if [[ $TOTAL_FAILED -eq 0 && $((MODULES_RUN - MODULES_PASSED)) -eq 0 ]]; then
        echo -e "${GREEN}All tests passed!${NC}"
        exit 0
    else
        echo -e "${RED}Some tests failed!${NC}"
        exit 1
    fi
}

# Run all modules
run_all_modules