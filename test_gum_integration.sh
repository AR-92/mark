#!/bin/bash

# Test script for Gum integration with mark

echo "Testing Gum integration with mark"
echo "================================="

# Check if Gum is installed
if ! command -v gum &> /dev/null; then
    echo "Gum is not installed. Please install Gum to use interactive features."
    echo "Run: ./setup_gum.sh"
    exit 1
fi

echo "✓ Gum is installed"

# Check if mark is available
if [[ ! -f "./bin/mark" ]]; then
    echo "Error: mark executable not found"
    exit 1
fi

echo "✓ mark executable found"

# Test help commands
echo ""
echo "Testing help commands..."
./bin/mark help > /dev/null && echo "✓ Main help works"
./bin/mark help template > /dev/null && echo "✓ Template help works"
./bin/mark help generate > /dev/null && echo "✓ Generate help works"

# Test interactive command recognition
echo ""
echo "Testing interactive command recognition..."
if ./bin/mark template 2>&1 | grep -q "interactive"; then
    echo "✓ Template interactive command recognized"
else
    echo "✗ Template interactive command not recognized"
fi

if ./bin/mark generate 2>&1 | grep -q "interactive"; then
    echo "✓ Generate interactive command recognized"
else
    echo "✗ Generate interactive command not recognized"
fi

echo ""
echo "All tests completed!"
echo ""
echo "To try the interactive features, run:"
echo "  ./bin/mark template interactive"
echo "  ./bin/mark generate interactive"