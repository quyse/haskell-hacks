###
# first part has been copied and adapted from https://gitlab.com/gitlab-org/gitlab-ci-multi-runner/raw/master/dockerfiles/ubuntu/Dockerfile
# changes: creation of volume /home/gitlab-runner is moved to end, in order to allow installing things into this directory

FROM ubuntu:14.04

RUN echo force-update-1 \
	apt-get update -y && \
	apt-get upgrade -y && \
	apt-get install -y ca-certificates wget apt-transport-https vim nano

RUN echo "deb https://packages.gitlab.com/runner/gitlab-ci-multi-runner/ubuntu/ `lsb_release -cs` main" > /etc/apt/sources.list.d/runner_gitlab-ci-multi-runner.list && \
	wget -q -O - https://packages.gitlab.com/gpg.key | apt-key add - && \
	apt-get update -y && \
	apt-get install -y gitlab-ci-multi-runner

ADD entrypoint /
RUN chmod +x /entrypoint

VOLUME ["/etc/gitlab-runner"]
ENTRYPOINT ["/entrypoint"]
CMD ["run", "--user=gitlab-runner", "--working-directory=/home/gitlab-runner"]


### end of gitlab-runner stuff


# add node.js repo
RUN curl -L https://deb.nodesource.com/setup | bash -

# install stuff
RUN apt-get update && apt-get install -y autoconf build-essential curl libgmp-dev git zlib1g-dev pkg-config libgl1-mesa-dev alex happy libtinfo-dev nodejs gitlab-ci-multi-runner

# get stack
RUN curl -L https://www.stackage.org/stack/linux-x86_64 | tar xz --wildcards --strip-components=1 -C /usr/bin '*/stack'

# install latest SDL
RUN curl -O https://www.libsdl.org/release/SDL2-2.0.3.tar.gz && tar xzvf SDL2-2.0.3.tar.gz && cd SDL2-2.0.3 && ./configure --prefix=/usr && make && make install && cd .. && rm -r SDL2-2.0.3*

# following installations doesn't require root
USER gitlab-runner
WORKDIR /home/gitlab-runner

# install ghc
RUN stack setup ghc-7.10.3

# install ghcjs
COPY ghcjs-setup.yaml ghcjs-setup.yaml
RUN stack setup --stack-yaml ghcjs-setup.yaml

# volume
VOLUME ["/home/gitlab-runner"]
