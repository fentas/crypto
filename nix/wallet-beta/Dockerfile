FROM ubuntu:18.04

ENV NIXGUI 1.0.0
ENV NIXD 2.1.0

RUN set -ex \
  && apt-get update \
  && apt-get install -y \
    libasound2 \
    curl \
  && curl -fsSLo wallet.deb https://github.com/NixPlatform/Nix-GUI/releases/download/v${NIXGUI}/nix-wallet-${NIXGUI}-linux-amd64.deb \
  && dpkg -i wallet.deb || true \
  && apt-get install -f -y \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /src/*.deb \
  && curl -fsSLo nix.tar.gz https://github.com/NixPlatform/NixCore/releases/download/v${NIXD}/nix-${NIXD}-x86_64-linux-gnu.tar.gz \
  && tar xzvf nix.tar.gz \
  && rm /nix-${NIXD}/bin/nix-qt \
  && ln -s /nix-${NIXD}/bin/nixd /bin/

ENTRYPOINT ["nix-wallet"]