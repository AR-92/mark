# mark - AI Prompt Templating Tool

`mark` is a powerful Bash-based tool for generating AI/MCP-ready prompts from templates with support for placeholders, file substitution, conditional blocks, and loops.

## Features

- **Placeholders**: `{{variable_name}}` for simple variable substitution
- **File Substitution**: `{{@file_path}}` to include content from other files
- **Conditional Blocks**: `{{#if condition}}...{{/if}}` for conditional content
- **Loop Blocks**: `{{#each array}}...{{/each}}` for iterating over lists
- **Data Files**: Simple key=value format for variable definitions
- **Environment Variables**: Automatic integration with system environment
- **Template Management**: List, show, create, edit, delete, and rename templates
- **Configuration Management**: Set, get, and list configuration options
- **CLI Interface**: Commands (`generate`, `list`, `clear`, `config`, `template`, `version`, `help`)

## Installation

### Quick Install
```bash
# Clone the repository
git clone https://github.com/AR-92/mark.git
cd mark

# Make the script executable
chmod +x bin/mark

# Run the installation script
./bin/install.sh
```

### Manual Installation
```bash
# Clone the repository
git clone https://github.com/AR-92/mark.git
cd mark

# Make the script executable
chmod +x bin/mark

# Optionally, copy to a directory in your PATH
sudo cp bin/mark /usr/local/bin/
```

## Usage

```bash
# Generate a prompt from a template
./bin/mark generate template.md

# Generate a prompt with data file
./bin/mark generate template.md data.md

# List recently generated prompts
./bin/mark list

# Clear logs
./bin/mark clear

# Manage configuration
./bin/mark config set editor nvim
./bin/mark config get editor
./bin/mark config list

# Manage templates
./bin/mark template list
./bin/mark template show my_template.md
./bin/mark template new my_new_template
./bin/mark template edit my_template.md
./bin/mark template delete my_template.md
./bin/mark template rename old_name new_name

# Show version
./bin/mark version

# Show help
./bin/mark help
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

## Examples

### Basic Example

#### Template (template.md)
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

Please provide a complete, well-documented implementation.
```

#### Data File (data.md)
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

#### Generated Output
```bash
./bin/mark generate template.md data.md
```

## Commands

### Generate
Generate a prompt from a template file:
```bash
./bin/mark generate my_template.md
./bin/mark generate my_template.md my_data.md
```

### List
Show recently generated prompts:
```bash
./bin/mark list
```

### Clear
Clear all logs:
```bash
./bin/mark clear
```

### Config
Manage configuration options:
```bash
# Set configuration
./bin/mark config set editor nvim
./bin/mark config set template_dirs "~/.mark/templates:/usr/local/share/mark/templates"

# Get configuration
./bin/mark config get editor

# List all configuration
./bin/mark config list
```

### Template
Manage templates:
```bash
# List templates
./bin/mark template list

# Show template content
./bin/mark template show template_name

# Create a new template
./bin/mark template new template_name

# Edit an existing template
./bin/mark template edit template_name

# Delete a template
./bin/mark template delete template_name

# Rename a template
./bin/mark template rename old_name new_name
```

### Version
Show version information:
```bash
./bin/mark version
```

### Help
Show help information:
```bash
./bin/mark help
```

## Configuration

The tool can be configured using the configuration file located at `~/.mark.conf`. This file contains the following options:

- `LOG_FILE` - Log file location (default: `~/.mark.log`)
- `TEMPLATE_DIR` - Template directory (default: `~/.mark/templates`)
- `TEMPLATE_EXT` - Default template extension (default: `.md`)
- `DATA_EXT` - Data file extension (default: `.md`)
- `MAX_RECURSION_DEPTH` - Maximum recursion depth for file inclusion (default: `10`)
- `DEBUG` - Enable debug mode (default: `false`)

To customize these settings, edit the `~/.mark.conf` file according to your needs.

You can also manage configuration using the `config` command:
```bash
# Set configuration values
./bin/mark config set editor nvim
./bin/mark config set template_dirs "~/.mark/templates:/usr/local/share/mark/templates"

# Get configuration values
./bin/mark config get editor

# List all configuration
./bin/mark config list
```

## Template Management

`mark` provides comprehensive template management capabilities:

```bash
# List all templates
./bin/mark template list

# Show template content
./bin/mark template show template_name

# Create a new template
./bin/mark template new template_name

# Edit an existing template
./bin/mark template edit template_name

# Delete a template
./bin/mark template delete template_name

# Rename a template
./bin/mark template rename old_name new_name
```

## Testing

The tool includes a comprehensive test suite:
```bash
./tests/run_tests.sh
```

## Contributing

Contributions are welcome! Please submit pull requests for bug fixes, enhancements, or new features.

## License

This project is licensed under the MIT License - see the LICENSE file for details.