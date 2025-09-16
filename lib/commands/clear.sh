#!/bin/bash

# mark - Clear Command
# Clear logs

clear_logs() {
    if [[ -f "$LOG_FILE" ]]; then
        rm "$LOG_FILE"
        echo "Logs cleared."
        log "Logs cleared"
    else
        echo "No logs to clear."
    fi
}