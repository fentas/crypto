FROM fentas/crypto:qt-fullnode

ENV VERSION=v3.9.22

# Compile wallet
RUN set -ex \
  && git clone https://github.com/BlocknetDX/BlockDX \
  && cd ./BlockDX \
  && git checkout tags/${VERSION} \
  && ./autogen.sh \
  && ./configure --enable-cxx --disable-shared --with-pic \
  && make \
  && make install \
  && cd .. \
  && rm -R ./BlockDX \
  && apt-get purge -y \
    git \
  && apt-get autoremove -y \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["blocknetdx-qt"]