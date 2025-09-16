#!/bin/bash

# mark - Simple Test Suite
# Basic tests to verify core functionality

run_tests() {
    local passed=0
    local failed=0
    local total_tests=10
    
    echo "Running mark simple test suite..."
    echo "=============================="
    
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
    
    # Test 3: Config set command
    echo -n "Test 3: Config set command... "
    if ./bin/mark config set test_key test_value >/dev/null 2>&1; then
        echo "PASSED"
        ((passed++))
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Test 4: Config get command
    echo -n "Test 4: Config get command... "
    if ./bin/mark config get test_key >/dev/null 2>&1; then
        echo "PASSED"
        ((passed++))
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Test 5: Basic placeholder replacement
    echo -n "Test 5: Basic placeholder replacement... "
    echo "Hello {{name}}!" > /tmp/test_template.md
    echo 'name="World"' > /tmp/test_data.md
    if ./bin/mark generate /tmp/test_template.md /tmp/test_data.md | grep -q "Hello World!"; then
        echo "PASSED"
        ((passed++))
    else
        echo "FAILED"
        ((failed++))
    fi
    rm -f /tmp/test_template.md /tmp/test_data.md
    
    # Test 6: Multiple placeholders
    echo -n "Test 6: Multiple placeholders... "
    echo "Hello {{name}} from {{city}}!" > /tmp/test_template.md
    echo 'name="John"' > /tmp/test_data.md
    echo 'city="Paris"' >> /tmp/test_data.md
    if ./bin/mark generate /tmp/test_template.md /tmp/test_data.md | grep -q "Hello John from Paris!"; then
        echo "PASSED"
        ((passed++))
    else
        echo "FAILED"
        ((failed++))
    fi
    rm -f /tmp/test_template.md /tmp/test_data.md
    
    # Test 7: Template commands
    echo -n "Test 7: Template commands... "
    if ./bin/mark template new test.md >/dev/null 2>&1 && \
       ./bin/mark template list >/dev/null 2>&1 && \
       ./bin/mark template delete test.md >/dev/null 2>&1; then
        echo "PASSED"
        ((passed++))
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Test 8: List and clear commands
    echo -n "Test 8: List and clear commands... "
    if ./bin/mark list >/dev/null 2>&1 && ./bin/mark clear >/dev/null 2>&1; then
        echo "PASSED"
        ((passed++))
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Test 9: Invalid command handling
    echo -n "Test 9: Invalid command handling... "
    if ! ./bin/mark nonexistent 2>/dev/null; then
        echo "PASSED"
        ((passed++))
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Test 10: Missing template argument
    echo -n "Test 10: Missing template argument... "
    if ! ./bin/mark generate 2>/dev/null; then
        echo "PASSED"
        ((passed++))
    else
        echo "FAILED"
        ((failed++))
    fi
    
    # Summary
    echo ""
    echo "Test Results:"
    echo "============="
    echo "Passed: $passed"
    echo "Failed: $failed"
    echo "Total:  $total_tests"
    
    if [[ $failed -eq 0 ]]; then
        echo ""
        echo "🎉 All tests passed!"
        return 0
    else
        echo ""
        echo "❌ Some tests failed!"
        return 1
    fi
}

# Run the tests
run_tests