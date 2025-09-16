#!/bin/bash

# Test script for uninstall functionality

echo "🧪 Testing Uninstall Functionality"
echo "=================================="

# Test 1: Check if uninstall script handles TUI files
echo ""
echo "📋 Test 1: Checking uninstall script TUI file handling"
if grep -q "mark-tui" /home/rana/Documents/mark/lib/commands/uninstall.sh; then
    echo "✅ Uninstall script handles TUI files"
else
    echo "❌ Uninstall script does not handle TUI files"
fi

# Test 2: Check if TUI uninstall function is updated
echo ""
echo "🔧 Test 2: Checking TUI uninstall function"
if grep -q "show_dashboard" /home/rana/Documents/mark/bin/mark-tui-enhanced; then
    echo "✅ TUI uninstall function properly returns to dashboard"
else
    echo "❌ TUI uninstall function does not properly return to dashboard"
fi

# Test 3: Check if all mark files exist
echo ""
echo "📁 Test 3: Checking installed mark files"
files_to_check=(
    "/home/rana/.local/bin/mark"
    "/home/rana/.local/bin/mark-tui"
    "/home/rana/.local/bin/mark-tui-enhanced"
)

all_files_exist=true
for file in "${files_to_check[@]}"; do
    if [[ -f "$file" ]]; then
        echo "✅ $file exists"
    else
        echo "❌ $file does not exist"
        all_files_exist=false
    fi
done

if $all_files_exist; then
    echo "✅ All mark files exist"
else
    echo "❌ Some mark files are missing"
fi

# Test 4: Check if uninstall script is properly updated in installed location
echo ""
echo "🔄 Test 4: Checking installed uninstall script"
if [[ -f "/home/rana/.local/lib/mark/commands/uninstall.sh" ]]; then
    if grep -q "mark-tui" /home/rana/.local/lib/mark/commands/uninstall.sh; then
        echo "✅ Installed uninstall script handles TUI files"
    else
        echo "❌ Installed uninstall script does not handle TUI files"
    fi
else
    echo "❌ Installed uninstall script not found"
fi

echo ""
echo "🏁 All tests completed!"