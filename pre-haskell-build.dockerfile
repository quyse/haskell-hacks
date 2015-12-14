FROM ubuntu:14.04.3
MAINTAINER quyse

# install stuff
RUN apt-get update && apt-get install -y build-essential curl libgmp-dev git zlib1g-dev pkg-config libgl1-mesa-dev

# get stack
RUN curl -L https://www.stackage.org/stack/linux-x86_64 | tar xz --wildcards --strip-components=1 -C /usr/bin '*/stack'

# install latest SDL
RUN curl -O https://www.libsdl.org/release/SDL2-2.0.3.tar.gz && tar xzvf SDL2-2.0.3.tar.gz && cd SDL2-2.0.3 && ./configure && make && make install
