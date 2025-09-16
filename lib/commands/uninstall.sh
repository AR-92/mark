#!/bin/bash

# mark - Uninstall command
# Uninstall mark CLI tool

# Uninstall function
uninstall_mark() {
    echo "🗑️  mark Uninstaller"
    echo ""
    
    # Confirm uninstallation
    echo "This will completely remove mark from your system."
    echo "The following will be removed:"
    echo "  - $HOME/.local/bin/mark"
    echo "  - $HOME/.local/bin/mark-tui"
    echo "  - $HOME/.local/bin/mark-tui-enhanced"
    echo "  - $HOME/.local/lib/mark/"
    echo "  - Configuration files in $HOME/.mark/"
    echo ""
    
    read -p "Are you sure you want to uninstall mark? (y/N): " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Uninstallation cancelled."
        return 0
    fi
    
    echo ""
    echo "Uninstalling mark..."
    
    # Remove executables
    if [[ -f "$HOME/.local/bin/mark" ]]; then
        rm -f "$HOME/.local/bin/mark"
        echo "  ✅ Removed $HOME/.local/bin/mark"
    fi
    
    # Remove TUI files
    if [[ -f "$HOME/.local/bin/mark-tui" ]]; then
        rm -f "$HOME/.local/bin/mark-tui"
        echo "  ✅ Removed $HOME/.local/bin/mark-tui"
    fi
    
    if [[ -f "$HOME/.local/bin/mark-tui-enhanced" ]]; then
        rm -f "$HOME/.local/bin/mark-tui-enhanced"
        echo "  ✅ Removed $HOME/.local/bin/mark-tui-enhanced"
    fi
    
    # Remove library directory
    if [[ -d "$HOME/.local/lib/mark" ]]; then
        rm -rf "$HOME/.local/lib/mark"
        echo "  ✅ Removed $HOME/.local/lib/mark/"
    fi
    
    # Ask user if they want to remove configuration files
    echo ""
    echo "Configuration files are located in $HOME/.mark/"
    echo "These contain your templates and settings."
    echo ""
    read -p "Do you also want to remove configuration files? (y/N): " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        if [[ -d "$HOME/.mark" ]]; then
            rm -rf "$HOME/.mark"
            echo "  ✅ Removed $HOME/.mark/"
        fi
    else
        echo "  ℹ️  Configuration files kept at $HOME/.mark/"
    fi
    
    echo ""
    echo "✅ mark has been successfully uninstalled!"
    echo ""
    echo "To reinstall mark in the future, download it from:"
    echo "https://github.com/AR-92/mark"
    echo ""
}