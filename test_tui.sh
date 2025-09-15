#!/bin/bash

# Test script for mark TUI

echo "Testing mark TUI"
echo "================"

# Check if Gum is installed
if ! command -v gum &> /dev/null; then
    echo "⚠️  Gum is not installed. Please install Gum to use the TUI."
    echo "   Run: ./setup_gum.sh"
    exit 1
fi

echo "✅ Gum is installed"

# Check if mark-tui exists and is executable
if [[ ! -f "./bin/mark-tui" ]] || [[ ! -x "./bin/mark-tui" ]]; then
    echo "❌ mark-tui not found or not executable"
    exit 1
fi

echo "✅ mark-tui found and executable"

# Check if main mark script exists
if [[ ! -f "./bin/mark" ]]; then
    echo "❌ mark script not found"
    exit 1
fi

echo "✅ mark script found"

# Test help command includes TUI
if ./bin/mark help | grep -q "tui"; then
    echo "✅ TUI command documented in help"
else
    echo "❌ TUI command not found in help"
fi

# Test detailed help for TUI
if ./bin/mark help tui > /dev/null 2>&1; then
    echo "✅ Detailed help for TUI available"
else
    echo "❌ Detailed help for TUI not available"
fi

echo ""
echo "All tests completed!"
echo ""
echo "To launch the TUI, run:"
echo "  ./bin/mark tui"
echo "or"
echo "  ./bin/mark-tui"