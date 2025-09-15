# mark Starter Package

This starter package includes 10 prebuilt templates, useful partials, and sample data to help you get started with `mark` immediately.

## Templates Included

1. **code-review.md** - Professional code review prompt
2. **blog-post.md** - Engaging blog post writer
3. **product-description.md** - Persuasive product description
4. **social-media-post.md** - Social media content creator
5. **email-newsletter.md** - Professional email newsletter
6. **meeting-agenda.md** - Meeting agenda planner
7. **project-plan.md** - Comprehensive project plan
8. **customer-support.md** - Customer support response
9. **learning-plan.md** - Personalized learning plan
10. **research-summary.md** - Academic research summary

## Partials Included

- **expert-role.md** - Defines expert roles for various domains
- **professional-format.md** - Ensures consistent markdown formatting
- **concise-constraint.md** - Keeps responses focused and brief
- **step-by-step.md** - Provides clear, sequential explanations

## Sample Data Files

- Code review data with sample JavaScript code
- Blog post data for health topics
- Product description data for headphones
- Social media post data for LinkedIn

## Installation

Run the installation script:

```bash
./install-starter.sh
```

This will copy all templates, partials, and sample data to your `~/.mark/` directory.

## Usage Examples

### Generate a code review prompt:
```bash
mark generate code-review data/code-review-data.txt --out code-review-prompt.txt
```

### Create a blog post interactively:
```bash
mark generate --interactive
# Select "blog-post" from the template list
```

### Use the template creation wizard:
```bash
mark template new my-new-template --wizard
```

## Customization

Feel free to modify any of these templates to suit your specific needs. You can:
- Edit existing templates: `mark template edit <template-name>`
- Create new templates: `mark template new <template-name>`
- Delete templates: `mark template delete <template-name>`

All templates use the standard `mark` syntax with variable substitution using `{{variable_name}}`.