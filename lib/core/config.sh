#!/bin/bash

# mark - Configuration
# Default values and constants

# Configuration file path
CONFIG_FILE="$(dirname "$(dirname "$0")")/conf/mark.conf"

# Load configuration if it exists
if [[ -f "$CONFIG_FILE" ]]; then
    source "$CONFIG_FILE"
fi

# Set default values if not defined in config file
LOG_FILE="${LOG_FILE:-${HOME}/.mark.log}"
TEMPLATE_DIR="${TEMPLATE_DIR:-${HOME}/.mark/templates}"

# Ensure directories exist
mkdir -p "$TEMPLATE_DIR"