# mark TUI - Full Terminal User Interface Documentation

## Overview

The mark TUI (Terminal User Interface) is a beautiful, interactive dashboard for the mark CLI tool that provides a complete graphical interface in the terminal using Gum components. It brings together all functionality of mark in a user-friendly, visually appealing interface.

## Features

### Main Dashboard
- Beautiful header with application branding
- Status bar with usage tips
- Main navigation menu with all major functionality
- Visual styling with rounded borders and custom colors

### Template Management
- List all templates with visual presentation
- Show template content with syntax highlighting
- Create new templates with guided workflow
- Edit existing templates with external editor integration
- Delete templates with confirmation dialogs
- Rename templates with validation

### Prompt Generation
- Interactive generation wizard with step-by-step guidance
- Quick generate with data files
- Quick generate without data files
- Visual feedback during generation process
- Output preview and save options

### Configuration Management
- List all configuration settings
- Set configuration values with input validation
- Get specific configuration values
- Reset configuration to defaults

### Help & Documentation
- Main help documentation
- Command reference with detailed information
- Tutorial access and information
- About section with application details

### System Operations
- Upgrade mark to latest version
- Uninstall mark from system
- Visual confirmation for destructive operations

## Navigation

### Keyboard Controls
- **Arrow Keys**: Navigate between menu options
- **Enter**: Select current menu option
- **Ctrl+C**: Exit the application at any time
- **Tab**: (Where supported) Move between input fields

### Menu Structure
```
Main Dashboard
├── Template Management
│   ├── List All Templates
│   ├── Show Template Content
│   ├── Create New Template
│   ├── Edit Template
│   ├── Delete Template
│   └── Rename Template
├── Prompt Generation
│   ├── Interactive Generation Wizard
│   ├── Quick Generate (with data)
│   └── Quick Generate (no data)
├── Configuration
│   ├── List All Settings
│   ├── Set Configuration Value
│   ├── Get Configuration Value
│   └── Reset to Defaults
├── Help & Documentation
│   ├── Main Help
│   ├── Command Reference
│   ├── Tutorials
│   └── About mark
├── Upgrade mark
├── Uninstall mark
└── Exit
```

## Visual Components

### Styling
The TUI uses a consistent color scheme with contextual colors:
- **Pink (212)**: Primary branding and headers
- **Purple (99)**: Template management sections
- **Yellow (220)**: Prompt generation sections
- **Green (46)**: Success messages and configuration
- **Magenta (201)**: Help and documentation
- **Red (196)**: Error messages and warnings
- **Gray (240)**: Secondary text and instructions

### Components Used
- **gum style**: For headers, panels, and styled text
- **gum choose**: For menu navigation and selections
- **gum input**: For data entry and user input
- **gum confirm**: For confirmation dialogs
- **gum spin**: For loading indicators and progress feedback
- **gum format**: For formatted documentation display

## Usage

### Launching the TUI
```bash
# From the mark directory
./bin/mark-tui

# Or if installed globally
mark-tui
```

### Requirements
- [Gum](https://github.com/charmbracelet/gum) must be installed
- mark CLI tool must be available
- Terminal that supports ANSI colors and formatting

### First Time Use
1. Ensure Gum is installed (`setup_gum.sh` can help with this)
2. Run `./bin/mark-tui` to launch the interface
3. Navigate using arrow keys and select with Enter
4. Follow the on-screen prompts for each operation

## Customization

### Environment Variables
The TUI respects Gum environment variables for customization:
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

### Color Scheme Modification
Colors can be modified by changing the `--foreground` and `--border-foreground` values in the styling commands throughout the script.

## Implementation Details

### Architecture
The TUI is implemented as a single Bash script that:
1. Checks for Gum installation
2. Presents a main dashboard menu
3. Routes to specific function sections based on user selection
4. Uses Gum components for all UI elements
5. Integrates with existing mark CLI commands
6. Provides visual feedback for all operations

### Error Handling
- All operations include error checking
- User input is validated where appropriate
- Destructive operations require confirmation
- Clear error messages are displayed for failures
- Graceful degradation when commands fail

### Performance
- Loading spinners provide feedback during operations
- Asynchronous operations where possible
- Efficient use of existing mark CLI commands
- Minimal resource usage

## Development

### Adding New Features
To add new features to the TUI:
1. Add a new menu option in the appropriate section
2. Create a new function to handle the feature
3. Use Gum components for UI elements
4. Integrate with existing mark CLI commands
5. Add appropriate error handling and feedback

### Code Structure
```
mark-tui
├── Main functions
│   ├── check_gum()
│   ├── show_dashboard()
│   └── main()
├── Section menus
│   ├── template_management_menu()
│   ├── prompt_generation_menu()
│   ├── configuration_menu()
│   └── help_menu()
├── Template management functions
│   ├── list_templates_tui()
│   ├── show_template_tui()
│   ├── create_template_tui()
│   ├── edit_template_tui()
│   ├── delete_template_tui()
│   └── rename_template_tui()
├── Prompt generation functions
│   ├── interactive_generate_tui()
│   ├── quick_generate_with_data_tui()
│   └── quick_generate_no_data_tui()
├── Configuration functions
│   ├── list_config_tui()
│   ├── set_config_tui()
│   ├── get_config_tui()
│   └── reset_config_tui()
├── Help functions
│   ├── show_main_help_tui()
│   ├── show_commands_help_tui()
│   ├── show_tutorials_tui()
│   └── show_about_tui()
└── System functions
    ├── upgrade_mark_tui()
    ├── uninstall_mark_tui()
    └── exit_tui()
```

## Troubleshooting

### Common Issues

1. **"Gum is not installed" error**
   - Solution: Install Gum using `setup_gum.sh` or manually

2. **Commands not found**
   - Solution: Ensure mark CLI is in PATH or run from correct directory

3. **Editor not opening for template creation/editing**
   - Solution: Check configuration for editor setting

4. **Slow performance**
   - Solution: Check system resources and template directory size

### Debugging
- Run with `bash -x ./bin/mark-tui` for verbose output
- Check Gum installation with `gum --version`
- Verify mark CLI works independently with `./bin/mark help`

## Future Enhancements

### Planned Features
1. **Template Gallery**: Pre-built templates for common use cases
2. **History Tracking**: Recently generated prompts and templates
3. **Export Options**: Multiple output formats (PDF, HTML, etc.)
4. **Batch Operations**: Process multiple templates at once
5. **Search Functionality**: Full-text search in templates
6. **Keyboard Shortcuts**: Direct access to common functions
7. **Theme Support**: Multiple color schemes and styling options

### Integration Possibilities
1. **AI Assistant Integration**: Context-aware prompt suggestions
2. **Version Control**: Git integration for template management
3. **Cloud Storage**: Sync templates across devices
4. **Plugin System**: Extend functionality with custom modules
5. **Analytics Dashboard**: Usage statistics and insights

## Contributing

The TUI is designed to be extensible and maintainable:

1. **Fork the repository**
2. **Create a feature branch**
3. **Implement your enhancement**
4. **Test thoroughly**
5. **Submit a pull request**

When contributing, follow these guidelines:
- Maintain consistent styling with existing components
- Use appropriate Gum components for UI elements
- Include error handling for new functionality
- Update documentation when adding features
- Test across different terminal environments