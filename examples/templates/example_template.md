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