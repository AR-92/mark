#!/bin/bash

# mark - List command

# List command
list_prompts() {
    if [[ -f "$LOG_FILE" ]] && [[ -s "$LOG_FILE" ]]; then
        # Count the number of lines containing "Generated prompt"
        local count
        count=$(grep -c "Generated prompt" "$LOG_FILE" 2>/dev/null || echo "0")
        
        # Make sure count is a valid number
        if ! [[ "$count" =~ ^[0-9]+$ ]]; then
            count=0
        fi
        
        if [[ "$count" -gt 0 ]]; then
            grep "Generated prompt" "$LOG_FILE" | tail -10
        else
            echo "No prompts generated yet."
        fi
    else
        echo "No prompts generated yet."
    fi
    log "Listed recent prompts"
}