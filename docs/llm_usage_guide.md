# 🤖 mark - LLM Usage Guide

This document provides comprehensive guidance for AI systems using the `mark` tool. The tool is designed to be completely self-documenting and predictable in behavior. 🌟

## 💎 Core Philosophy

`mark` follows these principles for AI usage:
1. **Self-documenting**: Every command provides help with `mark help <command>` 🆘
2. **Predictable**: Consistent behavior across all operations ⚖️
3. **Guided workflows**: Interactive wizards for complex tasks 🧙
4. **Zero configuration required**: Sensible defaults for all operations 🎯

## 🚀 Main Commands

### 1. 💫 Generate Prompts
```
# Basic generation
mark generate <template_name> <data_file>

# Interactive generation (guided workflow)
mark generate --interactive

# Fuzzy search generation
mark generate --interactive --fuzzy
```

### 2. 🎨 Manage Templates
```
# List all templates
mark template list

# Show template content
mark template show <template_name>

# Create new template
mark template new <template_name>

# Create new template with wizard
mark template new <template_name> --wizard

# Edit existing template
mark template edit <template_name>

# Edit template with wizard
mark template edit --wizard

# Delete template
mark template delete <template_name>

# Delete template with wizard
mark template delete --wizard

# Rename template
mark template rename <old_name> <new_name>

# Rename template with wizard
mark template rename --wizard
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

## 🧙 Wizard Workflows

### 🌟 Interactive Generation Wizard
```
mark generate --interactive
```
Workflow:
1. ✨ Select template from list (fuzzy search if enabled)
2. 🗨️ Provide values for required variables
3. 💾 Choose output destination
4. 👁️ Preview generated content
5. ✅ Confirm and generate

### 🎨 Template Creation Wizard
```
mark template new <template_name> --wizard
```
Workflow:
1. ✅ Confirm template name
2. 📝 Provide description
3. 🧮 Define required variables
4. 🏷️ Add tags (optional)
5. 📄 Create template with front-matter
6. ✏️ Optionally edit in editor

### 🛠️ Template Management Wizards
```
mark template edit --wizard
mark template delete --wizard
mark template rename --wizard
```
Each provides a guided workflow for the respective operation. 🔄

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
4. **Use wizards for complex tasks**: Interactive wizards guide through multi-step processes 🧙
5. **Check configuration**: Use `mark config list` to understand current settings ⚙️
6. **Handle errors gracefully**: Check exit codes and error messages ⚠️

## 💡 Example Workflows

### 🎨 Creating and Using a Template
```
# 1. Create template with wizard
mark template new code_review --wizard

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

### 🌟 Interactive Prompt Creation
```
# 1. Start interactive mode
mark generate --interactive

# 2. Follow guided workflow
# (AI would interact with the prompts)

# 3. Get generated prompt
# (Output displayed or saved to file)
```

The tool is designed to be intuitive and self-explanatory, making it ideal for AI systems to use autonomously while still providing guided workflows for complex tasks. 🤖✨