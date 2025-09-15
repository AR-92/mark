# mark - Comprehensive Help System

## Main Commands

### generate
Generate output from a template, optionally using a data file.

```
mark generate <template_name> [data_file] [--out <output_file>] [--template-dir <dir>] [--interactive] [--fuzzy] [--editor <editor>] [--dry-run] [--force]
```

**Arguments:**
- `<template_name>`: The name (or identifier) of a template to use.
- `[data_file]`: Path to a file supplying variable values (optional).

**Options:**
- `--out <output_file>`: Write generated output to `<output_file>` instead of stdout.
- `--template-dir <dir>`: Use `<dir>` as (an additional) template directory.
- `--interactive`: Prompt for missing variable values via CLI.
- `--fuzzy`: Use a fuzzy picker (e.g. `fzf`) to select the template interactively.
- `--editor <editor>`: Edit output in the given editor before finalizing.
- `--dry-run`: Show what would happen (rendered output) without writing/saving.
- `--force`: Overwrite existing output file(s) without prompting.

**Examples:**
```
mark generate welcome_email user_data.json --out out.txt
mark generate --interactive --fuzzy
mark generate report_template --template-dir ~/my-templates
```

### template
Manage templates with subcommands.

```
mark template list [--tag <tag>] [--template-dir <dir>]
mark template show <template_name> [--template-dir <dir>]
mark template new <template_name> [--template-dir <dir>] [--wizard]
mark template edit <template_name> [--template-dir <dir>] [--editor <editor>]
mark template delete <template_name> [--template-dir <dir>]
mark template rename <old_name> <new_name> [--template-dir <dir>]
```

**Subcommands:**
- `list`: List all templates available.
- `show`: Output the raw template content to stdout.
- `new`: Create a new template.
- `edit`: Edit an existing template in editor.
- `delete`: Remove a template (prompt for confirmation).
- `rename`: Rename a template.

### config
Set or query configuration values.

```
mark config set <key> <value>
mark config get <key>
mark config list
```

**Configurable keys:**
- `template_dirs`: List of directories to search for templates.
- `default_template_dir`: Directory to use by default for new templates.
- `editor`: Default editor for `template new` / `template edit`.
- `use_fzf`: Boolean: whether to use fuzzy finder when selecting templates.
- `data_file_formats`: Allowed formats for data input (json, yaml, toml).

### version
Show version of the tool.

```
mark version
```

### help
Show help information.

```
mark help [command]
```

## Wizard Mode

### Interactive Generation Wizard
```
mark generate --interactive [--fuzzy]
```

This mode guides users through:
1. Template selection (with fuzzy finder if enabled)
2. Variable input with prompts and validation
3. Output destination selection
4. Preview and confirmation

### Template Creation Wizard
```
mark template new <template_name> --wizard
```

This mode guides users through:
1. Template name confirmation
2. Description input
3. Variable definition (name, type, description)
4. Sample content creation
5. Tag assignment (optional)
6. Template file creation and editing

## Workflow Examples

### 1. Quick Prompt Generation
```
# Start interactive mode
mark generate --interactive

# If fuzzy finder is enabled
mark generate --interactive --fuzzy
```

### 2. Template Creation with Wizard
```
# Create new template with guided process
mark template new my_template --wizard
```

### 3. Template Management
```
# List all templates
mark template list

# Show template content
mark template show my_template

# Edit existing template
mark template edit my_template

# Delete template
mark template delete my_template

# Rename template
mark template rename old_name new_name
```

### 4. Configuration Management
```
# Set editor
mark config set editor nvim

# Enable fuzzy finder
mark config set use_fzf true

# View all configuration
mark config list
```

## Template Structure

Templates can include metadata in YAML front-matter:

```markdown
---
name: feature_request
description: "Prompt to ask for a new feature from customer support"
tags: ["support", "feature"]
variables:
  - customer_name
  - feature_description
---
Hello {{ customer_name }},

Thank you for your suggestion! We'd love to learn more about the feature:

"{{ feature_description }}"

Best,
The Team
```

## Data File Formats

### Simple key=value format
```
customer_name=John Doe
feature_description=Add dark mode to the application
```

### JSON format (if enabled)
```json
{
  "customer_name": "John Doe",
  "feature_description": "Add dark mode to the application"
}
```

### YAML format (if enabled)
```yaml
customer_name: John Doe
feature_description: Add dark mode to the application
```

## Advanced Features

### Conditional Blocks
```
{{#if condition}}
Content when condition is true
{{/if}}

{{#if condition}}
Content when condition is true
{{else}}
Content when condition is false
{{/if}}
```

### Loop Blocks
```
{{#each items}}
- {{this}}
{{/each}}
```

### File Inclusion
```
{{@path/to/file.md}}
```

## Environment Variables

All environment variables are automatically available in templates:
```
Current user: {{USER}}
Current directory: {{PWD}}
```

## Error Handling

Common error messages and their meanings:

- "Template not found": The specified template doesn't exist in any template directory
- "Missing required variable": A variable used in the template wasn't provided in data file or via interactive input
- "Invalid data file format": The data file format isn't supported or is malformed

## Configuration File

Default location: `~/.mark/config.yml`

Example:
```yaml
template_dirs:
  - ~/.mark/templates
  - ~/shared/mark_templates
editor: nvim
use_fzf: true
data_file_formats:
  - json
  - yaml
default_template_dir: ~/.mark/templates
```

## Exit Codes

- 0: Success
- 1: General error
- 2: Template not found
- 3: Missing required variables
- 4: Invalid data file

## LLM Usage Guide

For AI systems using this tool:

1. Always start with `mark help` to understand available commands
2. Use `mark template list` to see available templates
3. Use `mark template show <template_name>` to examine template structure
4. Use `mark generate <template_name> <data_file>` for automated generation
5. Use `mark generate --interactive` for guided generation
6. Use `mark template new <name> --wizard` for template creation
7. Use `mark config list` to check current configuration
8. Use `mark version` to check tool version

The tool is designed to be completely self-documenting and predictable in behavior.