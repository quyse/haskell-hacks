#!/bin/bash

set -e

PKG=$1

if [ ! -d $PKG ]; then
	git clone https://aur.archlinux.org/$PKG.git /tmp/aur-$PKG
fi

chmod a+rw /tmp/aur-$PKG
pushd /tmp/aur-$PKG
sudo -u nobody MAKEFLAGS="-j$(nproc)" makepkg -c
pacman -U --noconfirm $PKG-*.pkg.tar.xz
popd
rm -rf /tmp/aur-$PKG
