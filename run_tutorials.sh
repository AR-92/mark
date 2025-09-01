#!/bin/bash

# Run all mark tutorials

echo "Running mark tutorials..."

# Run beginner tutorial example
echo "=== Beginner Tutorial ==="
cd /home/rana/Documents/Projects/mark
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