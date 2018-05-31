#!/bin/bash

set -e

VERSION=8.4.2

# get sources
git config --global url."git://github.com/ghc/packages-".insteadOf     git://github.com/ghc/packages/
git config --global url."http://github.com/ghc/packages-".insteadOf    http://github.com/ghc/packages/
git config --global url."https://github.com/ghc/packages-".insteadOf   https://github.com/ghc/packages/
git config --global url."ssh://git@github.com/ghc/packages-".insteadOf ssh://git@github.com/ghc/packages/
git config --global url."git@github.com:/ghc/packages-".insteadOf      git@github.com:/ghc/packages/
git clone https://github.com/ghc/ghc.git -b ghc-$VERSION-release --depth 1 --recursive

# configure and make
pushd ghc
patch -p1 < ~/ghc.patch
cp mk/build.mk{.sample,}
./boot
./configure
make -j$(nproc)
make binary-dist
popd

cp ghc/ghc-$VERSION-*.tar.xz /data/ghc-$VERSION-integersimple.tar.xz
