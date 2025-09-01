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