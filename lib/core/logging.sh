#!/bin/bash

# mark - Logging utilities

# Logging function
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}