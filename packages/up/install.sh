#!/usr/bin/env sh

if F_isInstalled pacman
then
  pacman -Sy aur/up
else
  F_pkg_install up
fi
