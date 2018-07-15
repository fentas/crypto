FROM fentas/crypto:mn-fullnode

ENV VERSION=v1.0.2

# Compile wallet
RUN set -ex \
  && git clone https://github.com/NixPlatform/NixCore \
  && cd ./NixCore \
  && git checkout tags/${VERSION} \
  && ./autogen.sh \
  && ./configure --without-gui \
  && make \
  && make check \
  && make install \
  && cd .. \
  && rm -R ./NixCore

COPY ./entrypoint.sh /

ENV PROJECT "nix"
ENV MN_NAME "ghostnode"
ENV MN_PORT "6214"
ENV RPC_PORT "8332"