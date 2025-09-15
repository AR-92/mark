#!/bin/bash

# mark - Formatted About/Info page
# Beautiful, formatted information page using Gum

# Check if Gum is installed
check_gum() {
    command -v gum &> /dev/null
}

# Show formatted about page
show_about_formatted() {
    if check_gum; then
        # Use Gum formatting for a beautiful about page
        cat << 'EOF' | gum format -t markdown
# ❓ About mark - AI Prompt Templating Tool

**Version:** 1.0.0

## 📝 Description

`mark` is a powerful Bash-based tool for generating AI/MCP-ready prompts from templates with support for placeholders, file substitution, conditional blocks, and loops.

## ✨ Features

- **Placeholders**: `{{variable_name}}` for simple variable substitution
- **File Substitution**: `{{@file_path}}` to include content from other files
- **Conditional Blocks**: `{{#if condition}}...{{/if}}` for conditional content
- **Loop Blocks**: `{{#each array}}...{{/each}}` for iterating over lists
- **Template Management**: List, show, create, edit, delete, and rename templates
- **Configuration Management**: Set, get, and list configuration options
- **Interactive TUI**: Beautiful terminal interface with Gum integration

## 🚀 The Power of mark for AI Agents and Prompt Creation

`mark` transforms how AI agents and developers create, manage, and deploy prompts by providing a robust templating system that enables:

### 1. Dynamic Prompt Generation
Generate thousands of unique prompts from a single template by varying input parameters.

### 2. Modular Prompt Architecture
Build complex, reusable prompt components that can be combined and nested.

### 3. Context-Aware AI Agents
Enable AI agents to dynamically construct prompts based on user context and preferences.

### 4. Production-Ready Prompt Orchestration
Deploy AI systems that generate prompts on-demand with error handling and validation.

## 🎯 Novel Use Cases

### 1. Automated Code Review Agent
```bash
# Template for code review prompts with dynamic rules
./mark generate code_review_template.md project_context.md > review_prompt.txt
# Agent uses this prompt to review pull requests with project-specific guidelines
```

### 2. Personalized Learning Assistant
```bash
# Generate customized lesson plans based on student progress
./mark generate lesson_template.md student_profile.md > personalized_lesson.txt
# AI tutor delivers adaptive content tailored to each learner
```

### 3. Multi-Language Content Generator
```bash
# Create localized marketing content with cultural adaptations
./mark generate content_template.md localization_data.md > localized_content.txt
# Automatically generate region-specific campaigns
```

## 🔗 Links

- **Repository**: https://github.com/AR-92/mark
- **Documentation**: See README.md for detailed information
- **Issues**: Report bugs at https://github.com/AR-92/mark/issues

## 💻 Made with ❤️ for AI developers and prompt engineers
EOF
    else
        # Fall back to plain text about page
        show_about_plain
    fi
}

# Show plain text about page (fallback)
show_about_plain() {
    echo "mark - AI Prompt Templating Tool v1.0.0"
    echo "======================================"
    echo ""
    echo "Description:"
    echo "  mark is a powerful Bash-based tool for generating AI/MCP-ready prompts from"
    echo "  templates with support for placeholders, file substitution, conditional blocks, and loops."
    echo ""
    echo "Features:"
    echo "  - Placeholders: {{variable_name}} for simple variable substitution"
    echo "  - File Substitution: {{@file_path}} to include content from other files"
    echo "  - Conditional Blocks: {{#if condition}}...{{/if}} for conditional content"
    echo "  - Loop Blocks: {{#each array}}...{{/each}} for iterating over lists"
    echo "  - Template Management: List, show, create, edit, delete, and rename templates"
    echo "  - Configuration Management: Set, get, and list configuration options"
    echo "  - Interactive TUI: Beautiful terminal interface with Gum integration"
    echo ""
    echo "The Power of mark for AI Agents and Prompt Creation:"
    echo "  mark transforms how AI agents and developers create, manage, and deploy"
    echo "  prompts by providing a robust templating system that enables:"
    echo ""
    echo "  1. Dynamic Prompt Generation"
    echo "     Generate thousands of unique prompts from a single template by varying input parameters."
    echo ""
    echo "  2. Modular Prompt Architecture"
    echo "     Build complex, reusable prompt components that can be combined and nested."
    echo ""
    echo "  3. Context-Aware AI Agents"
    echo "     Enable AI agents to dynamically construct prompts based on user context and preferences."
    echo ""
    echo "  4. Production-Ready Prompt Orchestration"
    echo "     Deploy AI systems that generate prompts on-demand with error handling and validation."
    echo ""
    echo "Links:"
    echo "  Repository: https://github.com/AR-92/mark"
    echo "  Documentation: See README.md for detailed information"
    echo "  Issues: Report bugs at https://github.com/AR-92/mark/issues"
    echo ""
    echo "Made with ❤️ for AI developers and prompt engineers"
}

# Export the functions
export -f show_about_formatted
export -f show_about_plain
export -f check_gum