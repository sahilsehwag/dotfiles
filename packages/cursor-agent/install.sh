#!/usr/bin/env bash

echo "Installing Cursor CLI (agent) via the official installer..."
echo "  curl https://cursor.com/install -fsS | bash"
echo "  This installs the 'agent' binary (and may update itself)."

curl https://cursor.com/install -fsS | bash

echo ""
echo "✓ Cursor CLI installed."
echo ""
echo "Post-install (per docs):"
echo "  Add ~/.local/bin to your PATH if not already (the dotfiles preset helps with ~/.local):"
echo "    For zsh: echo 'export PATH=\"\$HOME/.local/bin:\$PATH\"' >> ~/.zshrc && source ~/.zshrc"
echo ""
echo "Verify:"
echo "  agent --version"
echo ""
echo "Usage: agent"
echo "Update: agent update"
echo ""
