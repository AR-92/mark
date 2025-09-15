#!/bin/bash

# Integration test demonstrating all new features

echo "=== Integration Test: All New Features ==="

# 1. Show version
echo "1. Version command:"
./bin/mark version

echo ""

# 2. Configuration management
echo "2. Configuration management:"
./bin/mark config set editor code
./bin/mark config set template_dirs "~/.mark/templates"
./bin/mark config get editor
./bin/mark config list | head -5

echo ""

# 3. Template management
echo "3. Template management:"
echo "Creating test template..."
mkdir -p $HOME/.mark/templates
echo "# Integration Test Template

This is a test template for integration testing.

Variable: {{test_variable}}

Conditional:
{{#if show_extra}}
This is extra content that is conditionally shown.
{{/if}}

Loop:
{{#each items}}
- {{this}}
{{/each}}
" > $HOME/.mark/templates/integration_test.md

echo "Listing templates:"
./bin/mark template list

echo ""
echo "Showing template:"
./bin/mark template show integration_test

echo ""
echo "Renaming template:"
./bin/mark template rename integration_test integration_renamed

echo ""
echo "Listing templates after rename:"
./bin/mark template list

echo ""
echo "Renaming template back:"
./bin/mark template rename integration_renamed integration_test

echo ""

# 4. Template generation with new features
echo "4. Template generation:"
echo "Creating test data..."
echo "test_variable=Hello World
show_extra=true
items_0=First item
items_1=Second item
items_2=Third item" > /tmp/integration_test_data.md

echo "Generating output:"
./bin/mark generate integration_test.md /tmp/integration_test_data.md

echo ""
echo "Cleaning up..."
rm -f /tmp/integration_test_data.md
rm -f $HOME/.mark/templates/integration_test.md

echo ""
echo "=== Integration Test Complete ==="