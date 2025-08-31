# Directive Test Template

This template tests various directive combinations.

{{#if active}}
Active user: {{name}}
{{else}}
Inactive user: {{name}}
{{/if}}

Requirements:
{{#each requirements}}
- {{this}}
{{/each}}

{{#if debug_mode}}
Debug information:
{{debug_info}}
{{/if}}