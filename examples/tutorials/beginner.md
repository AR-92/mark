# mark Tutorial: From Beginner to Ninja

Welcome to the comprehensive tutorial for `mark`, the AI prompt templating tool. This tutorial will take you from a complete beginner to a prompt templating ninja!

## Table of Contents

1. [Beginner Level](#beginner-level)
   - [What is mark?](#what-is-mark)
   - [Installation](#installation)
   - [Basic Template Creation](#basic-template-creation)
   - [Simple Variable Substitution](#simple-variable-substitution)
   - [Your First Prompt Generation](#your-first-prompt-generation)

2. [Intermediate Level](#intermediate-level)
   - [Conditional Blocks](#conditional-blocks)
   - [Loop Blocks](#loop-blocks)
   - [File Inclusion](#file-inclusion)
   - [Working with Arrays](#working-with-arrays)

3. [Advanced Level](#advanced-level)
   - [Complex Template Structures](#complex-template-structures)
   - [Dynamic Context Injection](#dynamic-context-injection)
   - [Template Composition](#template-composition)
   - [Performance Optimization](#performance-optimization)

4. [Ninja Level](#ninja-level)
   - [AI Agent Integration](#ai-agent-integration)
   - [Dynamic Prompt Construction](#dynamic-prompt-construction)
   - [Cross-Domain Knowledge Synthesis](#cross-domain-knowledge-synthesis)
   - [Self-Optimizing Prompts](#self-optimizing-prompts)

---

## Beginner Level

### What is mark?

`mark` is a powerful Bash-based tool for generating AI/MCP-ready prompts from templates. It allows you to create dynamic, reusable prompt templates with support for:

- Placeholders for variable substitution
- File inclusion for modular templates
- Conditional blocks for context-aware prompts
- Loop blocks for handling lists and arrays

### Installation

To get started with `mark`, follow these simple steps:

```bash
# Clone the repository
git clone https://github.com/AR-92/mark.git
cd mark

# Make the script executable
chmod +x mark

# Run the installation script
./install.sh
```

Or for manual installation:

```bash
# Clone the repository
git clone https://github.com/AR-92/mark.git
cd mark

# Make the script executable
chmod +x mark

# Optionally, copy to a directory in your PATH
sudo cp mark /usr/local/bin/
```

### Basic Template Creation

Let's start by creating a simple template. Create a file called `simple_template.md`:

```markdown
# {{task_type}} Assistant

You are a {{role}} who needs to {{task_description}}.

Please provide a detailed solution.
```

This template uses basic placeholders (enclosed in double curly braces `{{}}`) that will be replaced with actual values when generating the prompt.

### Simple Variable Substitution

Now let's create a data file that provides values for our placeholders. Create `simple_data.md`:

```markdown
task_type=Code Review
role=Software Engineer
task_description=review this Python code for best practices and potential bugs
```

In `mark`, data files use a simple `key=value` format. Each line defines a variable that can be used in templates.

### Your First Prompt Generation

Now let's generate our first prompt:

```bash
./mark generate simple_template.md simple_data.md
```

This will output:

```markdown
# Code Review Assistant

You are a Software Engineer who needs to review this Python code for best practices and potential bugs.

Please provide a detailed solution.
```

Congratulations! You've just created your first dynamic prompt with `mark`.

---

## Intermediate Level

### Conditional Blocks

Conditional blocks allow you to include or exclude content based on variable values. Let's create a more sophisticated template in `conditional_template.md`:

```markdown
# {{task_type}} Assistant

{{#if expert_mode}}
You are an expert {{role}} with advanced knowledge.
{{else}}
You are a {{role}} who is learning.
{{/if}}

Task: {{task_description}}

{{#if has_examples}}
Here's an example to guide you:
{{example_content}}
{{/if}}

Please provide a detailed solution.
```

Create corresponding data in `conditional_data.md`:

```markdown
task_type=Code Optimization
role=Python Developer
expert_mode=true
task_description=optimize this function for better performance
has_examples=true
example_content=def fibonacci(n): return n if n <= 1 else fibonacci(n-1) + fibonacci(n-2)
```

Generate the prompt:

```bash
./mark generate conditional_template.md conditional_data.md
```

Output:

```markdown
# Code Optimization Assistant

You are an expert Python Developer with advanced knowledge.

Task: optimize this function for better performance

Here's an example to guide you:
def fibonacci(n): return n if n <= 1 else fibonacci(n-1) + fibonacci(n-2)

Please provide a detailed solution.
```

Notice how the conditional block with `expert_mode=true` included the expert text and the `has_examples=true` condition included the example content.

### Loop Blocks

Loop blocks allow you to iterate over lists of items. Create `loop_template.md`:

```markdown
# {{task_type}} Requirements

Role: {{role}}

Task: {{task_description}}

Requirements:
{{#each requirements}}
- {{this}}
{{/each}}

Constraints:
{{#each constraints}}
- {{this}}
{{/each}}

Please address all requirements and constraints in your solution.
```

Create data file `loop_data.md` using indexed arrays:

```markdown
task_type=API Development
role=Backend Developer
task_description=create a REST API for a todo application
requirements_0=Implement CRUD operations for todos
requirements_1=Use JWT for authentication
requirements_2=Include input validation
constraints_0=Must be implemented in Node.js
constraints_1=Database should be MongoDB
```

In `mark`, arrays are defined using the pattern `array_name_index=value`. Generate the prompt:

```bash
./mark generate loop_template.md loop_data.md
```

Output:

```markdown
# API Development Requirements

Role: Backend Developer

Task: create a REST API for a todo application

Requirements:
- Implement CRUD operations for todos
- Use JWT for authentication
- Include input validation

Constraints:
- Must be implemented in Node.js
- Database should be MongoDB

Please address all requirements and constraints in your solution.
```

### File Inclusion

File inclusion allows you to modularize your templates by including content from other files. Create `header.md`:

```markdown
# {{project_name}} - {{task_type}}

This is a {{complexity_level}} task for the {{project_name}} project.
```

Create `body.md`:

```markdown
## Task Description

{{task_description}}

## Requirements

{{#each requirements}}
- {{this}}
{{/each}}
```

Now create a main template `modular_template.md` that includes these files:

```markdown
{{@header.md}}

{{@body.md}}

## Constraints

{{#each constraints}}
- {{this}}
{{/each}}

Please complete this task following all requirements and constraints.
```

Create data file `modular_data.md`:

```markdown
project_name=Todo API
task_type=Backend Implementation
complexity_level=Intermediate
task_description=Implement a complete REST API for a todo application with user authentication
requirements_0=CRUD operations for todos
requirements_1=JWT-based authentication
requirements_2=Input validation and error handling
constraints_0=Use Node.js and Express
constraints_1=Use MongoDB for data storage
```

Generate the prompt:

```bash
./mark generate modular_template.md modular_data.md
```

This will include the content from `header.md` and `body.md`, replacing their placeholders with values from `modular_data.md`.

### Working with Arrays

Arrays in `mark` are handled through indexed variables. Let's look at a more complex example in `array_template.md`:

```markdown
# {{task_type}} Implementation Guide

Role: {{role}}

## Overview

{{overview}}

## Steps to Complete

{{#each steps}}
{{@index}}. {{this}}
{{/each}}

## Prerequisites

{{#each prerequisites}}
- {{this}}
{{/each}}

## Expected Deliverables

{{#each deliverables}}
- {{this}}
{{/each}}
```

Create data file `array_data.md`:

```markdown
task_type=Web Scraper Development
role=Python Developer
overview=Create a web scraper that extracts product information from e-commerce websites
steps_0=Set up the project structure
steps_1=Install required dependencies (requests, beautifulsoup4)
steps_2=Implement the scraping logic
steps_3=Add error handling and retries
steps_4=Implement data storage
prerequisites_0=Python 3.8+
prerequisites_1=Basic understanding of HTML
prerequisites_2=Familiarity with CSS selectors
deliverables_0=Working scraper script
deliverables_1=Documentation on usage
deliverables_2=Sample output data
```

Generate the prompt:

```bash
./mark generate array_template.md array_data.md
```

Output:

```markdown
# Web Scraper Development Implementation Guide

Role: Python Developer

## Overview

Create a web scraper that extracts product information from e-commerce websites

## Steps to Complete

0. Set up the project structure
1. Install required dependencies (requests, beautifulsoup4)
2. Implement the scraping logic
3. Add error handling and retries
4. Implement data storage

## Prerequisites

- Python 3.8+
- Basic understanding of HTML
- Familiarity with CSS selectors

## Expected Deliverables

- Working scraper script
- Documentation on usage
- Sample output data
```

Notice how `{{@index}}` provides the current index in the loop.

---

## Advanced Level

### Complex Template Structures

Let's create a complex template that combines all the features we've learned. Create `complex_template.md`:

```markdown
{{@header.md}}

## Project Context

{{#if is_enterprise}}
This is an enterprise-grade project with strict security requirements.
{{else}}
This is a standard project with typical requirements.
{{/if}}

{{#if has_dependencies}}
## Dependencies

This project requires the following dependencies:
{{#each dependencies}}
- {{this}}
{{/each}}
{{/if}}

## Task Description

{{task_description}}

## Implementation Requirements

{{#each requirements}}
### {{@index}}. {{this.title}}

{{this.description}}

{{#if this.has_code_example}}
Example:
```{{this.example_language}}
{{this.code_example}}
```
{{/if}}

{{/each}}

## Constraints and Limitations

{{#each constraints}}
- {{this}}
{{/each}}

## Success Criteria

{{#each success_criteria}}
- {{this}}
{{/each}}

Please provide a complete implementation that addresses all requirements.
```

Create data file `complex_data.md`:

```markdown
project_name=Financial Data Analysis System
task_type=Data Processing Pipeline
is_enterprise=true
has_dependencies=true
dependencies_0=Python 3.9+
dependencies_1=Pandas
dependencies_2=NumPy
dependencies_3=Apache Kafka
task_description=Create a data processing pipeline that ingests financial data from multiple sources, processes it, and stores it in a data warehouse
requirements_0.title=Data Ingestion
requirements_0.description=Implement connectors for various data sources including CSV files, JSON APIs, and database exports
requirements_0.has_code_example=true
requirements_0.example_language=python
requirements_0.code_example=import pandas as pd\
df = pd.read_csv('data.csv')
requirements_1.title=Data Transformation
requirements_1.description=Clean and transform the data according to business rules, including handling missing values and data type conversions
requirements_1.has_code_example=true
requirements_1.example_language=python
requirements_1.code_example=df['column'] = df['column'].fillna(0)
requirements_2.title=Data Validation
requirements_2.description=Implement validation rules to ensure data quality and consistency
requirements_2.has_code_example=false
constraints_0=All data must be encrypted at rest
constraints_1=Processing must complete within 10 minutes
constraints_2=System must handle at least 10,000 records per minute
success_criteria_0=Pipeline processes data from all sources correctly
success_criteria_1=Data quality metrics meet defined thresholds
success_criteria_2=Performance benchmarks are achieved
```

Also update `header.md` to work with this template:

```markdown
# {{project_name}} - {{task_type}}

{{#if is_enterprise}}
**ENTERPRISE PROJECT**
{{/if}}
```

Generate the prompt:

```bash
./mark generate complex_template.md complex_data.md
```

This will produce a comprehensive, multi-section prompt that demonstrates all of `mark`'s features.

### Dynamic Context Injection

AI agents can dynamically inject context into templates. Let's see how this works with environment variables.

Create `dynamic_template.md`:

```markdown
# {{task_domain}} Assistant

Current time: {{current_time}}
User mood: {{user_mood}}
Task priority: {{task_priority}}

{{#if is_urgent}}
**URGENT TASK**
{{/if}}

Task: {{task_description}}

{{#if user_is_expert}}
As an expert in this domain, please provide an advanced solution.
{{else}}
Please provide a solution that is easy to understand and implement.
{{/if}}

{{#each context_info}}
- {{this}}
{{/each}}
```

You can inject dynamic context through environment variables:

```bash
export current_time=$(date)
export user_mood=\"focused\"
export task_priority=\"high\"
export is_urgent=true
export user_is_expert=true

./mark generate dynamic_template.md
```

Create data file `dynamic_data.md`:

```markdown
task_domain=System Administration
task_description=Debug a production server that is experiencing high CPU usage
context_info_0=Server is running Ubuntu 20.04
context_info_1=Application is a Node.js web server
context_info_2=Issue started 2 hours ago
```

Generate the prompt:

```bash
./mark generate dynamic_template.md dynamic_data.md
```

### Template Composition

Build complex prompts by combining multiple templates. Create `composition_template.md`:

```markdown
{{@introduction_template.md}}

{{@requirements_template.md}}

{{@constraints_template.md}}

{{@instructions_template.md}}
```

Create `introduction_template.md`:

```markdown
# {{project_name}} - {{task_type}}

{{#if project_status}}
Status: {{project_status}}
{{/if}}

{{introduction_text}}
```

Create `requirements_template.md`:

```markdown
## Requirements

{{#each requirements}}
- {{this}}
{{/each}}

{{#if has_technical_requirements}}
### Technical Requirements

{{#each technical_requirements}}
- {{this}}
{{/each}}
{{/if}}
```

Create `constraints_template.md`:

```markdown
## Constraints

{{#each constraints}}
- {{this}}
{{/each}}
```

Create `instructions_template.md`:

```markdown
## Instructions

{{#each instructions}}
{{@index}}. {{this}}
{{/each}}

{{#if deliverables}}
## Deliverables

{{#each deliverables}}
- {{this}}
{{/each}}
{{/if}}
```

Create data file `composition_data.md`:

```markdown
project_name=Customer Analytics Dashboard
task_type=Data Visualization
project_status=In Development
introduction_text=Create an interactive dashboard to visualize customer behavior data
requirements_0=Display customer demographics
requirements_1=Show purchase history trends
requirements_2=Include real-time metrics
has_technical_requirements=true
technical_requirements_0=Use React for frontend
technical_requirements_1=Use D3.js for visualizations
technical_requirements_2=Backend API in Python Flask
constraints_0=Must load within 3 seconds
constraints_1=Support 1000 concurrent users
instructions_0=Set up the development environment
instructions_1=Create the data models
instructions_2=Implement the API endpoints
instructions_3=Build the frontend components
instructions_4=Integrate frontend with backend
deliverables_0=Working dashboard application
deliverables_1=API documentation
deliverables_2=User guide
```

Generate the prompt:

```bash
./mark generate composition_template.md composition_data.md
```

### Performance Optimization

For AI agents processing large volumes of prompts, here are some optimization tips:

1. Use indexed arrays for efficient loop processing
2. Structure data files for minimal variable lookups
3. Cache compiled templates for repeated use

Create an optimized template `optimized_template.md`:

```markdown
# {{task_category}} - {{task_id}}

## Context
Project: {{project_name}}
Module: {{module_name}}
Priority: {{priority_level}}

## Task
{{task_description}}

## Implementation Steps
{{#each steps}}
{{@index}}. {{this}}
{{/each}}

## Acceptance Criteria
{{#each criteria}}
- {{this}}
{{/each}}
```

Create optimized data `optimized_data.md`:

```markdown
task_category=Bug Fix
task_id=BUG-2023-001
project_name=E-commerce Platform
module_name=Payment Processing
priority_level=High
task_description=Fix credit card validation error that occurs when using AMEX cards
steps_0=Reproduce the issue in development environment
steps_1=Identify the root cause in the validation logic
steps_2=Implement the fix
steps_3=Test with various card types
steps_4=Deploy to staging for QA verification
criteria_0=AMEX cards process successfully
criteria_1=Other card types still work
criteria_2=No regression in existing functionality
```

Generate the prompt:

```bash
./mark generate optimized_template.md optimized_data.md
```

---

## Ninja Level

### AI Agent Integration

AI agents can use `mark` to construct prompts dynamically. Here's a Python example:

```python
import subprocess
import json
import os

def generate_contextual_prompt(template_file, context_data):
    \"\"\"
    Generate a contextual prompt using mark
    \"\"\"
    # Write context data to a temporary file
    with open('temp_context.md', 'w') as f:
        for key, value in context_data.items():
            if isinstance(value, list):
                # Handle arrays
                for i, item in enumerate(value):
                    f.write(f\"{key}_{i}={item}\
\")
            else:
                f.write(f\"{key}={value}\
\")
    
    # Generate prompt using mark
    result = subprocess.run([
        './mark', 'generate', 
        template_file, 
        'temp_context.md'
    ], capture_output=True, text=True)
    
    # Clean up temporary file
    os.remove('temp_context.md')
    
    if result.returncode == 0:
        return result.stdout
    else:
        raise Exception(f\"mark error: {result.stderr}\")

# Example usage
context = {
    \"task_domain\": \"Code Review\",
    \"programming_language\": \"Python\",
    \"experience_level\": \"Intermediate\",
    \"focus_areas\": [
        \"Performance optimization\",
        \"Security vulnerabilities\",
        \"Code readability\"
    ],
    \"task_description\": \"Review this Django application for best practices\"
}

prompt = generate_contextual_prompt('agent_template.md', context)
print(prompt)
```

Create `agent_template.md`:

```markdown
# {{task_domain}} Assistant

Programming Language: {{programming_language}}
Experience Level: {{experience_level}}

Focus Areas:
{{#each focus_areas}}
- {{this}}
{{/each}}

Task: {{task_description}}

Please provide a comprehensive analysis addressing all focus areas.
```

### Dynamic Prompt Construction

Create a dynamic prompt construction system. Create `dynamic_agent_template.md`:

```markdown
# {{task_type}} AI Assistant

{{#if user_profile.expertise}}
Expertise: {{user_profile.expertise}}
{{/if}}

{{#if user_profile.experience}}
Experience Level: {{user_profile.experience}}
{{/if}}

Current Context:
{{#each context}}
- {{this}}
{{/each}}

Task Objective: {{task_objective}}

{{#if task_constraints}}
Constraints:
{{#each task_constraints}}
- {{this}}
{{/each}}
{{/if}}

{{#if examples_available}}
Example Format:
{{task_example}}
{{/if}}

Instructions:
1. Analyze the task objective in the context of the provided information
2. {{#if user_profile.expertise}}Apply your expertise in {{user_profile.expertise}} to{{else}}Carefully{{/if}} address all aspects of the task
3. {{#if task_constraints}}Ensure all constraints are met{{/if}}
4. {{#if examples_available}}Follow the example format provided{{/if}}
5. Provide a comprehensive and well-structured response
```

Create data file `dynamic_agent_data.md`:

```markdown
task_type=Data Analysis
user_profile.expertise=Statistical Modeling
user_profile.experience=Advanced
context_0=Dataset contains 10,000 customer records
context_1=Data spans 5 years of customer behavior
context_2=Objective is to identify purchasing patterns
task_objective=Analyze customer purchasing patterns and create a predictive model
task_constraints_0=Results must be interpretable by non-technical stakeholders
task_constraints_1=Model must be deployed in a production environment
examples_available=true
task_example=Customer segment A shows 30% higher purchase frequency in Q4
```

Generate the prompt:

```bash
./mark generate dynamic_agent_template.md dynamic_agent_data.md
```

### Cross-Domain Knowledge Synthesis

Create templates that combine knowledge from multiple domains. Create `synthesis_template.md`:

```markdown
# Cross-Domain Solution Architect

## Domains to Integrate
{{#each domains}}
- {{this.name}}: {{this.description}}
{{/each}}

## Challenge
{{challenge_statement}}

## Requirements for Solution
{{#each requirements}}
### {{@index}}. {{this.domain}} Perspective

{{this.description}}
{{/each}}

## Constraints
{{#each constraints}}
- {{this}}
{{/each}}

## Expected Output Structure
{{#each output_sections}}
{{@index}}. {{this}}
{{/each}}

Please synthesize knowledge from all domains to create an innovative solution that addresses all requirements while respecting all constraints.
```

Create data file `synthesis_data.md`:

```markdown
challenge_statement=Design a system that can predict equipment failures in manufacturing plants using environmental data
domains_0.name=Manufacturing Engineering
domains_0.description=Knowledge of industrial equipment and failure modes
domains_1.name=Environmental Science
domains_1.description=Understanding of environmental factors affecting equipment
domains_2.name=Machine Learning
domains_2.description=Predictive modeling techniques
domains_3.name=IoT Systems
domains_3.description=Sensor networks and data collection
requirements_0.domain=Manufacturing Engineering
requirements_0.description=Identify critical failure points and their typical precursors
requirements_1.domain=Environmental Science
requirements_1.description=Map environmental factors to equipment stress patterns
requirements_2.domain=Machine Learning
requirements_2.description=Design predictive models with high accuracy and low false positives
requirements_3.domain=IoT Systems
requirements_3.description=Specify sensor requirements and data collection frequencies
constraints_0=Budget limitations require cost-effective sensor solutions
constraints_1=System must work with existing plant infrastructure
constraints_2=Predictions must be delivered in real-time to plant operators
output_sections_0=Executive Summary
output_sections_1=Technical Architecture
output_sections_2=Environmental Factor Analysis
output_sections_3=Failure Mode Predictions
output_sections_4=Implementation Roadmap
output_sections_5=Cost-Benefit Analysis
```

Generate the prompt:

```bash
./mark generate synthesis_template.md synthesis_data.md
```

### Self-Optimizing Prompts

Create a system where AI agents can refine their own prompts based on performance feedback. Create `self_optimizing_template.md`:

```markdown
# {{task_category}} {{task_id}} - Iteration {{iteration_number}}

## Performance Feedback from Previous Iteration
{{#if feedback.has_feedback}}
Score: {{feedback.score}}/100
{{#if feedback.strengths}}
Strengths:
{{#each feedback.strengths}}
- {{this}}
{{/each}}
{{/if}}

{{#if feedback.weaknesses}}
Areas for Improvement:
{{#each feedback.weaknesses}}
- {{this}}
{{/each}}
{{/if}}

{{#if feedback.suggestions}}
Suggestions:
{{#each feedback.suggestions}}
- {{this}}
{{/each}}
{{/if}}
{{else}}
This is the first iteration. No performance feedback available.
{{/if}}

## Task Definition
{{task_description}}

## Optimization Strategy
{{#if feedback.has_feedback}}
Based on the feedback, this iteration will focus on:
{{#each optimization_focus}}
- {{this}}
{{/each}}
{{else}}
Initial approach:
{{#each initial_approach}}
- {{this}}
{{/each}}
{{/if}}

## Constraints
{{#each constraints}}
- {{this}}
{{/each}}

## Evaluation Criteria
{{#each evaluation_criteria}}
- {{this}}
{{/each}}

Please provide a solution that addresses the task while incorporating the optimization strategy.
```

Create data file `self_optimizing_data.md`:

```markdown
task_category=Code Generation
task_id=TG-2023-042
iteration_number=3
feedback.has_feedback=true
feedback.score=75
feedback.strengths_0=Correct implementation of core functionality
feedback.strengths_1=Good code structure and organization
feedback.weaknesses_0=Lack of error handling
feedback.weaknesses_1=Missing input validation
feedback.suggestions_0=Add comprehensive error handling
feedback.suggestions_1=Implement input validation for all user inputs
task_description=Create a Python function that converts temperature between Celsius, Fahrenheit, and Kelvin
optimization_focus_0=Implement comprehensive error handling for invalid inputs
optimization_focus_1=Add input validation for temperature values
optimization_focus_2=Include unit tests for edge cases
constraints_0=Function must handle negative temperatures
constraints_1=Function must return appropriate error messages for invalid inputs
evaluation_criteria_0=Correctness of temperature conversions
evaluation_criteria_1=Robustness of error handling
evaluation_criteria_2=Code quality and documentation
```

Generate the prompt:

```bash
./mark generate self_optimizing_template.md self_optimizing_data.md
```

---

## Conclusion

You've now completed the journey from beginner to ninja with `mark`! You've learned:

1. **Beginner**: Basic template creation and variable substitution
2. **Intermediate**: Conditional blocks, loop blocks, and file inclusion
3. **Advanced**: Complex template structures and performance optimization
4. **Ninja**: AI agent integration, dynamic prompt construction, and self-optimizing systems

With these skills, you can create powerful, dynamic prompt systems for AI agents and applications. The key is to start simple and gradually build complexity as needed.

Happy templating!
