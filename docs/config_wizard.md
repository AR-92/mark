# mark Config Wizard - Implementation Summary

This document provides a comprehensive overview of the config wizard feature for the `mark` CLI tool.

## Feature Overview

The config wizard provides an interactive, user-friendly way to manage `mark` configuration settings through:

1. **Interactive Menu System** - Guided configuration management
2. **Editor Integration** - Direct editing of config files with preferred editor
3. **Individual Value Setting** - Step-by-step configuration updates
4. **Default Reset** - Easy restoration of default configuration

## Implementation Details

### File Structure
```
lib/commands/
├── config.sh          # Main config command
├── config_wizard.sh   # Config wizard implementation
└── ...
```

### Key Functions

#### `config_wizard()`
Main entry point for the configuration wizard that presents users with options:
- Edit config in editor
- Set individual values
- Reset to defaults
- Cancel

#### `edit_config_in_editor()`
Handles opening the configuration file in the user's preferred editor:
- Uses editor from config or defaults to `vim`
- Creates backup before editing
- Shows diff after editing to confirm changes

#### `set_individual_values()`
Guides users through setting configuration values one at a time:
- Shows current values as defaults
- Allows blank entries to keep current values
- Updates only provided values

#### `reset_to_defaults()`
Resets configuration to built-in defaults:
- Prompts for confirmation
- Removes custom config file
- Falls back to default values

## Usage Examples

### Launch Config Wizard
```bash
mark config wizard
```

### Interactive Menu Options
1. **Edit config in editor**
   - Opens config file in preferred editor
   - Supports vim, nano, emacs, code, etc.
   - Shows before/after diff

2. **Set individual values**
   - Step-by-step configuration
   - Current values shown as defaults
   - Only update provided values

3. **Reset to defaults**
   - Confirmation prompt
   - Removes custom config
   - Restores built-in defaults

### Direct Configuration Commands
```bash
# Set configuration values
mark config set editor nvim
mark config set use_fzf true
mark config set template_dirs "~/.mark/templates:/usr/share/mark"

# Get configuration values
mark config get editor

# List all configuration
mark config list
```

## Configuration Keys

### Supported Keys
- `template_dirs` - Template search directories (colon-separated)
- `default_template_dir` - Default directory for new templates
- `editor` - Preferred editor for template operations
- `use_fzf` - Enable/disable fuzzy finder (true/false)
- `data_file_formats` - Allowed data file formats (comma-separated)
- `wizard_questions` - Default questions for wizard mode templates

### Default Values
- `template_dirs`: `~/.mark/templates`
- `editor`: `vim`
- `use_fzf`: `false`
- `data_file_formats`: `json,yaml,toml`
- `wizard_questions`: `name,description,variables,tags`

## Editor Support

The config wizard works with any text editor available on the system:
- **vim** - Default editor
- **nvim** - Neovim
- **nano** - Simple terminal editor
- **emacs** - GNU Emacs
- **code** - VS Code
- **subl** - Sublime Text

Editor is configured with:
```bash
mark config set editor <editor-name>
```

## Error Handling

### Editor Not Found
- Shows error message
- Provides guidance for setting different editor
- Falls back to default behavior

### File Permissions
- Creates config directory if missing
- Handles read/write permissions gracefully
- Provides clear error messages

### User Cancellation
- Respects user choice to cancel
- Preserves existing configuration
- Clean exit with appropriate messages

## Integration with Existing Features

### Backward Compatibility
- All existing config commands continue to work
- No breaking changes to API
- Maintains same configuration file format

### Enhanced Help System
- Updated help includes wizard information
- Detailed examples for all commands
- Self-documenting interface

### Wizard Consistency
- Follows same patterns as other wizards
- Uses common interactive utilities
- Consistent user experience

## Testing

### Unit Tests
- Config wizard function definition
- Help system integration
- Command execution without errors

### Integration Tests
- End-to-end wizard execution
- Config set/get/list functionality
- Editor integration (simulated)

### Error Condition Tests
- Missing editor handling
- File permission scenarios
- User cancellation paths

## Future Enhancements

### Planned Features
1. **Configuration Validation**
   - Input validation for config values
   - Type checking for boolean/numeric values
   - Format validation for paths/lists

2. **Advanced Editor Integration**
   - Editor-specific configuration
   - Syntax highlighting for config files
   - Template-based config editing

3. **Configuration Profiles**
   - Multiple configuration profiles
   - Profile switching
   - Environment-specific settings

4. **Interactive Documentation**
   - Inline help for each setting
   - Examples for each configuration key
   - Links to detailed documentation

## Conclusion

The config wizard provides a significant improvement to the user experience by making configuration management intuitive and accessible. Users can now:

- Easily discover and modify configuration options
- Use their preferred editor for direct file editing
- Make incremental changes without memorizing commands
- Reset to defaults when needed
- Get guided assistance through the process

The implementation maintains full backward compatibility while adding powerful new capabilities that make `mark` more user-friendly for both beginners and experienced users.