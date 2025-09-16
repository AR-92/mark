# mark — Prompt / Template Generation Tool

```
Usage:
  mark generate <template_name> [data_file] [options]
  mark template <command> [args] [options]
  mark config [set|get] <key> [value]
  mark help
  mark version
```

------

## Description

`mark` is a CLI tool to manage and generate prompt / template-based text (for chatbots, code scaffolds, writing workflows, etc.). It supports variables, conditionals, loops, includes, and enhanced workflow features like template dirs and template editing.

------

## Commands

### generate

Generate output from a template, optionally using a data file (e.g. JSON / YAML / TOML / other).

```
mark generate <template_name> [data_file] [--out <output_file>] [--template-dir <dir>] [--editor <editor>] [--dry-run] [--force]
```

**Arguments:**

- `<template_name>`: The name (or identifier) of a template to use.
- `[data_file]`: Path to a file supplying variable values (optional).

**Options:**

| Option                 | Description                                                  |
| ---------------------- | ------------------------------------------------------------ |
| `--out <output_file>`  | Write generated output to `<output_file>` instead of stdout. |
| `--template-dir <dir>` | Use `<dir>` as (an additional) template directory. Overrides or precedes what's set in config. |
| `--editor <editor>`    | Edit output in the given editor before finalizing. Useful for quick tweaks. |
| `--dry-run`            | Show what would happen (rendered output) without writing / saving. |
| `--force`              | Overwrite existing output file(s) without prompting.         |

**Examples:**

```
mark generate welcome_email user_data.json --out out.txt
mark generate report_template --template-dir ~/my-templates
```

------

### template

Manage templates.

```
mark template list [--tag <tag>] [--template-dir <dir>]
mark template show <template_name> [--template-dir <dir>]
mark template new <template_name> [--template-dir <dir>]
mark template edit <template_name> [--template-dir <dir>] [--editor <editor>]
mark template delete <template_name> [--template-dir <dir>]
mark template rename <old_name> <new_name> [--template-dir <dir>]
```

**Subcommands:**

- `list`: List all templates available. If `--tag` is given, filter to templates with matching tag(s). If `--template-dir` given, include that directory.
- `show`: Output the raw template content to stdout.
- `new`: Create a new template. Opens an editor (default or configured) to create a blank template file.
- `edit`: Edit an existing template in editor.
- `delete`: Remove a template (prompt for confirmation).
- `rename`: Rename a template.

**Options:**

- `--tag <tag>`: When creating, assign tag(s). When listing, filter by tag.
- `--template-dir <dir>`: Use a specific template directory (if you have multiple or want to override default).
- `--editor <editor>`: Which editor to use (vim, nvim, nano, etc.).

------

### config

Set or query configuration values.

```
mark config set <key> <value>
mark config get <key>
mark config list
```

**Configurable keys:**

| Key                    | Description                                                  | Example values                                            |
| ---------------------- | ------------------------------------------------------------ | --------------------------------------------------------- |
| `template_dirs`        | List of directories to search for templates.                 | `["~/.mark/templates", "./templates", "/usr/share/mark"]` |
| `default_template_dir` | Directory to use by default for new templates.               | `~/.mark/templates`                                       |
| `editor`               | Default editor for `template new` / `template edit`.         | `vim`, `nvim`, `nano`, `code`                             |
| `use_fzf`              | Boolean: whether to use fuzzy finder when selecting templates. | `true` / `false`                                          |
| `data_file_formats`    | Allowed / preferred formats for data input (e.g. JSON, YAML). | `["json","yaml","toml"]`                                  |

------

### version

```
mark version
```

Show version of the tool.

------

### help

```
mark help [command]
```

Show help (general), or help for a given command (e.g. `mark help template edit`).

------

## Workflow Examples

### 1. Adding & editing a template

```
mark template new feature_request --tag support
```

→ opens your editor to type content

### 2. Generating output

If you have a template and data file, do:

```
mark generate feature_request feature_data.yaml --out out.txt
```

### 3. Configuring template directories

Suppose you store your personal templates in `~/.mark/templates` and shared ones in `/etc/mark/templates`. Set:

```
mark config set template_dirs "~/.mark/templates:/etc/mark/templates"
```

Later, generate using either set of templates.

------

## Configuration File

`mark` should support a config file in a standard location (e.g. `~/.mark/config.yml`), environment variable overrides, or command-line overrides.

### Example `~/.mark/config.yml`

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

------

## Error Handling & Validation

- If template not found in any `template_dirs`, return error listing the dirs searched.
- If required variables are missing and not provided via data file, fail with message.
- If data file contains extra variables not used in template, warn.
- Validate data file format (if expected to be JSON/YAML etc).

------

## Help & Usage Examples

Include many usage examples in help, e.g.:

```
Examples:

  # List templates
  mark template list

  # Create a new template
  mark template new sales_pitch

  # Edit a template
  mark template edit sales_pitch

  # Show template content
  mark template show welcome_email

  # Generate using a data file
  mark generate welcome_email data/user1.json > output.txt

  # Override template directory
  mark generate invoice --template-dir ~/other_templates

  # Delete a template
  mark template delete old_template

  # Rename a template
  mark template rename old_name new_name

  # View or set configuration
  mark config list
  mark config set editor vim
  mark config get editor
```

------

## Sample Full Help Output (what user sees with `mark help`)

```
mark 1.0.0
Prompt / Template generation tool.

Commands:
  generate <template_name> [data_file]      Generate output from a template.
  template list                             List available templates.
  template show <template_name>             Show raw content of a template.
  template new <template_name>              Create a new template.
  template edit <template_name>             Edit an existing template.
  template delete <template_name>           Delete a template.
  template rename <old> <new>               Rename a template.
  config set <key> <value>                  Set a configuration option.
  config get <key>                          Get a configuration option.
  config list                               Show all configuration options.
  version                                   Show version.
  help [command]                            Show this help or subcommand help.

Global Options:
  --template-dir <dir>   Use an additional / alternative template directory.
  --editor <editor>       Editor to use (overrides configuration).
  --dry-run                Show generation without saving / writing files.
  --force                  Overwrite output files without prompting.

Use "mark help <command>" for more details on a command.
```