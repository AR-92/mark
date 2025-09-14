#!/bin/bash

# mark - Project Plan Template Test
# Test the project plan template with sample data

# Get the absolute path of this script's directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Navigate up to the project root
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_ROOT"

# Test project plan example
echo "Testing project plan example..."
EXPECTED_OUTPUT="Customer Portal Redesign"
OUTPUT=$(./bin/mark generate examples/templates/project_plan_template.md examples/data/project_plan_data.md | grep "Customer Portal Redesign")

if [[ "$OUTPUT" == *"$EXPECTED_OUTPUT"* ]]; then
    echo "✓ Project plan example test passed"
else
    echo "✗ Project plan example test failed"
    echo "Expected: $EXPECTED_OUTPUT"
    echo "Got: $OUTPUT"
fi

echo "Project plan example test completed!"