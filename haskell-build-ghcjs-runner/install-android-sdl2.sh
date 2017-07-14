#!/bin/bash

set -e

export TOOLCHAIN=/opt/android-ndk-toolchain-arm
export PATH=$TOOLCHAIN/bin:$PATH

curl -L https://www.libsdl.org/release/SDL2-2.0.5.tar.gz | tar xzf -
pushd SDL2-2.0.5

CFLAGS='-std=gnu99 -fPIC' ./configure \
	--host arm-linux-androideabi \
	--prefix $TOOLCHAIN/sysroot/usr \
	--disable-shared \
	--disable-audio \
	--disable-video-x11 \
	--disable-video-wayland \
	--disable-video-opengles1
make -j$(nproc)
make install
popd
rm -r SDL2-2.0.5
