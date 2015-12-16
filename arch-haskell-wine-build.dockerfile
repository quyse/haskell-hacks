FROM base/archlinux
MAINTAINER quyse

RUN echo -e "[multilib]\nInclude = /etc/pacman.d/mirrorlist\n" >> /etc/pacman.conf
RUN pacman -Sy --noconfirm archlinux-keyring
RUN pacman -Su --noconfirm
RUN pacman-db-upgrade
RUN pacman -S --noconfirm wine-staging
RUN pacman -S --noconfirm unzip
ENV STAGING_WRITECOPY=1
RUN wineboot
RUN curl -JOL https://www.stackage.org/stack/windows-x86_64 && unzip stack-*.zip stack.exe -d ~/.wine/drive_c/windows/system32 && rm stack-*.zip
RUN wine64 stack setup 7.10.2
