#!/usr/bin/env bash
script_directory=$(F_getScriptDir "${BASH_SOURCE:-$0}")

echo "Installing oh-my-pi..."

# Try installation methods in order of preference
if command -v bun &> /dev/null; then
    echo "Installing via bun (npm)..."
    bun install -g @oh-my-pi/pi-coding-agent
elif command -v npm &> /dev/null; then
    echo "Installing via npm..."
    npm install -g @oh-my-pi/pi-coding-agent
elif [ "$(uname)" = "Darwin" ] || [ "$(uname)" = "Linux" ]; then
    echo "Installing via curl script..."
    curl -fsSL https://omp.sh/install | sh
else
    echo "Please install manually: https://github.com/can1357/oh-my-pi#installation"
    return 1
fi

# Run setup if installation succeeded
if command -v omp &> /dev/null; then
    if [ -f "$script_directory/setup.sh" ]; then
        bash "$script_directory/setup.sh"
    fi
else
    echo "⚠ oh-my-pi installation may have failed. Please check manually."
    return 1
fi

