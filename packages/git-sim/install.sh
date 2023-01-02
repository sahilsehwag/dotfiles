#!/usr/bin/env bash
F_install python

if F_isMac
then
	brew install py3cairo ffmpeg
	brew install pango scipy
elif F_isInstalled apt
then
	sudo apt update
	sudo apt install build-essential python3-dev libcairo2-dev libpango1.0-dev ffmpeg
	sudo apt install python3-pip
	sudo apt install texlive texlive-latex-extra
elif F_inInstalled dnf
then
	sudo dnf install cairo-devel pango-devel
	sudo dnf install python3-devel
	sudo dnf install ffmpeg
elif F_inInstalled pacman
then
	sudo pacman -Syu
	sudo pacman -S cairo pango ffmpeg
	sudo pacman -S python-pip
fi

pip3 install manim
pip3 install git-sim
