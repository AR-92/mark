#!/bin/bash

# Test script for upgrade functionality with enhanced TUI

echo "🧪 Testing Upgrade Functionality with Enhanced TUI"
echo "================================================="

# Test 1: Check if enhanced TUI file exists in project
echo ""
echo "📋 Test 1: Checking enhanced TUI file in project"
if [[ -f "/home/rana/Documents/mark/bin/mark-tui-enhanced" ]]; then
    echo "✅ Enhanced TUI file found in project"
else
    echo "❌ Enhanced TUI file not found in project"
fi

# Test 2: Check if enhanced TUI is executable
echo ""
echo "🔧 Test 2: Checking enhanced TUI executable permissions"
if [[ -x "/home/rana/Documents/mark/bin/mark-tui-enhanced" ]]; then
    echo "✅ Enhanced TUI is executable"
else
    echo "❌ Enhanced TUI is not executable"
fi

# Test 3: Check if upgrade script copies TUI files
echo ""
echo "📦 Test 3: Checking upgrade script TUI file handling"
if grep -q "mark-tui-enhanced" /home/rana/Documents/mark/lib/commands/upgrade.sh; then
    echo "✅ Upgrade script handles enhanced TUI files"
else
    echo "❌ Upgrade script does not handle enhanced TUI files"
fi

# Test 4: Check if installed version has been updated
echo ""
echo "🔄 Test 4: Checking if installed version is updated"
if [[ -f "/home/rana/.local/lib/mark/commands/upgrade.sh" ]]; then
    if grep -q "mark-tui-enhanced" /home/rana/.local/lib/mark/commands/upgrade.sh; then
        echo "✅ Installed upgrade script handles enhanced TUI files"
    else
        echo "❌ Installed upgrade script does not handle enhanced TUI files"
    fi
else
    echo "❌ Installed upgrade script not found"
fi

# Test 5: Check if main mark script references enhanced TUI
echo ""
echo "🔗 Test 5: Checking main mark script references"
if grep -q "mark-tui-enhanced" /home/rana/Documents/mark/bin/mark; then
    echo "✅ Main mark script references enhanced TUI"
else
    echo "❌ Main mark script does not reference enhanced TUI"
fi

echo ""
echo "🏁 All tests completed!"