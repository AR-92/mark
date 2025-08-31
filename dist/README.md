# Distribution Packages

This directory contains distribution packages for the mark tool.

## Creating a Distribution Package

To create a distribution package, run:

```bash
# Create a tarball
tar -czf mark-$(git describe --tags).tar.gz --exclude='dist' --exclude='.git' .

# Move to dist directory
mv mark-*.tar.gz dist/
```

## Available Packages

Distribution packages will be listed here when available.