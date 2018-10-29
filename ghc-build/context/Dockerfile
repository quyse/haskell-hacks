FROM base/archlinux

COPY mirrorlist /etc/pacman.d/mirrorlist

# install packages stuff
RUN pacman -Syu --needed --noconfirm \
	ghc-static autoconf make alex happy git pkg-config nasm automake patch python cabal-install stack

RUN useradd -m -s /bin/bash -u 1000 builder

USER builder
WORKDIR /home/builder
