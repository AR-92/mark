#!/bin/bash

# mark - Clear command

# Clear command
clear_logs() {
    > "$LOG_FILE"
    log "Logs cleared"
    echo "Logs cleared successfully."
}