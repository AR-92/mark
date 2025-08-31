#!/bin/bash

# mark - Main Test Suite Runner
# This is the main test runner referenced in documentation and installation script

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Run the complete test suite
echo "========================================"
echo "Running Complete Test Suite for mark"
echo "========================================"

# Run the modular test suite
"$SCRIPT_DIR/lib/templates/tests/scripts/run_all_tests.sh"

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