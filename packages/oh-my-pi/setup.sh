#!/usr/bin/env bash
# Setup script for oh-my-pi package
# Initialize configuration and verify installation

script_directory=$(F_getScriptDir "${BASH_SOURCE:-$0}")

echo "Setting up oh-my-pi (omp)..."

# Check installation
if ! command -v omp &> /dev/null; then
    echo "✗ oh-my-pi not found in PATH"
    return 1
fi

# Verify version
omp --version
if [ $? -eq 0 ]; then
    echo "✓ oh-my-pi installed successfully"
fi

# Initialize shell completions
echo "Generating shell completions..."
if command -v zsh &> /dev/null; then
    omp completion zsh > ~/.zsh/completions/_omp 2>/dev/null
    echo "✓ Zsh completions generated"
fi

if command -v bash &> /dev/null; then
    omp completion bash > ~/.bash_completion.d/omp 2>/dev/null || true
    echo "✓ Bash completions generated"
fi

echo ""
echo "✓ oh-my-pi setup complete!"
echo ""
echo "Quick start:"
echo "  omp                 # Start interactive session"
echo "  omp 'your task'     # Run specific task"
echo "  omp /help           # View available commands"
echo ""
echo "Configuration:"
echo "  ~/.oh-my-pi/       # Config directory"
echo ""
echo "For LLM integration, use with Claude Code or other AI tools"
