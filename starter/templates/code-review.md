---
name: code-review
description: "Professional code review prompt for any programming language"
tags: ["code", "review", "feedback"]
variables:
  - project_name
  - language
  - code_content
  - review_focus
---
# Code Review: {{project_name}}

You are a senior {{language}} developer tasked with reviewing the following code submission.

## Code to Review
{{code_content}}

## Review Focus
Please focus your review on the following aspects:
{{review_focus}}

## Review Guidelines
Provide feedback on:
1. Correctness and logic
2. Performance and efficiency
3. Security considerations
4. Code readability and maintainability
5. Best practices and style

## Response Format
Structure your feedback as:
- **Critical Issues** (must be fixed)
- **Improvements** (should be considered)
- **Observations** (nice to know)

Respond in clear markdown with specific examples and actionable suggestions.