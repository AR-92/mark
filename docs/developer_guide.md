# mark Developer Guide

## Project Structure

```
mark/
├── bin/                 # Executable scripts
│   ├── mark             # Main executable
│   └── install.sh       # Installation script
├── lib/                 # Library modules
│   ├── core/            # Core configuration and logging
│   │   ├── config.sh
│   │   └── logging.sh
│   ├── commands/        # Command implementations
│   │   ├── generate.sh
│   │   ├── list.sh
│   │   ├── clear.sh
│   │   └── help.sh
│   ├── utils/           # Utility functions
│   │   ├── parser.sh
│   │   └── processor.sh
│   └── templates/       # Built-in templates (optional)
│       └── tests/       # Template tests and resources
├── tests/               # Test suite
├── examples/            # Example templates and data
├── docs/                # Documentation
├── conf/                # Configuration files
├── dist/                # Distribution packages
├── README.md            # Project documentation
├── LICENSE              # MIT License
├── CHANGELOG.md         # Version history
└── .gitignore           # Git ignore file
```

## Code Structure

### Main Entry Point
The main entry point is `bin/mark`, which routes commands to their respective implementations.

### Core Modules
- `lib/core/config.sh` - Configuration management
- `lib/core/logging.sh` - Logging functionality

### Command Implementations
- `lib/commands/generate.sh` - Template generation logic
- `lib/commands/list.sh` - Prompt listing functionality
- `lib/commands/clear.sh` - Log clearing functionality
- `lib/commands/help.sh` - Help display functionality

### Utility Functions
- `lib/utils/parser.sh` - Template parsing logic
- `lib/utils/processor.sh` - Template processing logic

## Testing

To run the complete test suite:

```bash
./final_tests.sh
```

This will run all 50 tests across 6 test modules and verify that all functionality is working correctly.

## Extending Functionality

### Adding New Commands
1. Create a new command implementation in `lib/commands/`
2. Add the command to the case statement in `bin/mark`
3. Add help text to `lib/commands/help.sh`

### Adding New Template Features
1. Modify the parser in `lib/utils/parser.sh`
2. Update the processor in `lib/utils/processor.sh`
3. Add tests to `final_tests.sh`
4. Document the feature in `docs/user_guide.md`