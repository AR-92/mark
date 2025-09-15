#!/bin/bash

# mark - Interactive Generate command using Gum
# This file demonstrates how Gum can be integrated into mark for generation

# Check if Gum is installed
check_gum() {
    if ! command -v gum &> /dev/null; then
        echo "Error: Gum is not installed. Please install Gum to use interactive features."
        echo "See: https://github.com/charmbracelet/gum#installation"
        return 1
    fi
    return 0
}

# Interactive generate command
generate_interactive() {
    # Check if Gum is available
    if ! check_gum; then
        echo "Gum is required for interactive mode. Please install Gum first."
        return 1
    fi
    
    gum style --foreground 212 "# Interactive Prompt Generation"
    echo ""
    
    # Select template with fuzzy search
    template=$(mark template list | gum filter --placeholder "Select template for generation...")
    
    if [[ -z "$template" ]]; then
        echo "No template selected. Exiting."
        return 1
    fi
    
    echo "Selected template: $template"
    
    # Ask if user wants to provide data
    if gum confirm "Do you want to provide data for this template?"; then
        # Create temporary data file
        data_file=$(mktemp)
        
        # Collect common data fields
        echo "Collecting data for template: $template"
        echo ""
        
        # Example data collection - this would be more dynamic in a real implementation
        project_name=$(gum input --placeholder "Project name")
        echo "project_name=$project_name" >> "$data_file"
        
        author=$(gum input --placeholder "Author name")
        echo "author=$author" >> "$data_file"
        
        language=$(gum choose "Python" "JavaScript" "Go" "Java" "C++" "Other")
        echo "language=$language" >> "$data_file"
        
        # Ask for additional custom fields
        while gum confirm "Add another variable?"; do
            key=$(gum input --placeholder "Variable name")
            value=$(gum input --placeholder "Value for $key")
            echo "$key=$value" >> "$data_file"
        done
        
        # Generate with data
        output_file=$(gum input --placeholder "Output file name" --value "generated_prompt.md")
        
        gum spin --title "Generating prompt..." -- mark generate "$template" "$data_file" > "$output_file"
        
        gum style --foreground 46 "✓ Prompt generated successfully: $output_file"
        
        # Clean up
        rm "$data_file"
        
        # Ask if user wants to view the output
        if gum confirm "View the generated prompt?"; then
            gum pager < "$output_file"
        fi
    else
        # Generate without data
        output_file=$(gum input --placeholder "Output file name" --value "generated_prompt.md")
        
        gum spin --title "Generating prompt..." -- mark generate "$template" > "$output_file"
        
        gum style --foreground 46 "✓ Prompt generated successfully: $output_file"
        
        # Ask if user wants to view the output
        if gum confirm "View the generated prompt?"; then
            gum pager < "$output_file"
        fi
    fi
}