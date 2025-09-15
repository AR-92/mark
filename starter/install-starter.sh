#!/bin/bash

# mark - Starter Package Installation Script

echo "📦 Installing mark Starter Package..."

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Default mark templates directory
MARK_TEMPLATES_DIR="${HOME}/.mark/templates"
MARK_PARTIALS_DIR="${HOME}/.mark/partials"
MARK_DATA_DIR="${HOME}/.mark/data"

# Create directories if they don't exist
echo "📁 Creating directories..."
mkdir -p "$MARK_TEMPLATES_DIR"
mkdir -p "$MARK_PARTIALS_DIR"
mkdir -p "$MARK_DATA_DIR"

# Copy templates
echo "📋 Installing templates..."
cp -r "$SCRIPT_DIR/templates/"* "$MARK_TEMPLATES_DIR/" 2>/dev/null || echo "No templates to install"

# Copy partials
echo "📎 Installing partials..."
cp -r "$SCRIPT_DIR/partials/"* "$MARK_PARTIALS_DIR/" 2>/dev/null || echo "No partials to install"

# Copy data files
echo "📊 Installing sample data..."
cp -r "$SCRIPT_DIR/data/"* "$MARK_DATA_DIR/" 2>/dev/null || echo "No data files to install"

# Update data files to use correct paths
echo "🔧 Updating data file paths..."
sed -i "s|{{@data/sample-code.js}}|{{@../data/sample-code.js}}|g" "$MARK_DATA_DIR/../templates/"*.md 2>/dev/null || echo "No template files to update"

echo "✅ Starter package installation complete!"
echo ""
echo "🚀 Get started with mark:"
echo "   - List templates: mark template list"
echo "   - Generate a prompt: mark generate --interactive"
echo "   - Create new templates: mark template new <name> --wizard"
echo ""
echo "📖 Check out the documentation: mark help"