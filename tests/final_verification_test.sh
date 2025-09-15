#!/bin/bash

# Final verification test

echo "=== Final Verification Test ==="

# Test 1: Local installation removal
echo "1. Checking local installation removal..."
if [[ ! -f "/home/rana/.local/bin/mark" ]] && [[ ! -d "/home/rana/.local/lib/mark" ]]; then
    echo "   ✅ Local installation successfully removed"
else
    echo "   ❌ Local installation not fully removed"
fi

# Test 2: Global installation check
echo "2. Checking global installation..."
if [[ ! -f "/usr/local/bin/mark" ]]; then
    echo "   ✅ No global installation found"
else
    echo "   ⚠️  Global installation still exists"
fi

# Test 3: Configuration preservation
echo "3. Checking configuration preservation..."
if [[ -d "$HOME/.mark" ]] && [[ -f "$HOME/.mark/config.data" ]]; then
    echo "   ✅ Configuration directory preserved"
else
    echo "   ❌ Configuration directory missing"
fi

# Test 4: Development version availability
echo "4. Checking development version..."
if [[ -f "/home/rana/Documents/mark/bin/mark" ]]; then
    dev_version=$(/home/rana/Documents/mark/bin/mark version 2>/dev/null)
    if [[ "$dev_version" == "mark 1.0.0" ]]; then
        echo "   ✅ Development version available"
    else
        echo "   ❌ Development version not working properly"
    fi
else
    echo "   ❌ Development version missing"
fi

# Test 5: PATH command availability
echo "5. Checking PATH command availability..."
path_mark=$(which mark)
if [[ "$path_mark" == "/home/rana/Documents/mark/bin/mark" ]]; then
    echo "   ✅ Development version in PATH"
else
    echo "   ❌ Unexpected mark command in PATH: $path_mark"
fi

echo "=== Final Verification Complete ==="