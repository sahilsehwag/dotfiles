#!usr/bin/env bash
F_isDir || git clone https://github.com/pystardust/ytfzf $SCRIPTS_REPOS/ytfzf
cd $SCRIPTS_REPOS/ytfzf && git pull
sudo make install doc
sudo make addons
