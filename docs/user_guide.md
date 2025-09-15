# 📖 mark User Guide

## 🌟 Introduction

`mark` is a powerful Bash-based tool for generating AI/MCP-ready prompts from templates with support for placeholders, file substitution, conditional blocks, and loops. 🚀

## ⚙️ Installation

### ⚡ Quick Install
```bash
# Clone the repository
git clone https://github.com/AR-92/mark.git
cd mark

# Make the script executable
chmod +x mark

# Run the installation script
./install.sh
```

### 🔧 Manual Installation
```bash
# Clone the repository
git clone https://github.com/AR-92/mark.git
cd mark

# Make the script executable
chmod +x mark

# Optionally, copy to a directory in your PATH
sudo cp mark /usr/local/bin/
```

## 🚀 Basic Usage

### 💫 Generate a prompt from a template
```bash
mark generate template.md
```

### 📦 Generate a prompt with data file
```bash
mark generate template.md data.md
```

### 📋 List recently generated prompts
```bash
mark list
```

### 🧹 Clear logs
```bash
mark clear
```

### ❓ Show help
```bash
mark help
```

## 🎨 Template Syntax

### ✨ Basic Placeholders
```
Write a {{language}} program that {{task}}.
```

### 📁 File Inclusion
```
{{@requirements.md}}
```

### 🔀 Conditional Blocks
```
{{#if active}}
Welcome back to {{platform}}!
{{/if}}
```

### 🔁 Loop Blocks
```
{{#each requirements}}
- {{this}}
{{/each}}
```

## 🎓 Tutorials

The `mark` project includes comprehensive tutorials to help you master the tool at all skill levels:

- **Beginner**: Basic template creation and variable substitution 🟢
- **Intermediate**: Conditional blocks, loop structures, and file inclusion 🟡
- **Advanced**: Template inheritance, dynamic selection, and performance optimization 🔴
- **Ninja**: Self-optimizing systems, AI agent orchestration, and cross-domain synthesis ⚫

Tutorials are located in the `examples/tutorials` directory, with each level containing detailed documentation, example templates, and data files.

You can run the tutorials using the provided script:

```bash
./tests/run_tutorials.sh
```

## ⚙️ Configuration

The tool can be configured using the configuration file located at `conf/mark.conf`. The following options are available:

- `LOG_FILE` - Log file location 📄
- `TEMPLATE_DIR` - Template directory 📁
- `TEMPLATE_EXT` - Default template extension 📎
- `DATA_EXT` - Data file extension 📎
- `MAX_RECURSION_DEPTH` - Maximum recursion depth for file inclusion 🔁
- `DEBUG` - Enable debug mode (true/false) 🐛

🌈 Happy templating with `mark`!