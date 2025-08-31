#!/bin/bash

# mark - List command

# List command
list_prompts() {
    if [[ -f "$LOG_FILE" ]] && [[ -s "$LOG_FILE" ]]; then
        # Count the number of lines containing "Generated prompt"
        local count
        count=$(grep -c "Generated prompt" "$LOG_FILE" 2>/dev/null || echo "0")
        
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