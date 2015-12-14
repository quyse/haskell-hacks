FROM quyse/pre-haskell-build:latest
MAINTAINER quyse

# setup GHC
RUN stack setup 7.10.2
