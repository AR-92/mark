# mark - AI Prompt Templating Tool

`mark` is a powerful Bash-based tool for generating AI/MCP-ready prompts from templates with support for placeholders, file substitution, conditional blocks, and loops.

## Features

- **Placeholders**: `{{variable_name}}` for simple variable substitution
- **File Substitution**: `{{@file_path}}` to include content from other files
- **Conditional Blocks**: `{{#if condition}}...{{/if}}` for conditional content
- **Loop Blocks**: `{{#each array}}...{{/each}}` for iterating over lists
- **Data Files**: Simple key=value format for variable definitions
- **Environment Variables**: Automatic integration with system environment
- **Comprehensive Logging**: Full audit trail of all operations
- **CLI Interface**: Intuitive commands (`generate`, `list`, `clear`, `help`)

## Installation

### Quick Install
```bash
# Clone the repository
git clone <repository-url>
cd mark

# Make the script executable
chmod +x mark

# Run the installation script
./install.sh
```

### Manual Installation
```bash
# Clone the repository
git clone <repository-url>
cd mark

# Make the script executable
chmod +x mark

# Optionally, copy to a directory in your PATH
sudo cp mark /usr/local/bin/
```

## Usage

```bash
# Generate a prompt from a template
./mark generate template.md

# Generate a prompt with data file
./mark generate template.md data.md

# List recently generated prompts
./mark list

# Clear logs
./mark clear

# Show help
./mark help
```

## Template Syntax

### Basic Placeholders
```
Write a {{language}} program that {{task}}.
```

### File Inclusion
```
{{@requirements.md}}
```

### Conditional Blocks
```
{{#if active}}
Welcome back to {{platform}}!
{{/if}}
```

### Loop Blocks
```
{{#each requirements}}
- {{this}}
{{/each}}
```

## Example

### Template (example_template.md)
```markdown
# {{task_type}} Implementation Guide

You are {{#if expert}}an expert {{/if}}{{role}} tasked with {{task}}.

## Requirements
{{#each requirements}}
- {{this}}
{{/each}}

## Constraints
{{#each constraints}}
- {{this}}
{{/each}}

{{#if example_needed}}
## Example
```{{language}}
{{example_code}}
```
{{/if}}

Please provide a complete, well-documented implementation that follows best practices.
```

### Data File (example_data.md)
```markdown
expert=true
role=Software Engineer
task=implementing a function that reverses a string without using built-in methods
language=Python
requirements_0=Handle edge cases (empty strings, single characters)
requirements_1=Optimize for time complexity
requirements_2=Include comprehensive error handling
constraints_0=Do not use built-in reverse functions
constraints_1=Maintain O(n) time complexity
example_needed=true
example_code=def reverse_string(s): return s[::-1]  # Simple slice reversal
```

### Generated Output
```bash
./mark generate example_template.md example_data.md
```

## Commands

### Generate
Generate a prompt from a template file:
```bash
./mark generate my_template.md
./mark generate my_template.md my_data.md
```

### List
Show recently generated prompts:
```bash
./mark list
```

### Clear
Clear all logs:
```bash
./mark clear
```

### Help
Show help information:
```bash
./mark help
```

## Advanced Features

### Indexed Arrays for Loops
For `{{#each array}}` blocks, define indexed items:
```
requirements_0=First requirement
requirements_1=Second requirement
requirements_2=Third requirement
```

### Conditional Logic
Use `{{#if variable}}` blocks with truthy evaluations:
- Non-empty strings are truthy
- "false" string is falsy
- Undefined variables are falsy

### File Substitution Paths
Reference files with relative or absolute paths:
```
{{@./path/to/file.md}}
{{@/absolute/path/to/file.md}}
```

## Testing

The tool includes a comprehensive test suite with 50+ tests:
```bash
./final_tests.sh
```

Current test status: 44/50 tests passing

## Project Structure

```
mark/
├── mark                 # Main executable script
├── README.md            # Project documentation
├── LICENSE              # MIT License
├── CHANGELOG.md         # Version history
├── PROJECT_SUMMARY.md   # Detailed project overview
├── install.sh           # Installation script
├── final_tests.sh       # Comprehensive test suite
├── example_template.md  # Sample template
├── example_data.md      # Sample data file
├── simple_template.md   # Simple template for testing
├── simple_data.md       # Simple data file for testing
├── directive_test_template.md  # Template for testing directives
├── directive_test_data.md      # Data for testing directives
├── tests/               # Directory with test templates and data
└── .gitignore           # Git ignore file
```

## Contributing

Contributions are welcome! Please submit pull requests for bug fixes, enhancements, or new features.

## License

This project is licensed under the MIT License - see the LICENSE file for details.