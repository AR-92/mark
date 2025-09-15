# Enhancing mark with Gum

This guide explains how to use [Gum](https://github.com/charmbracelet/gum) to enhance the user experience of the `mark` CLI tool.

## What is Gum?

Gum is a tool for creating "glamorous shell scripts" that provides a suite of ready-to-use command-line UI components:

- **Choose**: Select an option from a list
- **Confirm**: Ask users to confirm an action
- **Input**: Prompt for text input
- **Write**: Collect multi-line text input
- **Filter**: Fuzzy-find through lists
- **Table**: Display tabular data
- **Pager**: Scroll through documents
- **Spin**: Show loading spinners
- **Style**: Apply colors, borders, and layouts

## Installation

First, install Gum using one of these methods:

### macOS
```bash
brew install gum
```

### Linux (Debian/Ubuntu)
```bash
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
sudo apt update && sudo apt install gum
```

### Linux (Red Hat/CentOS)
```bash
echo '[charm]
name=Charm
baseurl=https://repo.charm.sh/yum/
enabled=1
gpgkey=https://repo.charm.sh/yum/gpg.key' | sudo tee /etc/yum.repos.d/charm.repo
sudo yum install gum
```

### Other platforms
See [Gum installation instructions](https://github.com/charmbracelet/gum#installation) for more options.

## Enhancement Examples

### 1. Interactive Template Selection

Instead of needing to know exact template names, use Gum's filter for fuzzy searching:

```bash
# List all templates and select one interactively
template=$(mark template list | gum filter --placeholder "Select a template...")
mark template show "$template"
```

### 2. Styled Confirmation Dialogs

Replace basic y/N prompts with styled confirmations:

```bash
# Before
mark template delete my_template.md
# Are you sure you want to delete 'my_template.md'? (y/N)

# After
if gum confirm "Are you sure you want to delete 'my_template.md'?"; then
    mark template delete my_template.md
else
    echo "Deletion cancelled"
fi
```

### 3. Interactive Configuration

Create a guided configuration experience:

```bash
# Create a configuration wizard
echo "Welcome to mark configuration wizard!"

editor=$(gum input --placeholder "Preferred editor (vim, nano, code, etc.)" --default "vim")
template_dir=$(gum input --placeholder "Template directory" --default "~/.mark/templates")

gum confirm "Set editor to '$editor' and template directory to '$template_dir'?" && {
    mark config set editor "$editor"
    mark config set default_template_dir "$template_dir"
    echo "Configuration updated!"
}
```

### 4. Enhanced Template Creation

Create templates with guided input:

```bash
# Interactive template creation
name=$(gum input --placeholder "Template name (without .md extension)")
description=$(gum write --placeholder "Brief description of this template")

gum confirm "Create template '$name' with description: $description?" && {
    mark template new "$name"
    # Add the description as a comment in the template
    echo "<!-- $description -->" > ~/.mark/templates/"$name".md
    echo "# $name" >> ~/.mark/templates/"$name".md
    mark template edit "$name"
}
```

### 5. Styled Help System

Make the help output more visually appealing:

```bash
# Style the main help output
echo "# MARK - AI Prompt Templating Tool" | gum format -t template
echo "========================================" | gum format -t template
echo ""
gum style --foreground 212 "A powerful command-line tool for generating AI prompts from templates"
echo ""
gum style --border rounded --padding "1 2" "$(mark help)"
```

### 6. Interactive Prompt Generation

Guide users through data collection for prompt generation:

```bash
# Interactive data collection for prompt generation
template=$(mark template list | gum filter --placeholder "Select template for generation")

# Collect data interactively
echo "Collecting data for template: $template"
data_file=$(mktemp)

# Example for a code review template
echo "repo=$(gum input --placeholder 'Repository name')" >> "$data_file"
echo "branch=$(gum input --placeholder 'Branch name' --default 'main')" >> "$data_file"
echo "language=$(gum choose 'Python' 'JavaScript' 'Go' 'Java' 'C++')" >> "$data_file"
echo "urgency=$(gum choose 'Low' 'Medium' 'High' 'Critical')" >> "$data_file"

# Generate the prompt
output_file=$(gum input --placeholder "Output file name" --default "generated_prompt.md")
mark generate "$template" "$data_file" > "$output_file"

echo "Prompt generated: $output_file"
rm "$data_file"
```

## Integration Ideas for mark

### 1. Built-in Interactive Commands

Add new interactive subcommands to mark:

```bash
# Interactive template management
mark template select     # Select template with fuzzy finder
mark template create     # Create template with guided input

# Interactive configuration
mark config wizard       # Configuration wizard with guided steps

# Interactive generation
mark generate interactive  # Guide user through template/data selection
```

### 2. Visual Feedback

Add loading spinners for long operations:

```bash
# Show spinner during template generation
gum spin --title "Generating prompt..." -- mark generate "$template" "$data" > "$output"
```

### 3. Styled Output

Use Gum's formatting for better output presentation:

```bash
# Style successful operations
gum style --foreground 46 "✓ Template generated successfully"

# Style errors
gum style --foreground 196 "✗ Error: Template not found"
```

## Implementation Approach

To integrate Gum into mark:

1. **Check for Gum availability**: Before using Gum commands, check if Gum is installed
2. **Provide fallbacks**: Ensure mark still works without Gum (graceful degradation)
3. **Add new interactive commands**: Create new subcommands that leverage Gum
4. **Enhance existing commands**: Add optional Gum-based enhancements

Example implementation pattern:

```bash
# In your script, check for Gum
if command -v gum &> /dev/null; then
    # Use Gum for enhanced experience
    template=$(mark template list | gum filter --placeholder "Select a template...")
else
    # Fallback to basic experience
    echo "Available templates:"
    mark template list
    read -p "Enter template name: " template
fi
```

## Benefits

1. **Improved Usability**: Interactive elements make mark more approachable for new users
2. **Reduced Errors**: Fuzzy finding and validation reduce typos and mistakes
3. **Enhanced Experience**: Styled output and visual feedback improve user satisfaction
4. **Maintained Compatibility**: Graceful degradation ensures mark works without Gum
5. **Professional Appearance**: Modern UI elements give mark a polished, professional feel

## Getting Started

To start using Gum with mark:

1. Install Gum using the instructions above
2. Try the example commands in this guide
3. Experiment with creating your own interactive workflows
4. Consider contributing enhanced interactive commands to mark itself

For more information on Gum capabilities, visit the [Gum GitHub repository](https://github.com/charmbracelet/gum).