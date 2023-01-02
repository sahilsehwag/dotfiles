cd $DOTFILES_REPOS
mkdir port
cd port
curl -O https://distfiles.macports.org/MacPorts/MacPorts-2.7.2.tar.bz2
tar xf MacPorts-2.7.2.tar.bz2
cd MacPorts-2.7.2/
./configure
make
sudo make install
