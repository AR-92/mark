# mark - AI Prompt Templating Tool

`mark` is a powerful Bash-based tool for generating AI/MCP-ready prompts from templates with support for placeholders, file substitution, conditional blocks, and loops.

## The Power of mark for AI Agents and Prompt Creation

`mark` transforms how AI agents and developers create, manage, and deploy prompts by providing a robust templating system that enables:

### 1. Dynamic Prompt Generation
Generate thousands of unique prompts from a single template by varying input parameters, making it ideal for:
- Bulk prompt creation for training datasets
- Automated prompt engineering workflows
- A/B testing different prompt variations
- Personalized AI interactions at scale

### 2. Modular Prompt Architecture
Build complex, reusable prompt components that can be combined and nested:
- Create prompt libraries for common tasks (code generation, content creation, analysis)
- Share standardized prompt templates across teams
- Maintain consistent prompt quality and structure
- Version control prompt templates like code

### 3. Context-Aware AI Agents
Enable AI agents to dynamically construct prompts based on:
- User context and preferences
- Historical interaction data
- Real-time environmental variables
- Complex business logic and conditions

### 4. Production-Ready Prompt Orchestration
Deploy AI systems that generate prompts on-demand with:
- Error handling and validation
- Audit trails and logging
- Performance optimization for large-scale deployments
- Integration with existing development workflows

## Novel Use Cases

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

### 4. Compliance-Aware Document Processor
```bash
# Generate prompts that include relevant regulations based on document type
./mark generate compliance_template.md document_context.md > compliance_prompt.txt
# AI ensures all outputs meet legal and regulatory requirements
```

### 5. Dynamic Research Assistant
```bash
# Create research prompts that adapt based on domain and complexity
./mark generate research_template.md study_parameters.md > research_prompt.txt
# AI researcher tailors methodology and focus areas automatically
```

### 6. Contextual Customer Support Bot
```bash
# Generate support prompts with customer history and product context
./mark generate support_template.md customer_context.md > support_prompt.txt
# Bot provides personalized solutions with full context awareness
```

### 7. Automated Testing Prompt Generator
```bash
# Create diverse test scenarios for AI model evaluation
./mark generate test_scenario_template.md test_parameters.md > test_prompts.txt
# Systematically evaluate AI performance across edge cases
```

### 8. Cross-Domain Knowledge Synthesizer
```bash
# Generate prompts that combine multiple domains of knowledge
./mark generate synthesis_template.md domain_contexts.md > synthesis_prompt.txt
# AI creates innovative solutions by connecting disparate fields
```

## Features

- **Placeholders**: `{{variable_name}}` for simple variable substitution
- **File Substitution**: `{{@file_path}}` to include content from other files
- **Conditional Blocks**: `{{#if condition}}...{{/if}}` for conditional content
- **Loop Blocks**: `{{#each array}}...{{/each}}` for iterating over lists
- **Data Files**: Simple key=value format for variable definitions
- **Environment Variables**: Automatic integration with system environment
- **Comprehensive Logging**: Full audit trail of all operations
- **CLI Interface**: Intuitive commands (`generate`, `list`, `clear`, `help`)

## AI Agent Integration

`mark` is specifically designed to empower AI agents and autonomous systems with dynamic prompt generation capabilities:

### For AI Developers
- **Programmatic Prompt Generation**: Integrate `mark` into AI agent workflows for on-demand prompt creation
- **Context-Aware Templates**: Build agents that generate prompts based on real-time data and user interactions
- **Scalable Prompt Management**: Handle thousands of prompt variations without manual intervention

### For Autonomous Systems
- **Self-Optimizing Prompts**: Create agents that refine their own prompts based on performance feedback
- **Multi-Modal Prompt Construction**: Combine text, code, and structured data into complex prompts
- **Adaptive Prompt Strategies**: Implement agents that adjust prompt complexity based on task difficulty

## Installation

### Quick Install
```bash
# Clone the repository
git clone https://github.com/AR-92/mark.git
cd mark

# Make the script executable
chmod +x mark

# Run the installation script
./install.sh
```

### Manual Installation
```bash
# Clone the repository
git clone https://github.com/AR-92/mark.git
cd mark

# Make the script executable
chmod +x mark

# Optionally, copy to a directory in your PATH
sudo cp mark /usr/local/bin/
```

## Usage

```bash
# Generate a prompt from a template
./mark generate template.md

# Generate a prompt with data file
./mark generate template.md data.md

# List recently generated prompts
./mark list

# Clear logs
./mark clear

# Show help
./mark help
```

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
├── tests/               # Test suite
│   └── final_tests.sh
├── examples/             # Example templates and data
│   ├── data/            # Example data files
│   ├── templates/       # Example templates
│   ├── tutorials/       # Comprehensive tutorials
│   └── README.md        # Examples documentation
├── docs/                # Documentation
├── conf/                # Configuration files
├── dist/                # Distribution packages
├── README.md            # Project documentation
├── LICENSE              # MIT License
├── CHANGELOG.md         # Version history
├── PROJECT_SUMMARY.md   # Project summary
└── .gitignore           # Git ignore file
```

See `examples/README.md` for detailed information about the example templates and tutorials.

## Template Syntax

### Basic Placeholders
```
Write a {{language}} program that {{task}}.
```

### File Inclusion
```
{{@requirements.md}}
```

### Conditional Blocks
```
{{#if active}}
Welcome back to {{platform}}!
{{/if}}
```

### Loop Blocks
```
{{#each requirements}}
- {{this}}
{{/each}}
```

## AI Agent Development with mark

### Dynamic Prompt Construction
AI agents can use `mark` to construct prompts dynamically based on:
- User context and preferences
- Historical interaction data
- Real-time environmental variables
- Complex business logic and conditions

### Example: Context-Aware Agent Template
```markdown
# {{task_domain}} Assistant

{{#if user_is_expert}}
You are an expert {{expertise_area}}. 
{{else}}
You are a helpful assistant explaining {{task_domain}} concepts.
{{/if}}

Current user context:
{{#each user_context}}
- {{this}}
{{/each}}

Task: {{task_description}}

{{#if has_constraints}}
Constraints:
{{#each constraints}}
- {{this}}
{{/each}}
{{/if}}

{{#if include_examples}}
Example approach:
```{{code_language}}
{{example_code}}
```
{{/if}}

Provide a comprehensive response that addresses all aspects of the task.
```

### Agent Integration Example
```python
import subprocess
import json

def generate_contextual_prompt(user_data, task_info):
    # Generate prompt using mark
    result = subprocess.run([
        './mark', 'generate', 
        'agent_template.md', 
        'context_data.md'
    ], capture_output=True, text=True)
    
    return result.stdout

# AI agent can now use dynamically generated prompts
prompt = generate_contextual_prompt(user_profile, current_task)
ai_response = send_to_llm(prompt)
```

## Examples

### Basic Example

#### Template (examples/templates/example_template.md)
```markdown
# {{task_type}} Implementation Guide

You are {{#if expert}}an expert {{/if}}{{role}} tasked with {{task}}.

## Requirements
{{#each requirements}}
- {{this}}
{{/each}}

## Constraints
{{#each constraints}}
- {{this}}
{{/each}}

{{#if example_needed}}
## Example
```{{language}}
{{example_code}}
```
{{/if}}

Please provide a complete, well-documented implementation that follows best practices.
```

#### Data File (examples/data/example_data.md)
```markdown
expert=true
role=Software Engineer
task=implementing a function that reverses a string without using built-in methods
language=Python
requirements_0=Handle edge cases (empty strings, single characters)
requirements_1=Optimize for time complexity
requirements_2=Include comprehensive error handling
constraints_0=Do not use built-in reverse functions
constraints_1=Maintain O(n) time complexity
example_needed=true
example_code=def reverse_string(s): return s[::-1]  # Simple slice reversal
```

#### Generated Output
```bash
./mark generate examples/templates/example_template.md examples/data/example_data.md
```

### Project Plan Example

#### Template (examples/templates/project_plan_template.md)
A comprehensive project plan template that demonstrates advanced features of mark.

#### Data File (examples/data/project_plan_data.md)
Sample data for a software development project plan.

#### Generated Output
```bash
./mark generate examples/templates/project_plan_template.md examples/data/project_plan_data.md
```

## Commands

### Generate
Generate a prompt from a template file:
```bash
./mark generate my_template.md
./mark generate my_template.md my_data.md
```

### List
Show recently generated prompts:
```bash
./mark list
```

### Clear
Clear all logs:
```bash
./mark clear
```

### Help
Show help information:
```bash
./mark help
```

## Advanced Features

### Indexed Arrays for Loops
For `{{#each array}}` blocks, define indexed items:
```
requirements_0=First requirement
requirements_1=Second requirement
requirements_2=Third requirement
```

### Conditional Logic
Use `{{#if variable}}` blocks with truthy evaluations:
- Non-empty strings are truthy
- "false" string is falsy
- Undefined variables are falsy

### File Substitution Paths
Reference files with relative or absolute paths:
```
{{@./path/to/file.md}}
{{@/absolute/path/to/file.md}}
```

### AI Agent Optimization Features

#### Dynamic Context Injection
AI agents can inject real-time context into templates:
```bash
# Agent dynamically generates context data
echo "user_mood=$MOOD" > dynamic_context.md
echo "time_of_day=$TIME" >> dynamic_context.md
./mark generate agent_template.md dynamic_context.md
```

#### Template Composition
Build complex prompts by combining multiple templates:
```markdown
{{@header_template.md}}

{{@task_specific_instructions.md}}

{{@user_context_block.md}}

{{@domain_expertise_template.md}}
```

#### Performance Optimization
For AI agents processing large volumes of prompts:
- Use indexed arrays for efficient loop processing
- Structure data files for minimal variable lookups
- Cache compiled templates for repeated use

## Configuration

The tool can be configured using the configuration file located at `conf/mark.conf`. This file contains the following options:

- `LOG_FILE` - Log file location (default: `~/.mark.log`)
- `TEMPLATE_DIR` - Template directory (default: `~/.mark/templates`)
- `TEMPLATE_EXT` - Default template extension (default: `.md`)
- `DATA_EXT` - Data file extension (default: `.md`)
- `MAX_RECURSION_DEPTH` - Maximum recursion depth for file inclusion (default: `10`)
- `DEBUG` - Enable debug mode (default: `false`)

To customize these settings, edit the `conf/mark.conf` file according to your needs.

## Tutorials

The tool includes comprehensive tutorials to help you master `mark` at all skill levels:

- **Beginner**: Basic template creation and variable substitution
- **Intermediate**: Conditional blocks, loop structures, and file inclusion
- **Advanced**: Template inheritance, dynamic selection, and performance optimization
- **Ninja**: Self-optimizing systems, AI agent orchestration, and cross-domain synthesis

Tutorials are located in the `examples/tutorials` directory, with each level containing detailed documentation, example templates, and data files.

You can run the tutorials using the provided script:

```bash
./run_tutorials.sh
```

## Testing

The tool includes a comprehensive test suite with 50+ tests:
```bash
./final_tests.sh
```

Current test status: 50/50 tests passing

## Contributing

Contributions are welcome! Please submit pull requests for bug fixes, enhancements, or new features.

## License

This project is licensed under the MIT License - see the LICENSE file for details.