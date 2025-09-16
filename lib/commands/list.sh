#!/bin/bash

# mark - List Command
# List recently generated prompts

list_prompts() {
    echo "Recently generated prompts:"
    echo "=========================="
    
    # Show last 10 lines of log file
    if [[ -f "$LOG_FILE" ]]; then
        tail -10 "$LOG_FILE"
    else
        echo "No prompts generated yet."
    fi
}