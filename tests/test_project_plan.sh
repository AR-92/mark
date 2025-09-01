#!/bin/bash

# Test script for project plan example

echo "Testing project plan example..."

cd /home/rana/Documents/Projects/mark

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