#!/bin/bash

# mark - Main Test Suite Runner
# This is the main test runner referenced in documentation and installation script

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Get the project root directory (parent of tests directory)
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Run the complete test suite
echo "========================================"
echo "Running Complete Test Suite for mark"
echo "========================================"

# Run the modular test suite
"$PROJECT_ROOT/lib/templates/tests/scripts/run_all_tests.sh"

# Capture the exit code
EXIT_CODE=$?

# Run tutorial tests if main tests passed
if [[ $EXIT_CODE -eq 0 ]]; then
    echo ""
    echo "========================================"
    echo "Running Tutorial Tests"
    echo "========================================"
    
    # Run tutorial tests
    "$SCRIPT_DIR/test_tutorials.sh"
    
    # Capture tutorial test exit code
    TUTORIAL_EXIT_CODE=$?
    
    if [[ $TUTORIAL_EXIT_CODE -ne 0 ]]; then
        EXIT_CODE=$TUTORIAL_EXIT_CODE
    fi
fi

# Run project plan example test if previous tests passed
if [[ $EXIT_CODE -eq 0 ]]; then
    echo ""
    echo "========================================"
    echo "Running Project Plan Example Test"
    echo "========================================"
    
    # Run project plan example test
    "$SCRIPT_DIR/test_project_plan.sh"
    
    # Capture project plan test exit code
    PROJECT_PLAN_EXIT_CODE=$?
    
    if [[ $PROJECT_PLAN_EXIT_CODE -ne 0 ]]; then
        EXIT_CODE=$PROJECT_PLAN_EXIT_CODE
    fi
fi

# Provide appropriate feedback
if [[ $EXIT_CODE -eq 0 ]]; then
    echo ""
    echo "========================================"
    echo "All tests passed! mark is working correctly."
    echo "========================================"
    echo ""
    echo "You can now use mark with confidence:"
    echo "  ./mark generate template.md data.md"
    echo "  ./mark list"
    echo "  ./mark clear"
    echo "  ./mark help"
else
    echo ""
    echo "========================================"
    echo "Some tests failed. Please check the output above."
    echo "========================================"
fi

exit $EXIT_CODE