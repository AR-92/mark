# mark Test Suite

This directory contains the comprehensive test suite for the mark AI prompt templating tool.

## Directory Structure

```
tests/
├── data/          # Test data files (.md files with key=value pairs)
├── scripts/       # Test scripts and runner
└── templates/     # Test template files
```

## Test Organization

### data/
Contains data files used in testing:
- `*.md` files with key=value pairs for variable substitution
- JSON data files for testing different formats

### scripts/
Contains the modular test suite:
- `test_utils.sh` - Common functions and configuration
- `test_basic.sh` - Basic functionality tests
- `test_file_substitution.sh` - File inclusion tests
- `test_variable_substitution.sh` - Variable replacement tests
- `test_commands.sh` - Command execution and logging tests
- `test_complex.sh` - Complex template tests
- `test_edge_cases.sh` - Edge cases and special scenarios
- `run_all_tests.sh` - Main test runner

### templates/
Contains template files used in testing:
- `*.md` files with various template structures
- Simple templates for basic testing
- Complex templates with advanced features

## Running Tests

```bash
# Run all tests
./scripts/run_all_tests.sh

# Run specific test module
./scripts/test_basic.sh
./scripts/test_file_substitution.sh
```

## Test Status

- Total Tests: 50
- Passing: 40
- Failing: 10
- Success Rate: 80%

## Goals

1. Fix failing tests to achieve 100% pass rate
2. Add tests for #if and #each directives when implemented
3. Expand edge case coverage
4. Add performance tests