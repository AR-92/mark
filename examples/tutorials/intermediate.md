# mark Intermediate Tutorial

This tutorial builds on the beginner concepts and dives deeper into `mark`'s powerful features for creating more sophisticated prompt templates.

## Table of Contents

1. [Advanced Conditional Logic](#advanced-conditional-logic)
2. [Complex Loop Structures](#complex-loop-structures)
3. [Nested Templates](#nested-templates)
4. [Environment Variable Integration](#environment-variable-integration)
5. [Working with Complex Data Structures](#working-with-complex-data-structures)

## Advanced Conditional Logic

### Multiple Conditions with Nested Blocks

Create `advanced_conditional_template.md`:

```markdown
# {{project_type}} Project Assistant

{{#if security_critical}}
{{#if compliance_required}}
**SECURITY & COMPLIANCE CRITICAL PROJECT**
{{else}}
**SECURITY CRITICAL PROJECT**
{{/if}}
{{else}}
{{#if compliance_required}}
**COMPLIANCE CRITICAL PROJECT**
{{/if}}
{{/if}}

Project: {{project_name}}

{{#if team_size}}
Team Size: {{team_size}} developers
{{/if}}

{{#if timeline_weeks}}
Timeline: {{timeline_weeks}} weeks
{{/if}}

{{#if technology_stack}}
Technology Stack:
{{#each technology_stack}}
- {{this}}
{{/each}}
{{/if}}

Task: {{task_description}}

{{#if security_critical}}
## Security Considerations
{{#each security_considerations}}
- {{this}}
{{/each}}
{{/if}}

{{#if compliance_required}}
## Compliance Requirements
{{#each compliance_requirements}}
- {{this}}
{{/each}}
{{/if}}

Please provide a detailed plan addressing all specified requirements.
```

Create data file `advanced_conditional_data.md`:

```markdown
project_type=Web Application
security_critical=true
compliance_required=true
project_name=Healthcare Patient Portal
team_size=5
timeline_weeks=12
technology_stack_0=React
technology_stack_1=Node.js
technology_stack_2=MongoDB
technology_stack_3=Redis
task_description=Develop a patient portal for viewing medical records and scheduling appointments
security_considerations_0=HIPAA compliance for data handling
security_considerations_1=End-to-end encryption for data in transit
security_considerations_2=Multi-factor authentication
security_considerations_3=Regular security audits
compliance_requirements_0=HIPAA compliance documentation
compliance_requirements_1=Regular compliance training for team members
compliance_requirements_2=Audit trails for all patient data access
```

Generate the prompt:

```bash
./mark generate advanced_conditional_template.md advanced_conditional_data.md
```

### Conditional Logic with Else If Patterns

While `mark` doesn't have explicit else-if support, you can simulate it with nested conditionals. Create `elseif_template.md`:

```markdown
# {{system_type}} Configuration Assistant

{{#if system_type}}
{{#if system_type == \"WebServer\"}}
This is a web server configuration task.
{{else}}
{{#if system_type == \"Database\"}}
This is a database configuration task.
{{else}}
{{#if system_type == \"Network\"}}
This is a network configuration task.
{{else}}
This is a general system configuration task.
{{/if}}
{{/if}}
{{/if}}
{{/if}}

System: {{system_name}}
OS: {{operating_system}}

{{#if environment}}
Environment: {{environment}}
{{/if}}

Task: {{configuration_task}}

{{#if system_type == \"WebServer\"}}
## Web Server Specific Considerations
{{#each webserver_considerations}}
- {{this}}
{{/each}}
{{else}}
{{#if system_type == \"Database\"}}
## Database Specific Considerations
{{#each database_considerations}}
- {{this}}
{{/each}}
{{else}}
{{#if system_type == \"Network\"}}
## Network Specific Considerations
{{#each network_considerations}}
- {{this}}
{{/each}}
{{/if}}
{{/if}}
{{/if}}

Please provide a comprehensive configuration plan.
```

Create data file `elseif_data.md`:

```markdown
system_type=Database
system_name=CustomerDB
operating_system=Ubuntu 20.04
environment=Production
configuration_task=Optimize PostgreSQL for high-concurrency read operations
database_considerations_0=Connection pooling configuration
database_considerations_1=Index optimization for read-heavy queries
database_considerations_2=Memory allocation tuning
database_considerations_3=Replication setup for read scaling
```

Note: The above template uses a pattern that simulates else-if behavior. However, `mark` currently evaluates conditions as truthy/falsy rather than doing string comparisons. For actual conditional logic, you would need to structure your data differently.

A better approach for this use case would be:

Create `elseif_better_template.md`:

```markdown
# {{system_category}} Configuration Assistant

{{#if is_webserver}}
This is a web server configuration task.
{{/if}}

{{#if is_database}}
This is a database configuration task.
{{/if}}

{{#if is_network}}
This is a network configuration task.
{{/if}}

{{#if is_general}}
This is a general system configuration task.
{{/if}}

System: {{system_name}}
OS: {{operating_system}}

{{#if environment}}
Environment: {{environment}}
{{/if}}

Task: {{configuration_task}}

{{#if is_webserver}}
## Web Server Specific Considerations
{{#each webserver_considerations}}
- {{this}}
{{/each}}
{{/if}}

{{#if is_database}}
## Database Specific Considerations
{{#each database_considerations}}
- {{this}}
{{/each}}
{{/if}}

{{#if is_network}}
## Network Specific Considerations
{{#each network_considerations}}
- {{this}}
{{/each}}
{{/if}}

Please provide a comprehensive configuration plan.
```

Create data file `elseif_better_data.md`:

```markdown
system_category=Database
is_database=true
system_name=CustomerDB
operating_system=Ubuntu 20.04
environment=Production
configuration_task=Optimize PostgreSQL for high-concurrency read operations
database_considerations_0=Connection pooling configuration
database_considerations_1=Index optimization for read-heavy queries
database_considerations_2=Memory allocation tuning
database_considerations_3=Replication setup for read scaling
```

Generate the prompt:

```bash
./mark generate elseif_better_template.md elseif_better_data.md
```

## Complex Loop Structures

### Nested Loops

Create `nested_loops_template.md`:

```markdown
# {{project_name}} Development Plan

Project Manager: {{project_manager}}

## Development Phases

{{#each phases}}
### Phase {{@index}}: {{this.name}}

Duration: {{this.duration}}

#### Tasks in this Phase
{{#each this.tasks}}
- {{this.name}} ({{this.estimated_hours}} hours)
{{/each}}

#### Deliverables
{{#each this.deliverables}}
- {{this}}
{{/each}}

{{/each}}

## Resource Allocation

{{#each team_members}}
### {{this.name}} - {{this.role}}

Skills:
{{#each this.skills}}
- {{this}}
{{/each}}

Assigned Phases:
{{#each this.assigned_phases}}
- {{this}}
{{/each}}

{{/each}}

Please review this development plan and provide feedback.
```

Create data file `nested_loops_data.md`:

```markdown
project_name=E-commerce Platform
project_manager=Jane Smith
phases_0.name=Planning and Design
phases_0.duration=2 weeks
phases_0.tasks_0.name=Requirements gathering
phases_0.tasks_0.estimated_hours=40
phases_0.tasks_1.name=System architecture design
phases_0.tasks_1.estimated_hours=60
phases_0.deliverables_0=Requirements document
phases_0.deliverables_1=System architecture diagram
phases_1.name=Frontend Development
phases_1.duration=6 weeks
phases_1.tasks_0.name=UI/UX implementation
phases_1.tasks_0.estimated_hours=120
phases_1.tasks_1.name=Component development
phases_1.tasks_1.estimated_hours=160
phases_1.deliverables_0=Frontend components
phases_1.deliverables_1=UI prototype
phases_2.name=Backend Development
phases_2.duration=8 weeks
phases_2.tasks_0.name=API development
phases_2.tasks_0.estimated_hours=200
phases_2.tasks_1.name=Database design and implementation
phases_2.tasks_1.estimated_hours=100
phases_2.deliverables_0=REST API
phases_2.deliverables_1=Database schema
team_members_0.name=Alice Johnson
team_members_0.role=Frontend Developer
team_members_0.skills_0=React
team_members_0.skills_1=CSS
team_members_0.skills_2=JavaScript
team_members_0.assigned_phases_0=Frontend Development
team_members_0.assigned_phases_1=Planning and Design
team_members_1.name=Bob Smith
team_members_1.role=Backend Developer
team_members_1.skills_0=Node.js
team_members_1.skills_1=PostgreSQL
team_members_1.skills_2=REST APIs
team_members_1.assigned_phases_0=Backend Development
team_members_1.assigned_phases_1=Planning and Design
```

Generate the prompt:

```bash
./mark generate nested_loops_template.md nested_loops_data.md
```

### Loops with Conditional Content

Create `conditional_loops_template.md`:

```markdown
# {{project_name}} Testing Strategy

Project Type: {{project_type}}

## Test Scenarios

{{#each test_scenarios}}
### Scenario {{@index}}: {{this.name}}

{{#if this.description}}
Description: {{this.description}}
{{/if}}

{{#if this.priority}}
Priority: {{this.priority}}
{{/if}}

{{#if this.requires_environment_setup}}
**Requires Special Environment Setup**
{{/if}}

Test Steps:
{{#each this.steps}}
{{@index}}. {{this}}
{{/each}}

{{#if this.expected_outcomes}}
Expected Outcomes:
{{#each this.expected_outcomes}}
- {{this}}
{{/each}}
{{/if}}

{{#if this.edge_cases}}
Edge Cases to Consider:
{{#each this.edge_cases}}
- {{this}}
{{/each}}
{{/if}}

---

{{/each}}

Please execute these test scenarios and document the results.
```

Create data file `conditional_loops_data.md`:

```markdown
project_name=Mobile Banking App
project_type=Financial Services
test_scenarios_0.name=User Authentication
test_scenarios_0.description=Verify user can log in with valid credentials
test_scenarios_0.priority=High
test_scenarios_0.requires_environment_setup=false
test_scenarios_0.steps_0=Launch the app
test_scenarios_0.steps_1=Enter valid username and password
test_scenarios_0.steps_2=Tap login button
test_scenarios_0.expected_outcomes_0=User is redirected to dashboard
test_scenarios_0.expected_outcomes_1=No error messages displayed
test_scenarios_1.name=Fund Transfer
test_scenarios_1.description=Verify user can transfer funds between accounts
test_scenarios_1.priority=High
test_scenarios_1.requires_environment_setup=true
test_scenarios_1.steps_0=Log in to the app
test_scenarios_1.steps_1=Navigate to transfer funds screen
test_scenarios_1.steps_2=Select source and destination accounts
test_scenarios_1.steps_3=Enter transfer amount
test_scenarios_1.steps_4=Confirm transfer
test_scenarios_1.expected_outcomes_0=Transfer is successful
test_scenarios_1.expected_outcomes_1=Balances are updated correctly
test_scenarios_1.edge_cases_0=Transfer amount exceeds available balance
test_scenarios_1.edge_cases_1=Transfer to invalid account number
test_scenarios_2.name=Offline Mode
test_scenarios_2.description=Verify app behavior when network is unavailable
test_scenarios_2.priority=Medium
test_scenarios_2.requires_environment_setup=true
test_scenarios_2.steps_0=Put device in airplane mode
test_scenarios_2.steps_1=Launch the app
test_scenarios_2.steps_2=Attempt to view account information
test_scenarios_2.expected_outcomes_0=App displays cached data
test_scenarios_2.expected_outcomes_1=App shows appropriate offline message
```

Generate the prompt:

```bash
./mark generate conditional_loops_template.md conditional_loops_data.md
```

## Nested Templates

### Template Reuse with Parameters

Create `reusable_component_template.md`:

```markdown
{{#if component_type == \"api_endpoint\"}}
## API Endpoint: {{endpoint_name}}

Method: {{http_method}}
Path: {{endpoint_path}}

{{#if endpoint_description}}
Description: {{endpoint_description}}
{{/if}}

{{#if request_parameters}}
Request Parameters:
{{#each request_parameters}}
- {{this.name}} ({{this.type}}){{#if this.required}} - Required{{/if}}{{#if this.description}}: {{this.description}}{{/if}}
{{/each}}
{{/if}}

{{#if response_structure}}
Response Structure:
```json
{{response_structure}}
```
{{/if}}

{{#if error_responses}}
Error Responses:
{{#each error_responses}}
- {{this.code}}: {{this.description}}
{{/each}}
{{/if}}
{{/if}}

{{#if component_type == \"database_table\"}}
## Database Table: {{table_name}}

{{#if table_description}}
Description: {{table_description}}
{{/if}}

Columns:
{{#each columns}}
- {{this.name}} ({{this.type}}){{#if this.constraints}} {{this.constraints}}{{/if}}{{#if this.description}}: {{this.description}}{{/if}}
{{/each}}

{{#if relationships}}
Relationships:
{{#each relationships}}
- {{this}}
{{/each}}
{{/if}}

{{#if indexes}}
Indexes:
{{#each indexes}}
- {{this}}
{{/each}}
{{/if}}
{{/if}}
```

Create main template `api_documentation_template.md`:

```markdown
# {{api_name}} API Documentation

Version: {{api_version}}
Base URL: {{base_url}}

{{#if api_description}}
{{api_description}}
{{/if}}

## Endpoints

{{@reusable_component_template.md}}

{{@reusable_component_template.md}}

## Database Schema

{{@reusable_component_template.md}}
```

Create data file `api_documentation_data.md`:

```markdown
api_name=User Management
api_version=v1.0
base_url=https://api.example.com/v1
api_description=API for managing user accounts, authentication, and profiles
component_type=api_endpoint
endpoint_name=Create User
http_method=POST
endpoint_path=/users
endpoint_description=Create a new user account
request_parameters_0.name=email
request_parameters_0.type=string
request_parameters_0.required=true
request_parameters_0.description=User's email address
request_parameters_1.name=password
request_parameters_1.type=string
request_parameters_1.required=true
request_parameters_1.description=User's password
request_parameters_2.name=name
request_parameters_2.type=string
request_parameters_2.required=false
request_parameters_2.description=User's full name
response_structure={
  \"id\": 123,
  \"email\": \"user@example.com\",
  \"name\": \"John Doe\",
  \"created_at\": \"2023-01-01T00:00:00Z\"
}
error_responses_0.code=400
error_responses_0.description=Invalid request data
error_responses_1.code=409
error_responses_1.description=Email already exists
component_type_1=api_endpoint
endpoint_name_1=Get User
http_method_1=GET
endpoint_path_1=/users/{id}
endpoint_description_1=Retrieve user account information
response_structure_1={
  \"id\": 123,
  \"email\": \"user@example.com\",
  \"name\": \"John Doe\",
  \"created_at\": \"2023-01-01T00:00:00Z\"
}
error_responses_1_0.code=404
error_responses_1_0.description=User not found
component_type_2=database_table
table_name=users
table_description=Stores user account information
columns_0.name=id
columns_0.type=INTEGER
columns_0.constraints=PRIMARY KEY, AUTO_INCREMENT
columns_1.name=email
columns_1.type=VARCHAR(255)
columns_1.constraints=NOT NULL, UNIQUE
columns_2.name=password_hash
columns_2.type=VARCHAR(255)
columns_2.constraints=NOT NULL
columns_3.name=name
columns_3.type=VARCHAR(255)
columns_4.name=created_at
columns_4.type=TIMESTAMP
columns_4.constraints=NOT NULL, DEFAULT CURRENT_TIMESTAMP
indexes_0=INDEX idx_email (email)
```

Note that the above approach has a limitation - the same template file is being included multiple times with different data. In `mark`, we need to create separate template files for each inclusion. Let's revise the approach:

Create `api_endpoint_template.md`:

```markdown
## API Endpoint: {{endpoint_name}}

Method: {{http_method}}
Path: {{endpoint_path}}

{{#if endpoint_description}}
Description: {{endpoint_description}}
{{/if}}

{{#if request_parameters}}
Request Parameters:
{{#each request_parameters}}
- {{this.name}} ({{this.type}}){{#if this.required}} - Required{{/if}}{{#if this.description}}: {{this.description}}{{/if}}
{{/each}}
{{/if}}

{{#if response_structure}}
Response Structure:
```json
{{response_structure}}
```
{{/if}}

{{#if error_responses}}
Error Responses:
{{#each error_responses}}
- {{this.code}}: {{this.description}}
{{/each}}
{{/if}}
```

Create `database_table_template.md`:

```markdown
## Database Table: {{table_name}}

{{#if table_description}}
Description: {{table_description}}
{{/if}}

Columns:
{{#each columns}}
- {{this.name}} ({{this.type}}){{#if this.constraints}} {{this.constraints}}{{/if}}{{#if this.description}}: {{this.description}}{{/if}}
{{/each}}

{{#if relationships}}
Relationships:
{{#each relationships}}
- {{this}}
{{/each}}
{{/if}}

{{#if indexes}}
Indexes:
{{#each indexes}}
- {{this}}
{{/each}}
{{/if}}
```

Create main template `api_documentation_template_v2.md`:

```markdown
# {{api_name}} API Documentation

Version: {{api_version}}
Base URL: {{base_url}}

{{#if api_description}}
{{api_description}}
{{/if}}

## Endpoints

{{@api_endpoint_template.md}}

{{@api_endpoint_template.md}}

## Database Schema

{{@database_table_template.md}}
```

Create data file `api_documentation_data_v2.md`:

```markdown
api_name=User Management
api_version=v1.0
base_url=https://api.example.com/v1
api_description=API for managing user accounts, authentication, and profiles
endpoint_name=Create User
http_method=POST
endpoint_path=/users
endpoint_description=Create a new user account
request_parameters_0.name=email
request_parameters_0.type=string
request_parameters_0.required=true
request_parameters_0.description=User's email address
request_parameters_1.name=password
request_parameters_1.type=string
request_parameters_1.required=true
request_parameters_1.description=User's password
request_parameters_2.name=name
request_parameters_2.type=string
request_parameters_2.required=false
request_parameters_2.description=User's full name
response_structure={
  \"id\": 123,
  \"email\": \"user@example.com\",
  \"name\": \"John Doe\",
  \"created_at\": \"2023-01-01T00:00:00Z\"
}
error_responses_0.code=400
error_responses_0.description=Invalid request data
error_responses_1.code=409
error_responses_1.description=Email already exists
endpoint_name_1=Get User
http_method_1=GET
endpoint_path_1=/users/{id}
endpoint_description_1=Retrieve user account information
response_structure_1={
  \"id\": 123,
  \"email\": \"user@example.com\",
  \"name\": \"John Doe\",
  \"created_at\": \"2023-01-01T00:00:00Z\"
}
error_responses_1_0.code=404
error_responses_1_0.description=User not found
table_name=users
table_description=Stores user account information
columns_0.name=id
columns_0.type=INTEGER
columns_0.constraints=PRIMARY KEY, AUTO_INCREMENT
columns_1.name=email
columns_1.type=VARCHAR(255)
columns_1.constraints=NOT NULL, UNIQUE
columns_2.name=password_hash
columns_2.type=VARCHAR(255)
columns_2.constraints=NOT NULL
columns_3.name=name
columns_3.type=VARCHAR(255)
columns_4.name=created_at
columns_4.type=TIMESTAMP
columns_4.constraints=NOT NULL, DEFAULT CURRENT_TIMESTAMP
indexes_0=INDEX idx_email (email)
```

Generate the prompt:

```bash
./mark generate api_documentation_template_v2.md api_documentation_data_v2.md
```

## Environment Variable Integration

### Dynamic Context from Environment

Create `environment_template.md`:

```markdown
# {{task_domain}} Assistant

Current Environment:
- Time: {{current_time}}
- User: {{user}}
- Host: {{hostname}}
- Working Directory: {{pwd}}

{{#if CI}}
**Running in CI Environment**
{{/if}}

{{#if DEBUG}}
**Debug Mode Enabled**
Debug Information:
- Debug Level: {{DEBUG_LEVEL}}
- Log File: {{LOG_FILE}}
{{/if}}

Task: {{task_description}}

{{#if additional_context}}
Additional Context:
{{#each additional_context}}
- {{this}}
{{/each}}
{{/if}}

Please complete this task with the provided context.
```

Create data file `environment_data.md`:

```markdown
task_domain=Deployment
task_description=Deploy the latest version of the web application
additional_context_0=Deployment target: staging environment
additional_context_1=Rollback plan is in place
additional_context_2=Monitoring alerts configured
```

Generate the prompt with environment variables:

```bash
export current_time=$(date)
export user=$(whoami)
export hostname=$(hostname)
export pwd=$(pwd)
export CI=true
export DEBUG=true
export DEBUG_LEVEL=verbose
export LOG_FILE=/var/log/deployment.log

./mark generate environment_template.md environment_data.md
```

### Configuration-Based Templates

Create `config_template.md`:

```markdown
# {{application_name}} Configuration

Environment: {{environment}}

{{#if environment == \"production\"}}
**PRODUCTION ENVIRONMENT - HANDLE WITH CARE**
{{/if}}

{{#if environment == \"staging\"}}
**STAGING ENVIRONMENT**
{{/if}}

{{#if environment == \"development\"}}
**DEVELOPMENT ENVIRONMENT**
{{/if}}

## Database Configuration
Host: {{db_host}}
Port: {{db_port}}
Name: {{db_name}}
{{#if db_ssl}}
SSL: Enabled
{{else}}
SSL: Disabled
{{/if}}

## Cache Configuration
{{#if cache_enabled}}
Cache: Enabled
Cache Host: {{cache_host}}
Cache Port: {{cache_port}}
{{else}}
Cache: Disabled
{{/if}}

## Feature Flags
{{#each features}}
{{#if this.enabled}}
[ENABLED]  {{this.name}}: {{this.description}}
{{else}}
[DISABLED] {{this.name}}: {{this.description}}
{{/if}}
{{/each}}

## Security Settings
{{#if security_mandatory_fields}}
Mandatory Security Fields:
{{#each security_mandatory_fields}}
- {{this}}
{{/each}}
{{/if}}

Please verify these configuration settings.
```

Create data file `config_data.md`:

```markdown
application_name=Customer Portal
environment=production
db_host=db.production.internal
db_port=5432
db_name=customer_portal
db_ssl=true
cache_enabled=true
cache_host=redis.production.internal
cache_port=6379
features_0.name=new_checkout
features_0.description=New payment processing flow
features_0.enabled=true
features_1.name=legacy_api
features_1.description=Old API endpoints for backward compatibility
features_1.enabled=false
features_2.name=analytics_dashboard
features_2.description=Enhanced analytics and reporting
features_2.enabled=true
security_mandatory_fields_0=encryption_at_rest
security_mandatory_fields_1=audit_logging
security_mandatory_fields_2=two_factor_auth
```

Generate the prompt:

```bash
./mark generate config_template.md config_data.md
```

## Working with Complex Data Structures

### Hierarchical Data Representation

Create `hierarchical_template.md`:

```markdown
# {{organization_name}} System Architecture

Architecture Version: {{architecture_version}}

## System Components

{{#each components}}
### {{this.name}}

Type: {{this.type}}
{{#if this.description}}
Description: {{this.description}}
{{/if}}

{{#if this.dependencies}}
Dependencies:
{{#each this.dependencies}}
- {{this}}
{{/each}}
{{/if}}

{{#if this.interfaces}}
Interfaces:
{{#each this.interfaces}}
- {{this.name}}: {{this.description}}
{{/each}}
{{/if}}

{{#if this.scaling}}
Scaling Considerations: {{this.scaling}}
{{/if}}

{{#if this.monitoring}}
Monitoring:
{{#each this.monitoring}}
- {{this}}
{{/each}}
{{/if}}

---

{{/each}}

## Data Flow

{{#each data_flows}}
### {{this.name}}

Source: {{this.source}}
Destination: {{this.destination}}
{{#if this.description}}
Description: {{this.description}}
{{/if}}

{{#if this.protocols}}
Protocols:
{{#each this.protocols}}
- {{this}}
{{/each}}
{{/if}}

---

{{/each}}

Please review this architecture and provide feedback.
```

Create data file `hierarchical_data.md`:

```markdown
organization_name=TechCorp
architecture_version=2.1
components_0.name=Web Frontend
components_0.type=UI Service
components_0.description=React-based user interface for customer interactions
components_0.dependencies_0=API Gateway
components_0.dependencies_1=Authentication Service
components_0.interfaces_0.name=REST API
components_0.interfaces_0.description=Interface to backend services
components_0.scaling=Horizontally scalable with load balancer
components_0.monitoring_0=Response time metrics
components_0.monitoring_1=Error rate tracking
components_1.name=API Gateway
components_1.type=Routing Service
components_1.description=Routes requests to appropriate backend services
components_1.dependencies_0=Authentication Service
components_1.dependencies_1=Order Service
components_1.dependencies_2=Inventory Service
components_1.interfaces_0.name=Public API
components_1.interfaces_0.description=External interface for clients
components_1.interfaces_1.name=Internal API
components_1.interfaces_1.description=Interface for backend services
components_1.scaling=Auto-scaling based on request volume
components_1.monitoring_0=Request routing metrics
components_1.monitoring_1=Latency measurements
components_2.name=Order Service
components_2.type=Business Logic
components_2.description=Handles order processing and management
components_2.dependencies_0=Inventory Service
components_2.dependencies_1=Payment Service
components_2.dependencies_2=Database
components_2.interfaces_0.name=Order API
components_2.interfaces_0.description=API for order operations
components_2.scaling=Scale based on order volume
components_2.monitoring_0=Order processing time
components_2.monitoring_1=Failure rate tracking
data_flows_0.name=Customer Order Processing
data_flows_0.source=Web Frontend
data_flows_0.destination=Order Service
data_flows_0.description=Flow of order data from frontend to order processing
data_flows_0.protocols_0=HTTPS
data_flows_0.protocols_1=JSON
data_flows_1.name=Inventory Update
data_flows_1.source=Order Service
data_flows_1.destination=Inventory Service
data_flows_1.description=Update inventory levels after order processing
data_flows_1.protocols_0=AMQP
data_flows_1.protocols_1=JSON
```

Generate the prompt:

```bash
./mark generate hierarchical_template.md hierarchical_data.md
```

### Multi-Dimensional Data

Create `multidimensional_template.md`:

```markdown
# {{analysis_type}} Report for {{subject}}

Report Period: {{report_period}}
Generated: {{report_date}}

## Executive Summary

{{executive_summary}}

## Detailed Analysis

{{#each analysis_dimensions}}
### {{this.dimension_name}}

{{#if this.description}}
Description: {{this.description}}
{{/if}}

{{#if this.metrics}}
Key Metrics:
{{#each this.metrics}}
- {{this.name}}: {{this.value}}{{#if this.unit}} {{this.unit}}{{/if}}{{#if this.trend}} ({{this.trend}}){{/if}}
{{/each}}
{{/if}}

{{#if this.segments}}
Segment Analysis:
{{#each this.segments}}
#### {{this.name}}

{{#if this.description}}
Description: {{this.description}}
{{/if}}

Metrics:
{{#each this.metrics}}
- {{this.name}}: {{this.value}}{{#if this.unit}} {{this.unit}}{{/if}}{{#if this.trend}} ({{this.trend}}){{/if}}
{{/each}}

{{/each}}
{{/if}}

{{#if this.insights}}
Key Insights:
{{#each this.insights}}
- {{this}}
{{/each}}
{{/if}}

---

{{/each}}

## Recommendations

{{#each recommendations}}
### {{@index}}. {{this.category}}

Priority: {{this.priority}}

{{this.description}}

{{#if this.implementation_steps}}
Implementation Steps:
{{#each this.implementation_steps}}
{{@index}}. {{this}}
{{/each}}
{{/if}}

Expected Impact: {{this.expected_impact}}

---

{{/each}}

Please review this analysis and provide your feedback.
```

Create data file `multidimensional_data.md`:

```markdown
analysis_type=Market Performance
subject=Product Line A
report_period=Q2 2023
report_date=2023-07-15
executive_summary=Product Line A showed strong growth in Q2 with a 15% increase in revenue compared to Q1. Market share improved in two key segments, but price competition intensified.
analysis_dimensions_0.dimension_name=Revenue Analysis
analysis_dimensions_0.description=Comprehensive revenue breakdown by channel and region
analysis_dimensions_0.metrics_0.name=Total Revenue
analysis_dimensions_0.metrics_0.value=$2.5M
analysis_dimensions_0.metrics_0.unit=
analysis_dimensions_0.metrics_0.trend=+15%
analysis_dimensions_0.metrics_1.name=YoY Growth
analysis_dimensions_0.metrics_1.value=22%
analysis_dimensions_0.metrics_1.unit=
analysis_dimensions_0.metrics_1.trend=+5%
analysis_dimensions_0.segments_0.name=Online Channel
analysis_dimensions_0.segments_0.description=Direct-to-consumer e-commerce sales
analysis_dimensions_0.segments_0.metrics_0.name=Revenue
analysis_dimensions_0.segments_0.metrics_0.value=$1.8M
analysis_dimensions_0.segments_0.metrics_0.trend=+18%
analysis_dimensions_0.segments_1.name=Retail Channel
analysis_dimensions_0.segments_1.description=Sales through retail partners
analysis_dimensions_0.segments_1.metrics_0.name=Revenue
analysis_dimensions_0.segments_1.metrics_0.value=$0.7M
analysis_dimensions_0.segments_1.metrics_0.trend=+8%
analysis_dimensions_0.insights_0=Online channel outperforming retail
analysis_dimensions_0.insights_1=Strong seasonal demand in Q2
analysis_dimensions_1.dimension_name=Customer Acquisition
analysis_dimensions_1.description=Analysis of new customer metrics and cost per acquisition
analysis_dimensions_1.metrics_0.name=New Customers
analysis_dimensions_1.metrics_0.value=15000
analysis_dimensions_1.metrics_0.trend=+25%
analysis_dimensions_1.metrics_1.name=Cost Per Acquisition
analysis_dimensions_1.metrics_1.value=$12.50
analysis_dimensions_1.metrics_1.unit=
analysis_dimensions_1.metrics_1.trend=-8%
analysis_dimensions_1.insights_0=Improved marketing efficiency
analysis_dimensions_1.insights_1=Higher conversion rates from new campaigns
recommendations_0.category=Channel Investment
recommendations_0.priority=High
recommendations_0.description=Increase investment in online channel marketing to capitalize on strong performance
recommendations_0.implementation_steps_0=Allocate 20% additional budget to digital marketing
recommendations_0.implementation_steps_1=Launch targeted social media campaign
recommendations_0.expected_impact=10% revenue increase in Q3
recommendations_1.category=Pricing Strategy
recommendations_1.priority=Medium
recommendations_1.description=Review pricing strategy to address competitive pressure
recommendations_1.implementation_steps_0=Conduct competitive pricing analysis
recommendations_1.implementation_steps_1=Test price adjustments with select customer segments
recommendations_1.expected_impact=Maintain market share while protecting margins
```

Generate the prompt:

```bash
./mark generate multidimensional_template.md multidimensional_data.md
```

## Conclusion

In this intermediate tutorial, you've learned to:

1. Implement advanced conditional logic with nested blocks
2. Work with complex loop structures including nested loops
3. Create reusable template components and compose them
4. Integrate environment variables for dynamic context
5. Represent hierarchical and multi-dimensional data in templates

These skills will allow you to create sophisticated, dynamic prompt templates that can handle complex scenarios and data structures. In the next tutorial, we'll explore advanced techniques for AI agent integration and performance optimization.