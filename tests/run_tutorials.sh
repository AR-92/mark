#!/bin/bash

# mark - Run all tutorials
# Execute tutorials in order from beginner to ninja

# Get the absolute path of this script's directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Navigate up to the project root
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_ROOT"
./bin/mark generate examples/tutorials/templates/beginner/example_template.md examples/tutorials/data/beginner/example_data.md
echo ""

# Run intermediate tutorial examples
echo "=== Intermediate Tutorial ==="
echo "--- Conditional Example ---"
./bin/mark generate examples/tutorials/templates/intermediate/conditional_template.md examples/tutorials/data/intermediate/conditional_data.md
echo ""
echo "--- Loop Example ---"
./bin/mark generate examples/tutorials/templates/intermediate/loop_template.md examples/tutorials/data/intermediate/loop_data.md
echo ""

echo "Tutorials completed!"