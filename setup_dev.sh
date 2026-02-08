#!/bin/bash
# Development environment setup script
# Installs uv, ruff, ty and pulls custom .gitignore
#
# Usage: curl -sL https://raw.githubusercontent.com/amuir2k/python-template/main/setup_dev.sh | bash

set -e

echo "=== Python Development Environment Setup ==="

# Install uv if not present
if ! command -v uv &> /dev/null; then
    echo "Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    echo "Note: Restart your terminal or run: source ~/.zshrc"
else
    echo "uv already installed"
fi

# Install ruff and ty
echo "Installing ruff and ty..."
uv pip install ruff ty

# Pull custom .gitignore (Python + macOS + JetBrains + Claude Code)
if [ ! -f .gitignore ]; then
    echo "Downloading .gitignore..."
    curl -sL https://raw.githubusercontent.com/amuir2k/python-template/main/.gitignore -o .gitignore
    echo ".gitignore created"
else
    echo ".gitignore already exists"
fi

echo ""
echo "=== Setup Complete ==="
echo "Tools installed:"
echo "  - uv (Python package manager)"
echo "  - ruff (linter/formatter)"
echo "  - ty (type checker)"
echo ""
echo "Usage:"
echo "  ruff check --fix .   # Lint and fix"
echo "  ruff format .        # Format code"
echo "  uv run ty check .    # Type check"
