#!/bin/bash

set -e

docker build -t haskell-hacks-ghc-builder context
docker run --rm -v $PWD:/data haskell-hacks-ghc-builder /data/scripts/build-ghc.sh
