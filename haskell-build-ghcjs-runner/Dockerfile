FROM base/archlinux

COPY mirrorlist /etc/pacman.d/mirrorlist

RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm --needed \
	autoconf make alex happy git grep pkg-config stack sdl2 openal ffmpeg nasm automake nodejs npm yarn sudo fakeroot patch pandoc vulkan-icd-loader openssh \
	clang zip emscripten python python2-virtualenv file which boost \
	ansible rsync

# install gitlab-ci-multi-runner
RUN set -ex; \
	curl -Lo /usr/bin/gitlab-runner https://gitlab-ci-multi-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-ci-multi-runner-linux-amd64; \
	chmod +x /usr/bin/gitlab-runner; \
	useradd -m -u 1000 -s /bin/bash gitlab-runner; \
	true

ENTRYPOINT ["gitlab-runner", "run", "--user=gitlab-runner", "--working-directory=/home/gitlab-runner"]
