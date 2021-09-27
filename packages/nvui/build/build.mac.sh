#!usr/bin/env bash
brew list fmt					|| brew install fmt
brew list boost				|| brew install boost
brew list qt@5				|| brew install qt@5
brew list msgpack-cxx || brew install msgpack-cxx
brew list catch2			|| brew install catch2

echo WARNING: might have to change the path of QT5_DIR based on the version of qt5 installed
# wherever the qt is installed
export Qt5_DIR=/usr/local/Cellar/qt@5/5.15.2_1/lib/cmake/Qt5
cmake -B build . -DCMAKE_BUILD_TYPE=Release
cmake --build build --target nvui --config Release
