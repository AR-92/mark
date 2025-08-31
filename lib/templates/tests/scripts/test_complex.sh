#!/bin/bash

# mark - Complex Template Tests
# Tests complex templates with advanced features

# Source test utilities
source "$(dirname "$0")/test_utils.sh"

# Setup - Clear logs before starting tests
echo "Setting up test environment..."
> "$LOG_FILE"

echo "========================================"
echo "Running Complex Template Tests"
echo "========================================"

# COMPLEX TEMPLATE TESTS (with #each and #if directives)
echo -e "${BLUE}COMPLEX TEMPLATE TESTS${NC}"

# Test 1: Complex template with data file (basic variable substitution only)
# Note: The complex template contains #each directives which are not supported
run_test_with_output \
    "Complex template with data file" \
    "$MARK_SCRIPT generate $TEMPLATE_DIR/complex_template.md $DATA_DIR/complex_data.md" \
    "Create a JavaScript function that calculates the factorial"

# Test 2: Agent template with data file (basic variable substitution only)
# Note: The agent template contains #each directives which are not supported
run_test_with_output \
    "Agent template with data file" \
    "$MARK_SCRIPT generate $TEMPLATE_DIR/agent_template.md $DATA_DIR/agent_data.md" \
    "You are an expert Data Scientist"

# Test 3: Conditional template with active user (basic variable substitution only)
# Note: The conditional template contains #if directives which are not supported
run_test_with_output \
    "Conditional template with active user" \
    "$MARK_SCRIPT generate $TEMPLATE_DIR/conditional_template.md $DATA_DIR/conditional_data_active.md" \
    "Hello John"

# Test 4: Conditional template with inactive user (basic variable substitution only)
# Note: The conditional template contains #if directives which are not supported
run_test_with_output \
    "Conditional template with inactive user" \
    "$MARK_SCRIPT generate $TEMPLATE_DIR/conditional_template.md $DATA_DIR/conditional_data_inactive.md" \
    "Hi Jane"

# Test 5: Project template with data file (basic variable substitution only)
# Note: The project template contains #if directives which are not supported
run_test_with_output \
    "Project template with data file" \
    "$MARK_SCRIPT generate $TEMPLATE_DIR/project_template.md $DATA_DIR/project_data.md" \
    "Project Proposal"

# Print summary
print_summary "Complex Templates"
exit $((FAIL_COUNT > 0 ? 1 : 0))