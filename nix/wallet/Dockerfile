FROM fentas/crypto:qt-fullnode

ENV VERSION=v3.0.8

# Compile wallet
RUN set -ex \
  && git clone https://github.com/NixPlatform/NixCore \
  && cd ./NixCore \
  && git checkout tags/${VERSION} \
  && ./autogen.sh \
  && ./configure --enable-cxx --disable-shared --with-pic \
  && make \
  && make check \
  && make install \
  && cd .. \
  && rm -R ./NixCore

ENTRYPOINT ["nix-qt"]