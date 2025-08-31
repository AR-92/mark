Create a {{language}} function that {{task}}.
The function should:
{{#each requirements}}
- {{this}}
{{/each}}

{{#if include_example}}
Example:
```{{language}}
{{example_code}}
```
{{/if}}

Return the result as specified in the requirements.