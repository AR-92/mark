#!/bin/bash

# mark - Fixed Installation Script

echo "Installing mark AI prompt templating tool..."

# Check if we're in the correct directory
if [[ ! -f "mark" ]]; then
    echo "Error: mark script not found in current directory"
    echo "Please run this script from the mark project directory"
    exit 1
fi

# Make mark executable
chmod +x mark

# Ask user if they want to install globally
echo ""
echo "Do you want to install mark globally (/usr/local/bin) or locally (~/.local/bin)?"
echo "1) Global installation (requires sudo)"
echo "2) Local installation"
echo "3) Skip installation (use from current directory)"

read -p "Enter choice (1-3): " choice

case $choice in
    1)
        # Global installation
        echo "Installing globally..."
        # Copy the main executable
        sudo cp mark /usr/local/bin/
        if [[ $? -eq 0 ]]; then
            # Create the lib directory structure
            sudo mkdir -p /usr/local/lib/mark
            sudo cp -r ../lib/* /usr/local/lib/mark/
            echo "mark installed successfully to /usr/local/bin/"
            echo "Library files installed to /usr/local/lib/mark/"
            echo "You can now use 'mark' from anywhere"
        else
            echo "Failed to install mark globally"
            exit 1
        fi
        ;;
    2)
        # Local installation
        echo "Installing locally..."
        mkdir -p ~/.local/bin
        cp mark ~/.local/bin/
        if [[ $? -eq 0 ]]; then
            # Create the lib directory structure
            mkdir -p ~/.local/lib/mark
            cp -r ../lib/* ~/.local/lib/mark/
            echo "mark installed successfully to ~/.local/bin/"
            echo "Library files installed to ~/.local/lib/mark/"
            echo "Make sure ~/.local/bin is in your PATH"
            echo "Add this line to your ~/.bashrc or ~/.zshrc if needed:"
            echo "export PATH=\"$HOME/.local/bin:\$PATH\""
        else
            echo "Failed to install mark locally"
            exit 1
        fi
        ;;
    3)
        # Skip installation
        echo "Skipping installation. You can use mark from the current directory:"
        echo "./mark generate template.md data.md"
        ;;
    *)
        echo "Invalid choice. Skipping installation."
        ;;
esac

echo ""
echo "Installation complete!"
echo ""
echo "Try running the test suite:"
echo "./tests/final_tests.sh"
echo ""
echo "Or try the example:"
echo "./mark generate example_template.md example_data.md"
echo ""
echo "For help:"
echo "./mark help"