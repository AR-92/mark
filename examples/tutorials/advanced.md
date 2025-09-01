# mark Advanced Tutorial

This tutorial explores advanced features and techniques for using `mark` to create sophisticated prompt engineering workflows and AI agent integrations.

## Table of Contents

1. [Template Inheritance and Composition](#template-inheritance-and-composition)
2. [Dynamic Template Selection](#dynamic-template-selection)
3. [Advanced Data Processing](#advanced-data-processing)
4. [Performance Optimization Techniques](#performance-optimization-techniques)
5. [Error Handling and Debugging](#error-handling-and-debugging)
6. [Integration with External Systems](#integration-with-external-systems)

## Template Inheritance and Composition

### Template Inheritance Pattern

Create a base template `base_template.md`:

```markdown
# {{project_name}} - {{document_type}}

{{#if document_version}}
Version: {{document_version}}
{{/if}}

{{#if last_updated}}
Last Updated: {{last_updated}}
{{/if}}

{{#if confidentiality}}
**{{confidentiality}}**
{{/if}}

## Overview

{{overview}}

## Main Content

{{@content_block}}

## Conclusion

{{conclusion}}

---
{{#if authors}}
Authors: {{#each authors}}{{this}}{{#if @last}}{{else}}, {{/if}}{{/each}}
{{/if}}
{{#if contact_info}}
Contact: {{contact_info}}
{{/if}}
```

Create a specialized template `technical_spec_template.md`:

```markdown
{{#if template_inheritance}}
{{@base_template.md}}
{{else}}
# {{project_name}} - Technical Specification

Version: {{document_version}}
Last Updated: {{last_updated}}

## Overview

{{overview}}

## Technical Requirements

{{@content_block}}

## Implementation Timeline

{{implementation_timeline}}

## Conclusion

{{conclusion}}
{{/if}}
```

Create content block `tech_spec_content.md`:

```markdown
### System Architecture

{{#each architecture_components}}
- {{this.name}}: {{this.description}}
{{/each}}

### Technology Stack

{{#each technologies}}
- {{this.category}}: {{this.name}} ({{this.version}})
{{/each}}

### Integration Points

{{#each integrations}}
- {{this.system}}: {{this.description}}
{{/each}}
```

Create data file `tech_spec_data.md`:

```markdown
template_inheritance=true
project_name=Customer Data Platform
document_type=Technical Specification
document_version=1.2
last_updated=2023-07-15
confidentiality=CONFIDENTIAL - Internal Use Only
overview=This document outlines the technical specifications for the Customer Data Platform project, which aims to unify customer data from multiple sources into a single, comprehensive profile.
content_block=@tech_spec_content.md
authors_0=Jane Smith
authors_1=John Doe
contact_info=tech-lead@company.com
architecture_components_0.name=Data Ingestion Layer
architecture_components_0.description=Responsible for collecting data from various sources
architecture_components_1.name=Processing Engine
architecture_components_1.description=Transforms and enriches incoming data
architecture_components_2.name=Storage Layer
architecture_components_2.description=Stores unified customer profiles
technologies_0.category=Framework
technologies_0.name=Node.js
technologies_0.version=18.x
technologies_1.category=Database
technologies_1.name=MongoDB
technologies_1.version=5.0
technologies_2.category=Message Queue
technologies_2.name=Apache Kafka
technologies_2.version=3.0
integrations_0.system=CRM System
integrations_0.description=Sync customer data with Salesforce
integrations_1.system=Marketing Platform
integrations_1.description=Send behavioral data to Marketo
implementation_timeline=Phase 1: Data Ingestion (Q1 2024)\nPhase 2: Processing Engine (Q2 2024)\nPhase 3: Storage and API (Q3 2024)
conclusion=This technical specification provides a comprehensive overview of the Customer Data Platform. The implementation will be carried out in three phases over the course of 2024.
```

Generate the prompt:

```bash
./mark generate technical_spec_template.md tech_spec_data.md
```

### Template Composition with Overrides

Create a base template `report_base.md`:

```markdown
# {{report_title}}

{{#if report_subtitle}}
## {{report_subtitle}}
{{/if}}

{{#if report_date}}
Date: {{report_date}}
{{/if}}

{{#if report_author}}
Author: {{report_author}}
{{/if}}

## Executive Summary

{{executive_summary}}

## Main Sections

{{@section_content}}

## Conclusion

{{conclusion}}

{{#if appendices}}
## Appendices

{{@appendices}}
{{/if}}
```

Create specialized section templates:

`financial_analysis.md`:
```markdown
### Financial Performance

{{#each financial_metrics}}
- {{this.name}}: {{this.value}}{{#if this.unit}} {{this.unit}}{{/if}}
{{/each}}

### Key Insights

{{#each insights}}
- {{this}}
{{/each}}
```

`market_analysis.md`:
```markdown
### Market Position

{{market_position}}

### Competitive Landscape

{{#each competitors}}
- {{this.name}}: {{this.market_share}} market share
{{/each}}
```

Create main template `quarterly_report.md`:

```markdown
{{@report_base.md}}
```

Create data file `quarterly_report_data.md`:

```markdown
report_title=Q2 2023 Financial Report
report_subtitle=Company Performance Analysis
report_date=July 15, 2023
report_author=Finance Team
executive_summary=Q2 2023 showed strong financial performance with 15% revenue growth and improved profit margins. Key initiatives in product development and market expansion contributed to these results.
section_content=@financial_analysis.md
conclusion=The company is well-positioned for continued growth in the second half of 2023. We recommend maintaining current investment levels in R&D and marketing.
appendices=@market_analysis.md
financial_metrics_0.name=Revenue
financial_metrics_0.value=2500000
financial_metrics_0.unit=USD
financial_metrics_1.name=Profit Margin
financial_metrics_1.value=18.5
financial_metrics_1.unit=%
financial_metrics_2.name=Operating Expenses
financial_metrics_2.value=1200000
financial_metrics_2.unit=USD
insights_0=Revenue growth exceeded projections by 3%
insights_1=Cost optimization initiatives saved $150K
insights_2=New product line contributed 12% of total revenue
market_position=Leading provider in the regional market with 25% market share
competitors_0.name=TechCorp
competitors_0.market_share=18%
competitors_1.name=Innovate Inc
competitors_1.market_share=15%
```

Generate the prompt:

```bash
./mark generate quarterly_report.md quarterly_report_data.md
```

## Dynamic Template Selection

### Context-Aware Template Selection

Create a script `dynamic_template_selector.sh`:

```bash
#!/bin/bash

# Function to select template based on context
select_template() {
    local task_type=$1
    local complexity=$2
    local expertise=$3
    
    case $task_type in
        "code_review")
            if [[ "$complexity" == "high" ]]; then
                echo "complex_code_review_template.md"
            else
                echo "simple_code_review_template.md"
            fi
            ;;
        "documentation")
            if [[ "$expertise" == "expert" ]]; then
                echo "expert_documentation_template.md"
            else
                echo "beginner_documentation_template.md"
            fi
            ;;
        "testing")
            echo "testing_template.md"
            ;;
        *)
            echo "default_template.md"
            ;;
    esac
}

# Example usage
TASK_TYPE="code_review"
COMPLEXITY="high"
EXPERTISE="intermediate"

SELECTED_TEMPLATE=$(select_template "$TASK_TYPE" "$COMPLEXITY" "$EXPERTISE")
echo "Selected template: $SELECTED_TEMPLATE"

# Generate prompt with selected template
./mark generate "$SELECTED_TEMPLATE" context_data.md
```

Create template files:

`simple_code_review_template.md`:
```markdown
# Code Review for {{component_name}}

Developer: {{developer_name}}

## Summary

{{review_summary}}

## Findings

{{#each findings}}
- {{this.severity}}: {{this.description}}
{{/each}}

## Recommendations

{{#each recommendations}}
- {{this}}
{{/each}}
```

`complex_code_review_template.md`:
```markdown
# Complex Code Review for {{component_name}}

Developer: {{developer_name}}
Review Date: {{review_date}}

## Executive Summary

{{executive_summary}}

## Detailed Analysis

{{#each components}}
### {{this.name}}

{{#if this.description}}
Description: {{this.description}}
{{/if}}

Findings:
{{#each this.findings}}
- {{@index}}. {{this.severity}}: {{this.description}}
{{#if this.code_example}}
```{{this.language}}
{{this.code_example}}
```
{{/if}}
{{#if this.suggested_fix}}
**Suggested Fix:**
```{{this.language}}
{{this.suggested_fix}}
```
{{/if}}
{{/each}}

{{/each}}

## Overall Assessment

{{overall_assessment}}

## Priority Actions

{{#each priority_actions}}
{{@index}}. {{this}}
{{/each}}
```

Create data file `context_data.md`:

```markdown
component_name=Authentication Module
developer_name=Alice Johnson
review_date=2023-07-15
executive_summary=The authentication module implements OAuth 2.0 with JWT tokens. Overall code quality is good, but several security and performance improvements are recommended.
components_0.name=Token Generation
components_0.description=Handles JWT token creation and signing
components_0.findings_0.severity=HIGH
components_0.findings_0.description=Token expiration time is hardcoded and not configurable
components_0.findings_0.language=javascript
components_0.findings_0.code_example=const token = jwt.sign(payload, secret, { expiresIn: '1h' });
components_0.findings_0.suggested_fix=const token = jwt.sign(payload, secret, { expiresIn: process.env.TOKEN_EXPIRY || '1h' });
components_0.findings_1.severity=MEDIUM
components_0.findings_1.description=Secret key is stored in source code
components_1.name=Token Validation
components_1.description=Validates JWT tokens on incoming requests
components_1.findings_0.severity=LOW
components_1.findings_0.description=Missing unit tests for edge cases
overall_assessment=The authentication module is functionally correct but needs improvements in security practices and configurability. No critical vulnerabilities were found.
priority_actions_0=Move secret keys to environment variables
priority_actions_1=Make token expiration configurable
priority_actions_2=Add comprehensive unit tests
```

Run the dynamic selector:

```bash
chmod +x dynamic_template_selector.sh
./dynamic_template_selector.sh
```

## Advanced Data Processing

### Preprocessing Data with Scripts

Create a data preprocessing script `preprocess_data.sh`:

```bash
#!/bin/bash

# Function to convert JSON to mark data format
json_to_mark() {
    local json_file=$1
    local output_file=$2
    
    # Use jq to parse JSON and convert to key=value format
    jq -r '
        def to_mark($prefix):
            if type == "object" then
                to_entries[] | 
                if .value | type == "array" then
                    .value | to_entries[] | 
                    (.key | tostring) as $index | 
                    .value | to_mark("\($prefix)\(.key)_\($index)")
                elif .value | type == "object" then
                    .value | to_mark("\($prefix)\(.key).")
                else
                    "\($prefix)\(.key)=\(.value)"
                end
            else
                "\($prefix)=\(.))"
            end;
        to_mark("")
    ' "$json_file" > "$output_file"
}

# Example usage
echo '{
    "project": {
        "name": "Data Pipeline",
        "version": "1.0.0",
        "components": [
            {
                "name": "Data Ingestion",
                "type": "Service"
            },
            {
                "name": "Data Processing",
                "type": "Service"
            }
        ]
    }
}' > sample.json

json_to_mark sample.json processed_data.md

echo "Processed data:"
cat processed_data.md
```

Create a template `json_data_template.md`:

```markdown
# {{project.name}} - Version {{project.version}}

## Components

{{#each project.components}}
### {{this.name}}

Type: {{this.type}}

{{/each}}

Please review this project structure.
```

Run the preprocessing:

```bash
chmod +x preprocess_data.sh
./preprocess_data.sh
./mark generate json_data_template.md processed_data.md
```

### Data Transformation with mark

Create a data transformation template `transform_template.md`:

```markdown
# Data Transformation Report

Source Format: {{source_format}}
Target Format: {{target_format}}
Records Processed: {{record_count}}

## Transformation Rules Applied

{{#each transformation_rules}}
- {{this.name}}: {{this.description}}
{{/each}}

## Results

{{#if success}}
### Success
Successfully transformed {{success_count}} records.
{{#if warnings}}
#### Warnings
{{#each warnings}}
- {{this}}
{{/each}}
{{/if}}
{{else}}
### Failure
Transformation failed with {{error_count}} errors.
{{#each errors}}
- {{this}}
{{/each}}
{{/if}}

## Output Sample

{{#each output_sample}}
{{@index}}. {{this}}
{{/each}}

## Next Steps

{{#each next_steps}}
- {{this}}
{{/each}}
```

Create data file `transform_data.md`:

```markdown
source_format=CSV
target_format=JSON
record_count=10000
transformation_rules_0.name=Field Mapping
transformation_rules_0.description=Map CSV columns to JSON fields
transformation_rules_1.name=Data Type Conversion
transformation_rules_1.description=Convert string dates to ISO format
transformation_rules_2.name=Validation
transformation_rules_2.description=Validate email format and phone numbers
success=true
success_count=9987
warnings_0=13 records had missing optional fields
warnings_1=5 records had non-standard date formats
output_sample_0={"id": "123", "name": "John Doe", "email": "john@example.com", "created": "2023-01-15T10:30:00Z"}
output_sample_1={"id": "124", "name": "Jane Smith", "email": "jane@example.com", "created": "2023-01-15T11:45:00Z"}
next_steps_0=Load transformed data into target database
next_steps_1=Generate transformation report
next_steps_2=Archive source files
```

Generate the prompt:

```bash
./mark generate transform_template.md transform_data.md
```

## Performance Optimization Techniques

### Template Caching Strategy

Create a caching script `template_cache.sh`:

```bash
#!/bin/bash

# Simple template caching mechanism
CACHE_DIR="./.mark_cache"
mkdir -p "$CACHE_DIR"

# Function to cache template compilation
cache_template() {
    local template_file=$1
    local cache_key=$(echo "$template_file" | md5sum | cut -d' ' -f1)
    local cache_file="$CACHE_DIR/$cache_key.cache"
    
    # Check if cache exists and is newer than template
    if [[ -f "$cache_file" ]] && [[ "$cache_file" -nt "$template_file" ]]; then
        echo "Using cached version of $template_file"
        cat "$cache_file"
        return 0
    fi
    
    # Compile template and cache it
    echo "Compiling and caching $template_file"
    # In a real implementation, this would compile the template
    # For this example, we'll just copy it
    cp "$template_file" "$cache_file"
    cat "$template_file"
}

# Function to clear cache
clear_cache() {
    rm -rf "$CACHE_DIR"
    mkdir -p "$CACHE_DIR"
    echo "Template cache cleared"
}

# Example usage
TEMPLATE="performance_template.md"
cache_template "$TEMPLATE"

# To clear cache
# clear_cache
```

Create a performance-focused template `performance_template.md`:

```markdown
# {{task_category}} Performance Analysis

Task ID: {{task_id}}
Analysis Date: {{analysis_date}}

## Performance Metrics

{{#each metrics}}
### {{this.name}}

Value: {{this.value}}{{#if this.unit}} {{this.unit}}{{/if}}
Target: {{this.target}}{{#if this.unit}} {{this.unit}}{{/if}}
Status: {{#if this.achieved}}✓ Achieved{{else}}✗ Not Achieved{{/if}}

{{#if this.trend}}
Trend: {{this.trend}}
{{/if}}

{{/each}}

## Bottlenecks Identified

{{#each bottlenecks}}
- {{this.component}}: {{this.description}} (Impact: {{this.impact}})
{{/each}}

## Optimization Recommendations

{{#each recommendations}}
### {{@index}}. {{this.category}}

Estimated Improvement: {{this.improvement}}%
Implementation Effort: {{this.effort}}

{{this.description}}

{{/each}}

## Implementation Priority

{{#each priority_items}}
{{@index}}. {{this.task}} (Priority: {{this.priority}})
{{/each}}

Please review these performance findings and recommendations.
```

Create data file `performance_data.md`:

```markdown
task_category=API Response Time
task_id=PERF-2023-001
analysis_date=2023-07-15
metrics_0.name=Average Response Time
metrics_0.value=420
metrics_0.unit=ms
metrics_0.target=300
metrics_0.achieved=false
metrics_0.trend=+5% from last month
metrics_1.name=95th Percentile
metrics_1.value=850
metrics_1.unit=ms
metrics_1.target=600
metrics_1.achieved=false
metrics_2.name=Error Rate
metrics_2.value=0.2
metrics_2.unit=%
metrics_2.target=0.1
metrics_2.achieved=false
bottlenecks_0.component=Database Queries
bottlenecks_0.description=Inefficient JOIN operations on large tables
bottlenecks_0.impact=High
bottlenecks_1.component=External API Calls
bottlenecks_1.description=Third-party service with inconsistent response times
bottlenecks_1.impact=Medium
recommendations_0.category=Database Optimization
recommendations_0.improvement=30
recommendations_0.effort=Medium
recommendations_0.description=Implement query caching and optimize JOIN operations with proper indexing
recommendations_1.category=API Caching
recommendations_1.improvement=25
recommendations_1.effort=Low
recommendations_1.description=Add Redis caching layer for frequently requested data
priority_items_0.task=Implement database indexing
priority_items_0.priority=High
priority_items_1.task=Set up Redis caching
priority_items_1.priority=High
priority_items_2.task=Review third-party service SLA
priority_items_2.priority=Medium
```

Run the performance analysis:

```bash
chmod +x template_cache.sh
./template_cache.sh
./mark generate performance_template.md performance_data.md
```

### Batch Processing for Large Templates

Create a batch processing script `batch_process.sh`:

```bash
#!/bin/bash

# Batch process multiple templates with shared data
process_batch() {
    local data_file=$1
    shift
    local templates=("$@")
    
    echo "Starting batch processing with $data_file"
    echo "Templates to process: ${#templates[@]}"
    
    for template in "${templates[@]}"; do
        echo "Processing $template..."
        output_file="${template%.md}_output.md"
        ./mark generate "$template" "$data_file" > "$output_file"
        echo "Generated $output_file"
    done
    
    echo "Batch processing complete"
}

# Example usage
TEMPLATES=(
    "batch_template1.md"
    "batch_template2.md"
    "batch_template3.md"
)

# Create sample templates
echo "# Template 1 - {{project_name}}\" > batch_template1.md
echo "Task: {{task_description}}" >> batch_template1.md

echo "# Template 2 - {{project_name}}" > batch_template2.md
echo "Priority: {{task_priority}}" >> batch_template2.md

echo "# Template 3 - {{project_name}}" > batch_template3.md
echo "Deadline: {{task_deadline}}" >> batch_template3.md

# Create sample data
echo "project_name=Batch Processing Project" > batch_data.md
echo "task_description=Process multiple templates efficiently" >> batch_data.md
echo "task_priority=High" >> batch_data.md
echo "task_deadline=2023-07-31" >> batch_data.md

# Process batch
process_batch batch_data.md "${TEMPLATES[@]}"
```

Run the batch processing:

```bash
chmod +x batch_process.sh
./batch_process.sh
```

## Error Handling and Debugging

### Debugging Complex Templates

Create a debugging template `debug_template.md`:

```markdown
# Debugging Information for {{template_name}}

Template Version: {{template_version}}
Debug Mode: {{debug_mode}}

## Variable Values

{{#each variables}}
### {{this.name}}

Type: {{this.type}}
Value: {{this.value}}
Defined: {{#if this.defined}}Yes{{else}}No{{/if}}

{{/each}}

## Template Sections

{{#each sections}}
### {{this.name}}

Status: {{this.status}}
{{#if this.content}}
Content Preview:
{{this.content}}
{{/if}}

{{/each}}

## Error Information

{{#if has_errors}}
### Errors Detected

{{#each errors}}
- {{this.type}}: {{this.message}}
{{#if this.line_number}}
  Line: {{this.line_number}}
{{/if}}
{{/each}}
{{else}}
No errors detected during template processing.
{{/if}}

## Warnings

{{#each warnings}}
- {{this}}
{{/each}}

## Processing Statistics

- Processing Time: {{processing_time}}ms
- Variables Processed: {{variables_processed}}
- Files Included: {{files_included}}

Please review this debugging information to resolve any issues.
```

Create data file `debug_data.md`:

```markdown
template_name=Complex Report Template
template_version=2.1.0
debug_mode=enabled
variables_0.name=project_name
variables_0.type=string
variables_0.value=AI Research Initiative
variables_0.defined=true
variables_1.name=report_date
variables_1.type=date
variables_1.value=2023-07-15
variables_1.defined=true
variables_2.name=undefined_var
variables_2.type=string
variables_2.value=
variables_2.defined=false
sections_0.name=Executive Summary
sections_0.status=Complete
sections_0.content=The AI Research Initiative has made significant progress...
sections_1.name=Technical Findings
sections_1.status=Complete
sections_2.name=Financial Analysis
sections_2.status=Processing Error
has_errors=true
errors_0.type=Data
errors_0.message=Missing financial data for Q2
errors_0.line_number=45
errors_1.type=Template
errors_1.message=Unmatched conditional block
errors_1.line_number=127
warnings_0=Some data points are estimates
warnings_1=Detailed analysis pending peer review
processing_time=142
variables_processed=24
files_included=3
```

Generate the debug output:

```bash
./mark generate debug_template.md debug_data.md
```

### Error Recovery Patterns

Create an error handling template `error_handling_template.md`:

```markdown
# {{system_name}} - Error Handling Report

Report Date: {{report_date}}
System Status: {{#if system_operational}}Operational{{else}}Degraded{{/if}}

## Recent Errors

{{#each errors}}
### Error ID: {{this.id}}

Time: {{this.timestamp}}
Severity: {{this.severity}}
Component: {{this.component}}

{{#if this.description}}
Description: {{this.description}}
{{/if}}

{{#if this.resolution}}
Resolution: {{this.resolution}}
{{/if}}

{{#if this.preventive_measures}}
Preventive Measures:
{{#each this.preventive_measures}}
- {{this}}
{{/each}}
{{/if}}

Status: {{this.status}}

---

{{/each}}

## System Health Metrics

{{#each health_metrics}}
- {{this.name}}: {{this.value}}{{#if this.unit}} {{this.unit}}{{/if}} ({{this.status}})
{{/each}}

## Recovery Actions

{{#if recovery_actions}}
The following recovery actions have been implemented:
{{#each recovery_actions}}
{{@index}}. {{this.action}} - {{this.status}} (ETA: {{this.eta}})
{{/each}}
{{else}}
No recovery actions required. System is stable.
{{/if}}

## Next Steps

{{#each next_steps}}
- {{this}}
{{/each}}

{{#if contact_info}}
For immediate assistance, contact {{contact_info}}
{{/if}}
```

Create data file `error_handling_data.md`:

```markdown
system_name=Customer Portal
report_date=2023-07-15
system_operational=false
errors_0.id=ERR-2023-0715-001
errors_0.timestamp=2023-07-15T14:30:22Z
errors_0.severity=HIGH
errors_0.component=Database Connection Pool
errors_0.description=Connection pool exhausted during peak traffic
errors_0.resolution=Increased pool size from 20 to 50 connections
errors_0.preventive_measures_0=Implement connection leak detection
errors_0.preventive_measures_1=Add auto-scaling for database resources
errors_0.status=RESOLVED
errors_1.id=ERR-2023-0715-002
errors_1.timestamp=2023-07-15T16:45:17Z
errors_1.severity=MEDIUM
errors_1.component=Payment Processing
errors_1.description=Timeout when calling external payment gateway
errors_1.resolution=Increased timeout from 10s to 30s
errors_1.preventive_measures_0=Implement circuit breaker pattern
errors_1.preventive_measures_1=Add payment gateway health checks
errors_1.status=IN_PROGRESS
health_metrics_0.name=API Response Time
health_metrics_0.value=245
health_metrics_0.unit=ms
health_metrics_0.status=DEGRADED
health_metrics_1.name=Error Rate
health_metrics_1.value=1.2
health_metrics_1.unit=%
health_metrics_1.status=ACCEPTABLE
health_metrics_2.name=System Uptime
health_metrics_2.value=99.2
health_metrics_2.unit=%
health_metrics_2.status=ACCEPTABLE
recovery_actions_0.action=Scale database resources
recovery_actions_0.status=COMPLETED
recovery_actions_0.eta=15:00
recovery_actions_1.action=Deploy circuit breaker for payment gateway
recovery_actions_1.status=IN_PROGRESS
recovery_actions_1.eta=18:00
next_steps_0=Monitor system performance for next 24 hours
next_steps_1=Conduct post-mortem analysis
next_steps_2=Update incident response documentation
contact_info=ops-team@company.com
```

Generate the error handling report:

```bash
./mark generate error_handling_template.md error_handling_data.md
```

## Integration with External Systems

### CI/CD Pipeline Integration

Create a CI/CD integration script `ci_integration.sh`:

```bash
#!/bin/bash

# CI/CD integration for mark templates
generate_ci_prompts() {
    local commit_message=$(git log -1 --pretty=%B)
    local branch_name=$(git rev-parse --abbrev-ref HEAD)
    local changed_files=$(git diff --name-only HEAD~1 HEAD)
    
    echo "Generating CI/CD prompts for:"
    echo "Commit: $commit_message"
    echo "Branch: $branch_name"
    
    # Determine template based on branch and changes
    local template="default_ci_template.md"
    
    if [[ "$branch_name" == "release"* ]]; then
        template="release_template.md"
    elif [[ "$changed_files" == *"test"* ]]; then
        template="testing_template.md"
    fi
    
    # Create dynamic data file
    cat > ci_data.md << EOF
commit_message=$commit_message
branch_name=$branch_name
changed_files=$changed_files
build_number=$BUILD_NUMBER
environment=$ENVIRONMENT
EOF
    
    # Generate prompt
    ./mark generate "$template" ci_data.md > ci_prompt.md
    echo "Generated CI prompt: ci_prompt.md"
}

# Example templates
echo "# CI/CD Process for {{branch_name}}" > default_ci_template.md
echo "Commit Message: {{commit_message}}" >> default_ci_template.md
echo "Changed Files: {{changed_files}}" >> default_ci_template.md

echo "# Release Process for {{branch_name}}" > release_template.md
echo "Preparing release with commit: {{commit_message}}" >> release_template.md

echo "# Testing Process for {{branch_name}}" > testing_template.md
echo "Running tests for changes in: {{changed_files}}" >> testing_template.md

# Simulate CI data
export BUILD_NUMBER=1234
export ENVIRONMENT=staging

# Generate CI prompts
generate_ci_prompts
```

### API Integration

Create an API integration script `api_integration.sh`:

```bash
#!/bin/bash

# API integration for mark templates
generate_from_api() {
    local api_endpoint=$1
    local template_file=$2
    
    # Fetch data from API (example using curl)
    # In practice, this would be your actual API call
    echo "Fetching data from $api_endpoint..."
    
    # Simulate API response
    cat > api_response.json << EOF
{
  "project": {
    "name": "API Integration Project",
    "status": "active",
    "tasks": [
      {
        "id": "TASK-001",
        "title": "Implement authentication",
        "status": "completed"
      },
      {
        "id": "TASK-002",
        "title": "Add data validation",
        "status": "in_progress"
      }
    ]
  }
}
EOF
    
    # Convert JSON to mark format
    jq -r '
        def to_mark($prefix):
            if type == "object" then
                to_entries[] | 
                if .value | type == "array" then
                    .value | to_entries[] | 
                    (.key | tostring) as $index | 
                    .value | to_mark("\($prefix)\(.key)_\($index)")
                elif .value | type == "object" then
                    .value | to_mark("\($prefix)\(.key).")
                else
                    "\($prefix)\(.key)=\(.value)"
                end
            else
                "\($prefix)=\(.))"
            end;
        to_mark("")
    ' api_response.json > api_data.md
    
    # Generate prompt
    ./mark generate "$template_file" api_data.md > api_prompt.md
    echo "Generated prompt from API data: api_prompt.md"
}

# Create API template
echo "# {{project.name}} Status Report" > api_template.md
echo "Project Status: {{project.status}}" >> api_template.md
echo "" >> api_template.md
echo "## Tasks" >> api_template.md
echo "{{#each project.tasks}}" >> api_template.md
echo "- {{this.id}}: {{this.title}} ({{this.status}})" >> api_template.md
echo "{{/each}}" >> api_template.md

# Generate from API
generate_from_api "https://api.example.com/project/status" api_template.md
```

### Database Integration

Create a database integration script `db_integration.sh`:

```bash
#!/bin/bash

# Database integration for mark templates
generate_from_db() {
    local query=$1
    local template_file=$2
    
    echo "Executing database query..."
    
    # Simulate database query result
    cat > db_result.csv << EOF
project_name,project_status,task_id,task_title,task_status
"Database Integration Project",active,TASK-001,"Set up database connection",completed
"Database Integration Project",active,TASK-002,"Implement data models",in_progress
EOF
    
    # Convert CSV to mark format
    {
        read # Skip header
        while IFS=',' read -r project_name project_status task_id task_title task_status; do
            # Clean up quotes if present
            project_name=${project_name//\"/}
            project_status=${project_status//\"/}
            task_id=${task_id//\"/}
            task_title=${task_title//\"/}
            task_status=${task_status//\"/}
            
            echo "project.name=$project_name"
            echo "project.status=$project_status"
            # For arrays, we would need to track indices
            echo "tasks_0.id=$task_id"
            echo "tasks_0.title=$task_title"
            echo "tasks_0.status=$task_status"
        done
    } < db_result.csv > db_data.md
    
    # Generate prompt
    ./mark generate "$template_file" db_data.md > db_prompt.md
    echo "Generated prompt from database data: db_prompt.md"
}

# Create database template
echo "# {{project.name}} Database Report" > db_template.md
echo "Status: {{project.status}}" >> db_template.md
echo "" >> db_template.md
echo "## Tasks" >> db_template.md
echo "{{#each tasks}}" >> db_template.md
echo "- {{this.id}}: {{this.title}} ({{this.status}})" >> db_template.md
echo "{{/each}}" >> db_template.md

# Generate from database
generate_from_db "SELECT * FROM project_tasks" db_template.md
```

Run the integration scripts:

```bash
chmod +x ci_integration.sh api_integration.sh db_integration.sh
./ci_integration.sh
./api_integration.sh
./db_integration.sh
```

## Conclusion

In this advanced tutorial, you've learned to:

1. Implement template inheritance and composition patterns
2. Create dynamic template selection systems
3. Process complex data from various sources
4. Optimize template performance with caching and batch processing
5. Handle errors and debug complex templates
6. Integrate `mark` with external systems like CI/CD pipelines, APIs, and databases

These advanced techniques will enable you to build sophisticated prompt engineering workflows that can adapt to different contexts and integrate with your existing development processes. In the next tutorial, we'll explore ninja-level techniques for AI agent integration and self-optimizing prompt systems.