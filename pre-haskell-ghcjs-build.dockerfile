FROM quyse/pre-haskell-build
MAINTAINER quyse

# add node.js repo
RUN curl -sL https://deb.nodesource.com/setup | bash -

# install additional stuff
RUN apt-get install -y alex happy libtinfo-dev nodejs
