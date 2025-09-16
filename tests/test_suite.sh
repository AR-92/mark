#!/bin/bash

# mark - Test Suite
# Consolidated test functionality

run_tests() {
    local passed=0
    local failed=0
    
    echo "Running mark test suite..."
    echo "========================="
    
    # Test 1: Help command
    echo -n "Test 1: Help command... "
    if ./bin/mark help >/dev/null 2>&1; then
        echo "PASSED"
        ((passed++))
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Test 2: Version command
    echo -n "Test 2: Version command... "
    if ./bin/mark version >/dev/null 2>&1; then
        echo "PASSED"
        ((passed++))
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Test 3: Config commands
    echo -n "Test 3: Config commands... "
    if ./bin/mark config set test_key test_value >/dev/null 2>&1 && \
       ./bin/mark config get test_key >/dev/null 2>&1 && \
       ./bin/mark config list >/dev/null 2>&1; then
        echo "PASSED"
        ((passed++))
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Test 4: Template commands
    echo -n "Test 4: Template commands... "
    if ./bin/mark template new test_template.md >/dev/null 2>&1 && \
       ./bin/mark template list >/dev/null 2>&1 && \
       ./bin/mark template show test_template.md >/dev/null 2>&1 && \
       ./bin/mark template delete test_template.md >/dev/null 2>&1; then
        echo "PASSED"
        ((passed++))
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Test 5: Generate command with simple template
    echo -n "Test 5: Generate command... "
    # Create test files
    cat > /tmp/test_template.md <<EOF
Hello, {{name}}!
EOF
    
    cat > /tmp/test_data.md <<EOF
name=World
EOF
    
    # Run generate command
    if ./bin/mark generate /tmp/test_template.md /tmp/test_data.md >/dev/null 2>&1; then
        echo "PASSED"
        ((passed++))
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Clean up test files
    rm -f /tmp/test_template.md /tmp/test_data.md
    
    # Summary
    echo ""
    echo "Test Results:"
    echo "============="
    echo "Passed: $passed"
    echo "Failed: $failed"
    echo "Total:  $((passed + failed))"
    
    if [[ $failed -eq 0 ]]; then
        echo ""
        echo "All tests passed!"
        return 0
    else
        echo ""
        echo "Some tests failed!"
        return 1
    fi
}

# Run the tests
run_tests