#!/bin/bash

PKG=$1

if [ ! -d $PKG ]; then git clone https://aur.archlinux.org/$PKG.git $PKG; fi \
	&& chmod a+rw $PKG \
	&& cd $PKG \
	&& sudo -u nobody makepkg -c \
	&& pacman -U --noconfirm $PKG-*.pkg.tar.xz \
	&& cd .. \
	&& rm -rf $PKG
