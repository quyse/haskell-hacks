#!/bin/bash

set -e

VERSION=8.6.5
BRANCH=ghc-$VERSION-release

# get sources
git clone https://gitlab.haskell.org/ghc/ghc.git -b $BRANCH --depth 1 --recursive

# configure and make
pushd ghc
patch -p1 < /data/scripts/ghc.patch
cp mk/build.mk{.sample,}
./boot
./configure
make -j$(nproc)
make binary-dist
popd

cp ghc/ghc-$VERSION-*.tar.xz /data/ghc-$VERSION-integersimple.tar.xz
