Generate a {{document_type}} for {{project_name}}.
{{#if confidential}}
CONFIDENTIAL
{{/if}}

Project Lead: {{lead}}
Team Size: {{team_size}}

{{#each objectives}}
Objective {{@index}}: {{this}}
{{/each}}

Timeline:
{{#each milestones}}
- {{this.name}}: {{this.date}}
{{/each}}

{{#if budget}}
Budget: ${{budget}}
{{/if}}