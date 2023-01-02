#!/usr/bin/env sh

# get the latest release url from github api
url=$(curl -s https://api.github.com/repos/xiamaz/YabaiIndicator/releases/latest \
| grep "browser_download_url.*zip" \
| cut -d : -f 2,3 \
| tr -d '"' \
| tr -d ' ')

mkdir "$HOME/.cache/YabaiIndicator"
cd "$HOME/.cache/YabaiIndicator" || return

# download the release zip file
echo "Downloading YabaiIndicator release..."
curl -L "$url" -o "$HOME/.cache/YabaiIndicator/YabaiIndicator.zip"

# unzip the release
echo "unzipping yabaiindicator release..."
unzip YabaiIndicator.zip

# Run the installer
cp -R YabaiIndicator*/YabaiIndicator.app /Applications

# Clean up
echo "cleaning up..."
rm -rf "$HOME/.cache/YabaiIndicator"

echo "Installation complete!"
