#!/bin/bash

# Test script for enhanced TUI functionality

echo "🧪 Testing Enhanced TUI Functionality"
echo "==================================="

# Test 1: Check if enhanced TUI file exists
echo ""
echo "📋 Test 1: Checking enhanced TUI file"
if [[ -f "/home/rana/Documents/mark/bin/mark-tui-enhanced" ]]; then
    echo "✅ Enhanced TUI file found"
else
    echo "❌ Enhanced TUI file not found"
fi

# Test 2: Check if enhanced TUI is executable
echo ""
echo "🔧 Test 2: Checking enhanced TUI executable permissions"
if [[ -x "/home/rana/Documents/mark/bin/mark-tui-enhanced" ]]; then
    echo "✅ Enhanced TUI is executable"
else
    echo "❌ Enhanced TUI is not executable"
fi

# Test 3: Check syntax
echo ""
echo "🔍 Test 3: Checking enhanced TUI syntax"
if bash -n /home/rana/Documents/mark/bin/mark-tui-enhanced 2>/dev/null; then
    echo "✅ Enhanced TUI syntax is valid"
else
    echo "❌ Enhanced TUI syntax is invalid"
fi

# Test 4: Check if main mark script references enhanced TUI
echo ""
echo "🔗 Test 4: Checking main mark script references"
if grep -q "mark-tui-enhanced" /home/rana/Documents/mark/bin/mark; then
    echo "✅ Main mark script references enhanced TUI"
else
    echo "❌ Main mark script does not reference enhanced TUI"
fi

# Test 5: Check if help system mentions enhanced features
echo ""
echo "📖 Test 5: Checking help system updates"
if grep -q "Solarized blue color scheme" /home/rana/Documents/mark/lib/commands/help_enhanced.sh; then
    echo "✅ Help system mentions enhanced features"
else
    echo "❌ Help system does not mention enhanced features"
fi

echo ""
echo "🏁 All tests completed!"