#!/usr/bin/env bash
zsh -c '{url="https://gist.githubusercontent.com/poetaman/bdc598ee607e9767fe33da50e993c650/raw/8487de3cf4cf4a7feff5d3a0d97defad95164eb3/arttime_online_installer.sh"; zsh -c "$(curl -fsSL $url || wget -qO- $url)"}'
