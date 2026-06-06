#!/usr/bin/env bash
# Setup script for agent-browser package
# Installs Chrome for Testing and initializes LLM agent tools

script_directory=$(F_getScriptDir "${BASH_SOURCE:-$0}")

echo "Setting up agent-browser for LLM tools..."

# Install Chrome for Testing
if ! agent-browser health &> /dev/null; then
    echo "Installing Chrome for Testing..."
    agent-browser install
    if [ $? -eq 0 ]; then
        echo "✓ Chrome for Testing installed"
    else
        echo "✗ Failed to install Chrome for Testing"
        return 1
    fi
fi

# Verify daemon can start
if agent-browser start &> /dev/null; then
    echo "✓ Agent-browser daemon started successfully"
    agent-browser stop &> /dev/null
else
    echo "⚠ Warning: Could not start agent-browser daemon"
fi

echo "✓ Agent-browser setup complete!"
echo ""
echo "Quick start:"
echo "  ab navigate https://example.com    # Navigate to URL"
echo "  ab screenshot output.png            # Take screenshot"
echo "  ab get-page-content                 # Extract page content"
echo ""
echo "For LLM integration, use with /code-mode:mcp-call skill"
