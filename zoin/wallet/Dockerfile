FROM fentas/crypto:qt-fullnode

ENV VERSION=v0.13.1.6

# Compile wallet
RUN set -ex \
  && git clone https://github.com/zoinofficial/zoin \
  && cd ./zoin \
  && git checkout tags/${VERSION} \
  && ./autogen.sh \
  && ./configure --enable-cxx --disable-shared --with-pic \
  && make \
  && make check \
  && make install \
  && cd .. \
  && rm -R ./zoin

ENTRYPOINT ["zoin-qt"]