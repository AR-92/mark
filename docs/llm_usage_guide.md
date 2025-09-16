# 🤖 mark - LLM Usage Guide

This document provides comprehensive guidance for AI systems using the `mark` tool. The tool is designed to be completely self-documenting and predictable in behavior. 🌟

## 💎 Core Philosophy

`mark` follows these principles for AI usage:
1. **Self-documenting**: Every command provides help with `mark help <command>` 🆘
2. **Predictable**: Consistent behavior across all operations ⚖️
3. **Zero configuration required**: Sensible defaults for all operations 🎯

## 🚀 Main Commands

### 1. 💫 Generate Prompts
```
# Basic generation
mark generate <template_name> <data_file>

# Generate with output file
mark generate <template_name> <data_file> --out <output_file>
```

### 2. 🎨 Manage Templates
```
# List all templates
mark template list

# Show template content
mark template show <template_name>

# Create new template
mark template new <template_name>

# Edit existing template
mark template edit <template_name>

# Delete template
mark template delete <template_name>

# Rename template
mark template rename <old_name> <new_name>
```

### 3. ⚙️ Configuration
```
# Set configuration values
mark config set <key> <value>

# Get configuration values
mark config get <key>

# List all configuration
mark config list
```

### 4. 🛠️ Utility Commands
```
# Show version
mark version

# Show help
mark help

# Show detailed help
mark help <command>
```

## 📄 Template Structure

Templates use a simple syntax:
```
---
name: template_name
description: "Template description"
tags:
  - tag1
  - tag2
variables:
  - variable1
  - variable2
---
Template content with {{variable1}} and {{variable2}}
```

## 📂 Data Files

Simple key=value format:
```
variable1=Value 1
variable2=Value 2
```

## ⚙️ Configuration Options

```
# Set editor
mark config set editor nvim

# Enable fuzzy finder
mark config set use_fzf true

# Set template directories
mark config set template_dirs "~/.mark/templates:/usr/share/mark"
```

## 📊 Exit Codes

- 0: Success ✅
- 1: General error ❌
- 2: Template not found 🚫
- 3: Missing required variables ❓
- 4: Invalid data file 💥

## 🌟 Best Practices for AI Systems

1. **Always check help first**: Use `mark help` to understand available commands 🆘
2. **List templates before use**: Use `mark template list` to see available templates 📋
3. **Examine templates**: Use `mark template show <name>` to understand template structure 👀
4. **Check configuration**: Use `mark config list` to understand current settings ⚙️
5. **Handle errors gracefully**: Check exit codes and error messages ⚠️

## 💡 Example Workflows

### 🎨 Creating and Using a Template
```
# 1. Create template
mark template new code_review

# 2. List templates to verify
mark template list

# 3. Show template to examine
mark template show code_review

# 4. Create data file
echo "project_name=My Project
language=Python" > code_review_data.txt

# 5. Generate prompt
mark generate code_review code_review_data.txt --out code_review_prompt.txt
```

### 🌟 Prompt Creation
```
# 1. List available templates
mark template list

# 2. Examine template structure
mark template show code_review

# 3. Generate prompt with data
mark generate code_review code_review_data.txt --out code_review_prompt.txt

# 4. Get generated prompt
# (Output displayed or saved to file)
```

The tool is designed to be intuitive and self-explanatory, making it ideal for AI systems to use autonomously. 🤖✨