#!/bin/bash

# Project Audit Script
# Identifies duplicated, unnecessary, and obsolete files in the mark project

echo "🔍 Project Audit - Identifying Duplicated and Unnecessary Files"
echo "=================================================================="

# List all files in the project
echo ""
echo "📁 Total Files in Project:"
find . -type f -not -path "./.git/*" | wc -l

echo ""
echo "📂 File Extensions Distribution:"
find . -type f -not -path "./.git/*" -exec basename {} \; | sed 's/.*\.//' | sort | uniq -c | sort -nr | head -10

echo ""
echo "🔍 Searching for Duplicated Files by Name:"
echo "------------------------------------------"

# Check for files with similar names that might be duplicates
duplicate_patterns=("help" "config" "template" "test" "install" "upgrade" "uninstall")
for pattern in "${duplicate_patterns[@]}"; do
    count=$(find . -type f -name "*$pattern*" -not -path "./.git/*" | wc -l)
    if [[ $count -gt 1 ]]; then
        echo "  $pattern: $count files found"
        find . -type f -name "*$pattern*" -not -path "./.git/*" | sed 's/^/    /'
        echo ""
    fi
done

echo "🔍 Checking for Obsolete/Backup Files:"
echo "--------------------------------------"
find . -type f \( -name "*.bak" -o -name "*.backup" -o -name "*.old" -o -name "*.tmp" -o -name "*~" \) -not -path "./.git/*"

echo ""
echo "🔍 Checking for Large Files:"
echo "---------------------------"
find . -type f -not -path "./.git/*" -exec du -h {} + 2>/dev/null | sort -hr | head -10

echo ""
echo "🔍 Checking for Empty Files:"
echo "---------------------------"
find . -type f -empty -not -path "./.git/*"

echo ""
echo "🔍 Checking File Permissions:"
echo "----------------------------"
find . -type f -perm /111 -not -path "./.git/*" | head -10
echo "... (showing first 10 executable files)"

echo ""
echo "✅ Audit Complete!"