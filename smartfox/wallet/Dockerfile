FROM fentas/crypto:qt-fullnode

ENV VERSION=v1.2.2.1

# Compile wallet
RUN set -ex \
  && git clone https://github.com/smartfoxteam/smartfox \
  && cd ./smartfox \
  && git checkout tags/${VERSION} \
  && ./autogen.sh \
  && ./configure --enable-cxx --disable-shared --with-pic \
  && make \
  && make install \
  && cd .. \
  && rm -R ./smartfox

ENTRYPOINT ["fox-qt"]