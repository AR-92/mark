#!/bin/bash

# Test script for mark tutorials

echo "Testing mark tutorials..."

cd /home/rana/Documents/Projects/mark

# Test beginner tutorial
echo "Testing beginner tutorial..."
EXPECTED_OUTPUT="You are an expert Software Engineer tasked with implementing a function that reverses a string without using built-in methods."
OUTPUT=$(./bin/mark generate examples/tutorials/templates/beginner/example_template.md examples/tutorials/data/beginner/example_data.md | grep "expert Software Engineer")

if [[ "$OUTPUT" == *"$EXPECTED_OUTPUT"* ]]; then
    echo "✓ Beginner tutorial test passed"
else
    echo "✗ Beginner tutorial test failed"
    echo "Expected: $EXPECTED_OUTPUT"
    echo "Got: $OUTPUT"
fi

# Test intermediate conditional tutorial
echo "Testing intermediate conditional tutorial..."
EXPECTED_OUTPUT="You are an expert Python Developer with advanced knowledge."
OUTPUT=$(./bin/mark generate examples/tutorials/templates/intermediate/conditional_template.md examples/tutorials/data/intermediate/conditional_data.md | grep "expert Python Developer")

if [[ "$OUTPUT" == *"$EXPECTED_OUTPUT"* ]]; then
    echo "✓ Intermediate conditional tutorial test passed"
else
    echo "✗ Intermediate conditional tutorial test failed"
    echo "Expected: $EXPECTED_OUTPUT"
    echo "Got: $OUTPUT"
fi

# Test intermediate loop tutorial
echo "Testing intermediate loop tutorial..."
EXPECTED_OUTPUT="Role: Backend Developer"
OUTPUT=$(./bin/mark generate examples/tutorials/templates/intermediate/loop_template.md examples/tutorials/data/intermediate/loop_data.md | grep "Role: Backend Developer")

if [[ "$OUTPUT" == *"$EXPECTED_OUTPUT"* ]]; then
    echo "✓ Intermediate loop tutorial test passed"
else
    echo "✗ Intermediate loop tutorial test failed"
    echo "Expected: $EXPECTED_OUTPUT"
    echo "Got: $OUTPUT"
fi

echo "Tutorial tests completed!"