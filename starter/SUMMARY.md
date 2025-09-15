# mark Starter Package - Complete Summary

This document provides a comprehensive overview of the starter package for the `mark` CLI tool, including all prebuilt templates, partials, and sample data.

## Directory Structure

```
~/.mark/
├── templates/              # 10 prebuilt templates
├── partials/               # 4 useful partials
├── data/                   # Sample data files
└── config.data             # Configuration file
```

## Prebuilt Templates (10)

### 1. code-review.md
Professional code review prompt for any programming language
- Variables: project_name, language, code_content, review_focus
- Use case: Reviewing code submissions for correctness, performance, and security

### 2. blog-post.md
Engaging blog post writer for any topic
- Variables: topic, audience, tone, length, key_points
- Use case: Creating content marketing blog posts

### 3. product-description.md
Persuasive product description for e-commerce
- Variables: product_name, product_category, key_features, target_audience, unique_selling_point
- Use case: Writing compelling e-commerce product descriptions

### 4. social-media-post.md
Engaging social media post for various platforms
- Variables: platform, topic, audience, call_to_action, hashtags
- Use case: Creating platform-specific social media content

### 5. email-newsletter.md
Professional email newsletter template
- Variables: subject_line, audience, main_topic, key_insights, call_to_action
- Use case: Writing email marketing newsletters

### 6. meeting-agenda.md
Professional meeting agenda template
- Variables: meeting_title, date, attendees, meeting_objective, agenda_items
- Use case: Planning and organizing business meetings

### 7. project-plan.md
Comprehensive project planning template
- Variables: project_name, project_manager, start_date, end_date, project_scope, key_deliverables
- Use case: Creating detailed project plans

### 8. customer-support.md
Helpful customer support response template
- Variables: customer_name, issue_description, urgency_level, product_service
- Use case: Writing empathetic customer support responses

### 9. learning-plan.md
Personalized learning plan template
- Variables: learner_name, subject_area, current_level, goal_level, timeframe
- Use case: Creating personalized education plans

### 10. research-summary.md
Academic research summary and analysis
- Variables: research_topic, field_of_study, key_findings, implications
- Use case: Summarizing and analyzing academic research

## Partials (4)

### 1. expert-role.md
Defines expert roles for various domains
- Use case: Establishing authority and expertise context

### 2. professional-format.md
Ensures consistent markdown formatting
- Use case: Maintaining professional document structure

### 3. concise-constraint.md
Keeps responses focused and brief
- Use case: Enforcing length and clarity constraints

### 4. step-by-step.md
Provides clear, sequential explanations
- Use case: Breaking down complex processes

## Sample Data Files

### Code Review Data
- Sample JavaScript code for review
- Complete data set for code review template

### Blog Post Data
- Health and wellness topic
- Complete data set for blog post template

### Product Description Data
- Audio equipment (headphones)
- Complete data set for product description template

### Social Media Data
- LinkedIn platform
- Complete data set for social media template

## Installation

The starter package is automatically installed when you run:
```bash
./starter/install-starter.sh
```

## Usage Examples

### List all templates:
```bash
mark template list
```

### Generate a prompt interactively:
```bash
mark generate --interactive
```

### Generate a specific prompt:
```bash
mark generate code-review starter/data/code-review-data.txt
```

### Create a new template with wizard:
```bash
mark template new my-template --wizard
```

### Edit an existing template:
```bash
mark template edit code-review
```

## Configuration

The starter package includes a default configuration with:
- Template directories set to `~/.mark/templates`
- Editor set to `vim` (can be changed with `mark config set editor <editor>`)
- Fuzzy finder support enabled

## Getting Started

1. Install the starter package: `./starter/install-starter.sh`
2. List available templates: `mark template list`
3. Generate your first prompt: `mark generate --interactive`
4. Customize templates to your needs: `mark template edit <template-name>`

The starter package provides a solid foundation for prompt engineering with `mark`, covering common use cases and providing a framework for creating your own custom templates.