#!/bin/bash

# Gum Integration Setup Script for mark
# This script helps set up Gum integration for mark

echo "Setting up Gum integration for mark..."

# Check if Gum is installed
if ! command -v gum &> /dev/null; then
    echo "Gum is not installed. Installing Gum..."
    
    # Detect OS and install accordingly
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        if command -v brew &> /dev/null; then
            brew install gum
        else
            echo "Homebrew not found. Please install Homebrew first: https://brew.sh/"
            exit 1
        fi
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        if command -v apt &> /dev/null; then
            # Debian/Ubuntu
            sudo mkdir -p /etc/apt/keyrings
            curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
            echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
            sudo apt update && sudo apt install gum
        elif command -v yum &> /dev/null; then
            # Red Hat/CentOS
            echo '[charm]
name=Charm
baseurl=https://repo.charm.sh/yum/
enabled=1
gpgkey=https://repo.charm.sh/yum/gpg.key' | sudo tee /etc/yum.repos.d/charm.repo
            sudo yum install gum
        else
            echo "Unsupported package manager. Please install Gum manually: https://github.com/charmbracelet/gum#installation"
            exit 1
        fi
    else
        echo "Unsupported OS. Please install Gum manually: https://github.com/charmbracelet/gum#installation"
        exit 1
    fi
else
    echo "Gum is already installed."
fi

# Verify installation
if command -v gum &> /dev/null; then
    echo "Gum installation verified successfully!"
    echo ""
    echo "You can now use interactive features in mark:"
    echo "  mark template interactive"
    echo ""
    echo "Try it out:"
    echo "  mark template interactive"
else
    echo "Gum installation failed. Please install manually: https://github.com/charmbracelet/gum#installation"
    exit 1
fi