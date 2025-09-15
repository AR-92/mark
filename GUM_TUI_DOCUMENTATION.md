# Gum Shell TUI Components - Comprehensive Documentation

Gum is a tool for creating beautiful and user-friendly terminal user interfaces (TUI) for shell scripts. It provides a collection of components that make it easy to build interactive command-line applications with minimal effort.

## Table of Contents
1. [Introduction](#introduction)
2. [Installation](#installation)
3. [Core Components](#core-components)
   - [choose](#choose)
   - [confirm](#confirm)
   - [input](#input)
   - [write](#write)
   - [filter](#filter)
   - [file](#file)
   - [spin](#spin)
   - [style](#style)
   - [format](#format)
   - [table](#table)
   - [join](#join)
   - [log](#log)
   - [pager](#pager)
4. [Styling System](#styling-system)
5. [Environment Variables](#environment-variables)
6. [Practical Examples](#practical-examples)

## Introduction

Gum provides a set of intuitive commands that can be used to create interactive shell scripts with rich text user interfaces. Each command is designed to be simple to use while providing powerful customization options.

## Installation

### Using Package Managers

**Arch Linux (AUR):**
```bash
yay -S gum
```

**macOS (Homebrew):**
```bash
brew install gum
```

**Debian/Ubuntu:**
```bash
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
sudo apt update && sudo apt install gum
```

**Manual Installation:**
```bash
# Download the latest release
curl -L https://github.com/charmbracelet/gum/releases/latest/download/gum_$(uname -s)_$(uname -m).tar.gz | tar xz
sudo mv gum /usr/local/bin
```

## Core Components

### choose

The `choose` command allows users to select one or more options from a list.

**Basic Usage:**
```bash
# Single selection
gum choose "Option 1" "Option 2" "Option 3"

# Multiple selection
gum choose --limit=0 "Option 1" "Option 2" "Option 3"

# With custom styling
gum choose --cursor="👉 " --selected="✅ " "Option 1" "Option 2" "Option 3"
```

**Key Options:**
- `--limit=N`: Maximum number of options to pick (0 for unlimited)
- `--no-limit`: Pick unlimited number of options
- `--height=N`: Height of the list (default: 10)
- `--cursor=">"`: Prefix for the cursor position
- `--selected="✓ "`: Prefix for selected items
- `--header="Choose:"`: Header text
- `--timeout=5s`: Timeout for selection

**Example:**
```bash
#!/bin/bash
selected=$(gum choose --header="Select your favorite color:" "Red" "Green" "Blue")
echo "You selected: $selected"
```

### confirm

The `confirm` command asks users to confirm an action with a yes/no prompt.

**Basic Usage:**
```bash
# Simple confirmation
gum confirm "Do you want to continue?"

# With custom text
gum confirm --affirmative="Absolutely" --negative="No way" "Proceed with installation?"
```

**Key Options:**
- `--default`: Default confirmation action
- `--affirmative="Yes"`: Text for the affirmative action
- `--negative="No"`: Text for the negative action
- `--timeout=10s`: Timeout for confirmation

**Example:**
```bash
#!/bin/bash
if gum confirm "Do you want to delete all files?"; then
    echo "Files deleted!"
else
    echo "Operation cancelled."
fi
```

### input

The `input` command prompts users for short text input.

**Basic Usage:**
```bash
# Simple input
name=$(gum input --placeholder="Enter your name")

# Password input
password=$(gum input --password --placeholder="Enter password")

# With validation
email=$(gum input --placeholder="Enter email" --char-limit=50)
```

**Key Options:**
- `--placeholder="Type something..."`: Placeholder text
- `--prompt="> "`: Input prompt
- `--value="initial"`: Initial value
- `--password`: Mask input characters
- `--char-limit=N`: Maximum character limit
- `--width=N`: Input width
- `--timeout=30s`: Timeout for input

**Example:**
```bash
#!/bin/bash
project_name=$(gum input --placeholder="Enter project name" --header="New Project")
echo "Creating project: $project_name"
```

### write

The `write` command prompts users for long-form text input with a multi-line editor.

**Basic Usage:**
```bash
# Simple text area
description=$(gum write --placeholder="Enter description")

# With line limits
notes=$(gum write --max-lines=10 --placeholder="Enter notes")
```

**Key Options:**
- `--placeholder="Write something..."`: Placeholder text
- `--prompt="┃ "`: Line prompt
- `--width=N`: Text area width
- `--height=N`: Text area height
- `--value="initial"`: Initial value
- `--max-lines=N`: Maximum number of lines
- `--show-line-numbers`: Show line numbers
- `--timeout=5m`: Timeout for writing

**Example:**
```bash
#!/bin/bash
commit_message=$(gum write --header="Commit Message" --placeholder="Describe your changes")
git commit -m "$commit_message"
```

### filter

The `filter` command allows users to search and filter through a list of options.

**Basic Usage:**
```bash
# Simple filtering
selected=$(echo -e "Option 1
Option 2
Option 3" | gum filter)

# With fuzzy search
choice=$(gum filter --fuzzy < options.txt)
```

**Key Options:**
- `--placeholder="Filter..."`: Placeholder text
- `--prompt="> "`: Input prompt
- `--indicator="•"`: Selection indicator
- `--fuzzy`: Enable fuzzy matching
- `--limit=N`: Maximum selections
- `--value="search"`: Initial filter value
- `--timeout=30s`: Timeout for filtering

**Example:**
```bash
#!/bin/bash
# Filter through git branches
branch=$(git branch --format='%(refname:short)' | gum filter --placeholder="Select branch")
git checkout "$branch"
```

### file

The `file` command provides a file browser for selecting files or directories.

**Basic Usage:**
```bash
# Select a file
selected_file=$(gum file)

# Show hidden files
file_path=$(gum file --all)

# Select directories only
dir_path=$(gum file --directory)
```

**Key Options:**
- `path`: Starting directory path
- `--all`: Show hidden files
- `--file`: Allow file selection
- `--directory`: Allow directory selection
- `--cursor=">"`: Cursor character
- `--height=N`: Display height
- `--timeout=60s`: Timeout for selection

**Example:**
```bash
#!/bin/bash
# Select a configuration file
config_file=$(gum file ~/.config --header="Select config file")
cat "$config_file"
```

### spin

The `spin` command displays a spinner while running a command in the background.

**Basic Usage:**
```bash
# Simple spinner
gum spin --title="Loading..." -- sleep 3

# With command output
gum spin --show-output --title="Installing..." -- npm install
```

**Key Options:**
- `--title="Loading..."`: Spinner title
- `--spinner="dot"`: Spinner type (dot, line, minidot, jump, pulse, points, globe, moon, monkey, meter, hamburger)
- `--show-output`: Show command output
- `--show-error`: Show output only on error
- `--align="left"`: Title alignment
- `--timeout=30s`: Timeout for command

**Example:**
```bash
#!/bin/bash
# Show spinner during long operation
if gum spin --title="Fetching data..." -- curl -s https://api.example.com/data > data.json; then
    echo "Data fetched successfully!"
else
    echo "Failed to fetch data."
fi
```

### style

The `style` command applies styling to text, including colors, borders, and alignment.

**Basic Usage:**
```bash
# Simple styling
gum style --foreground=212 "Hello World"

# With border
gum style --border=rounded --padding="1 2" "Important Message"

# Multiple styles
gum style --bold --underline --foreground=33 "Styled Text"
```

**Key Options:**
- `--foreground="color"`: Text foreground color
- `--background="color"`: Text background color
- `--border="none"`: Border style (none, hidden, normal, rounded, thick, double)
- `--align="left"`: Text alignment (left, center, right, bottom, top)
- `--padding="0 0"`: Text padding (vertical horizontal)
- `--margin="0 0"`: Text margin
- `--bold`: Bold text
- `--italic`: Italic text
- `--underline`: Underline text

**Example:**
```bash
#!/bin/bash
gum style --border=double --border-foreground=33 --padding="1 2" --align=center "Application Started"
```

### format

The `format` command formats text using various templates and themes.

**Basic Usage:**
```bash
# Markdown formatting
echo "# Hello World

This is **bold** and *italic*." | gum format

# Code formatting
echo "console.log('Hello World');" | gum format --type=code --language=javascript

# Template formatting
echo "Hello {{.name}}!" | gum format --type=template
```

**Key Options:**
- `--type="markdown"`: Format type (markdown, template, code, emoji)
- `--theme="pink"`: Glamour theme for markdown
- `--language=""`: Programming language for code formatting

**Example:**
```bash
#!/bin/bash
cat << 'EOF' | gum format
# Installation Complete

Your application has been installed successfully!

## Next Steps
1. Run `./app --help` for usage instructions
2. Check the documentation at [docs.example.com](https://docs.example.com)

**Thank you for using our software!**
EOF
```

### table

The `table` command renders data in a tabular format with interactive features.

**Basic Usage:**
```bash
# Simple table from CSV
echo "Name,Age,City
John,25,New York
Jane,30,London" | gum table

# From file with custom columns
gum table --file=data.csv --columns="Name,Score,Status"
```

**Key Options:**
- `--separator=","`: Column separator
- `--columns=col1,col2`: Column names
- `--widths=w1,w2`: Column widths
- `--border="rounded"`: Border style
- `--file="data.csv"`: Input file
- `--height=N`: Table height
- `--print`: Static print mode

**Example:**
```bash
#!/bin/bash
# Display process information in a table
ps aux | head -10 | gum table --columns="USER,PID,%CPU,%MEM,COMMAND" --border=rounded
```

### join

The `join` command combines text vertically or horizontally.

**Basic Usage:**
```bash
# Vertical joining
gum join --vertical "Line 1" "Line 2" "Line 3"

# Horizontal joining
gum join --horizontal "Left" "Right"
```

**Key Options:**
- `--vertical`: Join text vertically
- `--horizontal`: Join text horizontally
- `--align="left"`: Text alignment

### log

The `log` command provides structured logging with different levels and formatting.

**Basic Usage:**
```bash
# Simple log message
gum log "Application started"

# With log level
gum log --level=info "Processing data"

# Structured logging
gum log --structured --level=error "Database connection failed" --prefix="DB"
```

**Key Options:**
- `--level="none"`: Log level (none, debug, info, warn, error, fatal)
- `--prefix="PREFIX"`: Log prefix
- `--format`: Format message using printf
- `--structured`: Use structured logging
- `--time=""`: Time format
- `--file="log.txt"`: Output to file

### pager

The `pager` command provides scrollable text viewing for long content.

**Basic Usage:**
```bash
# View file content
gum pager < README.md

# With line numbers
cat long-file.txt | gum pager --show-line-numbers
```

**Key Options:**
- `--show-line-numbers`: Show line numbers
- `--soft-wrap`: Soft wrap lines
- `--timeout=60s`: Timeout for viewing

## Styling System

Gum uses a comprehensive styling system that allows customization of colors, borders, and layout.

### Colors

Colors can be specified in several ways:
- **Named colors**: `red`, `green`, `blue`, `yellow`, `magenta`, `cyan`, `white`, `black`
- **256-color mode**: Numbers from 0-255
- **Hex colors**: `#FF5555`
- **RGB values**: `rgb(255,85,85)`

### Borders

Available border styles:
- `none`: No border
- `hidden`: Hidden border
- `normal`: Normal border
- `rounded`: Rounded corners
- `thick`: Thick border
- `double`: Double line border

### Spacing

Spacing properties:
- `--padding="vertical horizontal"`: Internal spacing
- `--margin="vertical horizontal"`: External spacing

### Text Styling

Text formatting options:
- `--bold`: Bold text
- `--faint`: Faint text
- `--italic`: Italic text
- `--strikethrough`: Strikethrough text
- `--underline`: Underline text

## Environment Variables

Most Gum options can be set using environment variables for consistent styling across scripts:

```bash
# Set default styles
export GUM_CHOOSE_CURSOR="👉 "
export GUM_INPUT_PROMPT="❯ "
export GUM_CONFIRM_AFFIRMATIVE="Yes"
export GUM_CONFIRM_NEGATIVE="No"

# Set colors
export GUM_STYLE_FOREGROUND=212
export GUM_STYLE_BORDER=rounded
```

## Practical Examples

### Interactive Project Setup Script

```bash
#!/bin/bash

# Welcome message
gum style --border=rounded --padding="1 2" --border-foreground=212 "🚀 Project Setup Wizard"

# Get project name
project_name=$(gum input --placeholder="MyAwesomeProject" --header="Enter project name")
[[ -z "$project_name" ]] && project_name="MyProject"

# Select project type
project_type=$(gum choose --header="Select project type" "Web Application" "CLI Tool" "Library" "API Service")

# Select features
features=$(gum choose --limit=0 --header="Select features to include" "Database" "Authentication" "Testing" "Documentation" "Docker")

# Confirm setup
if gum confirm "Create project '$project_name' with type '$project_type' and features: ${features//$'
'/, }?"; then
    gum spin --title="Creating project..." -- bash -c "
        mkdir -p \"$project_name\"
        cd \"$project_name\"
        echo \"# $project_name\" > README.md
        echo \"Project created on $(date)\" >> README.md
        mkdir -p src tests docs
    "
    gum style --border=rounded --padding="1 2" --border-foreground=46 "✅ Project '$project_name' created successfully!"
else
    echo "Setup cancelled."
fi
```

### Git Workflow Helper

```bash
#!/bin/bash

# Select Git operation
operation=$(gum choose "Commit" "Push" "Pull" "Status" "Log")

case $operation in
    "Commit")
        message=$(gum write --header="Commit Message" --placeholder="Describe your changes")
        if [[ -n "$message" ]]; then
            if gum confirm "Commit with message: '$message'?"; then
                gum spin --title="Committing changes..." -- git commit -m "$message"
            fi
        fi
        ;;
    "Push")
        branch=$(git branch --show-current)
        if gum confirm "Push to origin/$branch?"; then
            gum spin --title="Pushing changes..." -- git push origin "$branch"
        fi
        ;;
    "Pull")
        branch=$(git branch --show-current)
        if gum confirm "Pull from origin/$branch?"; then
            gum spin --title="Pulling changes..." -- git pull origin "$branch"
        fi
        ;;
    "Status")
        git status | gum pager
        ;;
    "Log")
        git log --oneline -20 | gum pager
        ;;
esac
```

### System Information Dashboard

```bash
#!/bin/bash

# Header
gum style --border=double --align=center --padding="1 3" --foreground=212 "🖥️  System Information Dashboard"

# System info
gum style --border=rounded --padding="1 2" --border-foreground=33 "🔧 System Details"
uname -a | gum format

# Disk usage
gum style --border=rounded --padding="1 2" --border-foreground=198 "💾 Disk Usage"
df -h | gum table --border=rounded

# Memory usage
gum style --border=rounded --padding="1 2" --border-foreground=46 "🧠 Memory Usage"
free -h | gum table --border=rounded

# Network interfaces
gum style --border=rounded --padding="1 2" --border-foreground=201 "🌐 Network"
ip addr show | grep "inet " | awk '{print $2 " " $NF}' | gum table --columns="IP,Interface" --border=rounded
```

This comprehensive documentation covers all the major features and components of Gum, providing both reference information and practical examples for creating beautiful terminal user interfaces.