FROM node:11-alpine

ENV VERSION=v1.0.0

# Install packages
RUN set -ex \
  apk add --no-cache \
    git

# Compile wallet
RUN set -ex \
  && git clone https://github.com/nixplatform/nix-gui \
  && cd nix-gui \
  && git checkout tags/${VERSION} \
  && yarn install

WORKDIR /nix-gui

ENTRYPOINT ["yarn", "run", "start:electron:fast"]