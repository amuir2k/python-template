#!/bin/bash
# Development environment setup script
# Installs uv, pulls pyproject.toml and .gitignore, syncs dependencies
#
# Usage: curl -sL https://raw.githubusercontent.com/amuir2k/python-template/main/setup_dev.sh | bash

set -e

REPO_URL="https://raw.githubusercontent.com/amuir2k/python-template/main"

echo "=== Python Development Environment Setup ==="

# Install uv if not present
if ! command -v uv &> /dev/null; then
    echo "Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    echo "Note: Restart your terminal or run: source ~/.zshrc"
else
    echo "uv already installed"
fi

# Pull pyproject.toml (loguru + ruff/ty dev deps)
if [ ! -f pyproject.toml ]; then
    echo "Downloading pyproject.toml..."
    curl -sL "$REPO_URL/pyproject.toml" -o pyproject.toml
    echo "pyproject.toml created"
else
    echo "pyproject.toml already exists"
fi

# Pull custom .gitignore (Python + macOS + JetBrains + Claude Code)
if [ ! -f .gitignore ]; then
    echo "Downloading .gitignore..."
    curl -sL "$REPO_URL/.gitignore" -o .gitignore
    echo ".gitignore created"
else
    echo ".gitignore already exists"
fi

# Sync all dependencies including dev
echo "Installing dependencies..."
uv sync --all-extras

echo ""
echo "=== Setup Complete ==="
echo "Installed:"
echo "  - uv (Python package manager)"
echo "  - loguru (logging)"
echo "  - ruff (linter/formatter)"
echo "  - ty (type checker)"
echo ""
echo "Usage:"
echo "  uv run ruff check --fix .   # Lint and fix"
echo "  uv run ruff format .        # Format code"
echo "  uv run ty check .           # Type check"
