#!/bin/bash

# mark - Upgrade command
# Upgrade mark CLI tool from GitHub repository

# Upgrade function
upgrade_mark() {
    echo "⬆️  mark Upgrader"
    echo ""
    
    # Confirm upgrade
    echo "This will upgrade mark to the latest version from GitHub."
    echo "Your templates and configuration will be preserved."
    echo ""
    
    read -p "Continue with upgrade? (y/N): " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Upgrade cancelled."
        return 0
    fi
    
    echo ""
    echo "Upgrading mark..."
    
    # Create temporary directory
    local temp_dir=$(mktemp -d)
    
    # Clone repository
    echo "  📦 Downloading latest version..."
    if ! git clone --quiet https://github.com/AR-92/mark.git "$temp_dir/mark" 2>/dev/null; then
        echo "  ❌ Failed to download from GitHub"
        rm -rf "$temp_dir"
        return 1
    fi
    
    # Check if this is actually an upgrade
    local current_version="1.0.0"
    local new_version=$(cd "$temp_dir/mark" && bin/mark version 2>/dev/null | head -1)
    
    if [[ "$new_version" == "$current_version" ]]; then
        echo "  ℹ️  Already running the latest version ($current_version)"
        rm -rf "$temp_dir"
        return 0
    fi
    
    # Backup current installation
    echo "  🔁 Backing up current installation..."
    local backup_dir="$HOME/.mark_backup_$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$backup_dir"
    
    # Copy current executable and lib files to backup
    if [[ -f "$HOME/.local/bin/mark" ]]; then
        cp "$HOME/.local/bin/mark" "$backup_dir/"
    fi
    
    if [[ -d "$HOME/.local/lib/mark" ]]; then
        cp -r "$HOME/.local/lib/mark" "$backup_dir/"
    fi
    
    # Also backup TUI files if they exist
    if [[ -f "$HOME/.local/bin/mark-tui" ]]; then
        cp "$HOME/.local/bin/mark-tui" "$backup_dir/"
    fi
    
    if [[ -f "$HOME/.local/bin/mark-tui-enhanced" ]]; then
        cp "$HOME/.local/bin/mark-tui-enhanced" "$backup_dir/"
    fi
    
    echo "  ✅ Backup created at $backup_dir"
    
    # Install new version
    echo "  🚀 Installing new version..."
    
    # Copy new executable
    if [[ -f "$temp_dir/mark/bin/mark" ]]; then
        cp "$temp_dir/mark/bin/mark" "$HOME/.local/bin/"
        chmod +x "$HOME/.local/bin/mark"
    fi
    
    # Copy all TUI files
    if [[ -f "$temp_dir/mark/bin/mark-tui" ]]; then
        cp "$temp_dir/mark/bin/mark-tui" "$HOME/.local/bin/"
        chmod +x "$HOME/.local/bin/mark-tui"
    fi
    
    if [[ -f "$temp_dir/mark/bin/mark-tui-enhanced" ]]; then
        cp "$temp_dir/mark/bin/mark-tui-enhanced" "$HOME/.local/bin/"
        chmod +x "$HOME/.local/bin/mark-tui-enhanced"
    fi
    
    # Copy new lib files
    if [[ -d "$temp_dir/mark/lib" ]]; then
        # Remove old lib files
        rm -rf "$HOME/.local/lib/mark"
        # Create new lib directory
        mkdir -p "$HOME/.local/lib/mark"
        # Copy new lib files
        cp -r "$temp_dir/mark/lib/"* "$HOME/.local/lib/mark/"
    fi
    
    # Clean up
    rm -rf "$temp_dir"
    
    echo "  ✅ mark has been successfully upgraded to $new_version!"
    echo ""
    echo "What's new in this version:"
    echo "  - Enhanced TUI with completely box-free interface"
    echo "  - Solarized blue color scheme"
    echo "  - Improved navigation and flow"
    echo "  - Better visual styling and animations"
    echo "  - Enhanced upgrade functionality"
    echo "  - Improved error handling"
    echo "  - Bug fixes and performance improvements"
    echo ""
    echo "Backup of previous version: $backup_dir"
    echo ""
}