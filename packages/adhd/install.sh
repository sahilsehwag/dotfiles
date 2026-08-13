#!/usr/bin/env bash

echo "Installing UditAkhourii/adhd via the official skills CLI..."
echo "  This will add the adhd skill globally for all supported agents (Claude Code, Cursor, etc)."
echo "  Using --all -g -y for non-interactive global install."

npx --registry=https://registry.npmjs.org --yes skills@latest add UditAkhourii/adhd -g --all

echo ""
echo "✓ UditAkhourii/adhd installed successfully."
echo ""
echo "ADHD is a reasoning framework that fans out parallel divergent thoughts under"
echo "different cognitive frames, scores/prunes traps, then deepens the survivors."
echo "Best for design decisions, fuzzy debugging, naming, and API surface design."
echo ""
echo "Manage skills later with:"
echo "  npx --yes skills@latest list -g"
echo "  npx --yes skills@latest remove adhd"
echo ""
