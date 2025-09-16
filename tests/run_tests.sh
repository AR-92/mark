#!/bin/bash

# mark - Main Test Runner
# Runs the simple test suite

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Get the project root directory (parent of tests directory)
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Run the simple test suite
echo "========================================"
echo "Running mark Simple Test Suite"
echo "========================================"

bash "$SCRIPT_DIR/simple_test_suite.sh"

# Capture the exit code
EXIT_CODE=$?

# Provide appropriate feedback
if [[ $EXIT_CODE -eq 0 ]]; then
    echo ""
    echo "========================================"
    echo "All tests passed! mark is working correctly."
    echo "========================================"
    echo ""
    echo "You can now use mark with confidence:"
    echo "  ./bin/mark generate template.md data.md"
    echo "  ./bin/mark list"
    echo "  ./bin/mark clear"
    echo "  ./bin/mark help"
else
    echo ""
    echo "========================================"
    echo "Some tests failed. Please check the output above."
    echo "========================================"
fi

exit $EXIT_CODE