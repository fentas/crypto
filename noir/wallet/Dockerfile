FROM fentas/crypto:qt-fullnode

ENV VERSION=v1.0.0.0

# Compile wallet
RUN set -ex \
  && git clone https://github.com/noirofficial/noir \
  && cd ./noir \
  && git checkout tags/${VERSION} \
  && ./autogen.sh \
  && ./configure --enable-cxx --disable-shared --with-pic \
  && make \
  && make check \
  && make install \
  && cd .. \
  && rm -R ./noir

ENTRYPOINT ["noir-qt"]