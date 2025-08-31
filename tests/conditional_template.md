{{greeting}} {{name}}!

{{#if active}}
Welcome back to {{platform}}. Here's what's new:
{{#each notifications}}
- {{this}}
{{/each}}
{{else}}
Welcome to {{platform}}. Please complete your profile to get started.
{{/if}}

{{#if premium}}
As a premium member, you have access to:
{{#each features}}
- {{this}}
{{/each}}
{{/if}}

{{farewell}},
The {{team}} Team