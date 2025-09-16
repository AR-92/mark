#!/bin/bash

# mark - Logging
# Simple logging functionality

log() {
    local message="$1"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    # Create log directory if it doesn't exist
    mkdir -p "$(dirname "$LOG_FILE")"
    
    # Write to log file
    echo "[$timestamp] $message" >> "$LOG_FILE"
    
    # Print to stdout if debug is enabled
    if [[ "$DEBUG" == "true" ]]; then
        echo "[$timestamp] $message"
    fi
}