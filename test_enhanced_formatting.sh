#!/bin/bash

# Comprehensive test script for enhanced formatting functionality

echo "🧪 Testing Enhanced Formatting Functionality"
echo "=========================================="

# Test 1: Check if all required files exist
echo ""
echo "📋 Test 1: Checking required files"
files_to_check=(
    "lib/commands/help_enhanced.sh"
    "lib/commands/about_enhanced.sh"
    "lib/commands/help.sh"
    "bin/mark"
)

all_files_exist=true
for file in "${files_to_check[@]}"; do
    if [[ -f "/home/rana/Documents/mark/$file" ]]; then
        echo "✅ $file found"
    else
        echo "❌ $file not found"
        all_files_exist=false
    fi
done

if $all_files_exist; then
    echo "✅ All required files exist"
else
    echo "❌ Some required files are missing"
fi

# Test 2: Check if Gum is available
echo ""
echo "🔍 Test 2: Checking Gum availability"
if command -v gum &> /dev/null; then
    echo "✅ Gum is available"
    gum_version=$(gum --version 2>/dev/null)
    echo "   Gum version: $gum_version"
else
    echo "❌ Gum is not available"
fi

# Test 3: Test main help formatting
echo ""
echo "📖 Test 3: Testing main help formatting"
if command -v gum &> /dev/null; then
    main_help_output=$(timeout 2s ./bin/mark help 2>&1 | head -1)
    if [[ "$main_help_output" == *"🚀 MARK - AI Prompt Templating Tool"* ]]; then
        echo "✅ Formatted main help is working"
    else
        echo "❌ Formatted main help is not working"
        echo "   First line: $main_help_output"
    fi
else
    main_help_output=$(./bin/mark help | head -1)
    if [[ "$main_help_output" == "MARK - AI Prompt Templating Tool v1.0.0" ]]; then
        echo "✅ Plain text main help is working"
    else
        echo "❌ Plain text main help is not working"
        echo "   First line: $main_help_output"
    fi
fi

# Test 4: Test command-specific help formatting
echo ""
echo "📖 Test 4: Testing command-specific help formatting"
if command -v gum &> /dev/null; then
    generate_help_output=$(timeout 2s ./bin/mark help generate 2>&1 | head -1)
    if [[ "$generate_help_output" == *"📝 MARK GENERATE"* ]]; then
        echo "✅ Formatted generate help is working"
    else
        echo "❌ Formatted generate help is not working"
        echo "   First line: $generate_help_output"
    fi
else
    generate_help_output=$(./bin/mark help generate | head -1)
    if [[ "$generate_help_output" == "MARK GENERATE" ]]; then
        echo "✅ Plain text generate help is working"
    else
        echo "❌ Plain text generate help is not working"
        echo "   First line: $generate_help_output"
    fi
fi

# Test 5: Test about/info command
echo ""
echo "❓ Test 5: Testing about/info command"
if command -v gum &> /dev/null; then
    about_output=$(timeout 2s ./bin/mark about 2>&1 | head -1)
    if [[ "$about_output" == *"❓ About mark - AI Prompt Templating Tool"* ]]; then
        echo "✅ Formatted about page is working"
    else
        echo "❌ Formatted about page is not working"
        echo "   First line: $about_output"
    fi
else
    about_output=$(./bin/mark about | head -1)
    if [[ "$about_output" == "mark - AI Prompt Templating Tool v1.0.0" ]]; then
        echo "✅ Plain text about page is working"
    else
        echo "❌ Plain text about page is not working"
        echo "   First line: $about_output"
    fi
fi

# Test 6: Test info alias
echo ""
echo "❓ Test 6: Testing info alias"
if command -v gum &> /dev/null; then
    info_output=$(timeout 2s ./bin/mark info 2>&1 | head -1)
    if [[ "$info_output" == *"❓ About mark - AI Prompt Templating Tool"* ]]; then
        echo "✅ Formatted info page is working"
    else
        echo "❌ Formatted info page is not working"
        echo "   First line: $info_output"
    fi
else
    info_output=$(./bin/mark info | head -1)
    if [[ "$info_output" == "mark - AI Prompt Templating Tool v1.0.0" ]]; then
        echo "✅ Plain text info page is working"
    else
        echo "❌ Plain text info page is not working"
        echo "   First line: $info_output"
    fi
fi

# Test 7: Check if about command is in main help
echo ""
echo "📋 Test 7: Checking if about command is in main help"
if ./bin/mark help 2>&1 | grep -q "about.*Display information about mark"; then
    echo "✅ About command is listed in main help"
else
    echo "❌ About command is not listed in main help"
fi

# Test 8: Test help for about command
echo ""
echo "📖 Test 8: Testing help for about command"
if command -v gum &> /dev/null; then
    help_about_output=$(timeout 2s ./bin/mark help about 2>&1 | head -1)
    if [[ "$help_about_output" == *"❓ MARK ABOUT"* ]]; then
        echo "✅ Formatted help for about command is working"
    else
        echo "❌ Formatted help for about command is not working"
        echo "   First line: $help_about_output"
    fi
else
    help_about_output=$(./bin/mark help about | head -1)
    if [[ "$help_about_output" == "MARK ABOUT" ]]; then
        echo "✅ Plain text help for about command is working"
    else
        echo "❌ Plain text help for about command is not working"
        echo "   First line: $help_about_output"
    fi
fi

echo ""
echo "🏁 All tests completed!"