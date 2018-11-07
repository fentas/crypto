FROM fentas/crypto:mn-fullnode

ENV VERSION=v1.0.0.2

# Compile wallet
RUN set -ex \
  && git clone https://github.com/noirofficial/noir \
  && cd ./noir \
  && git checkout tags/${VERSION} \
  && ./autogen.sh \
  && ./configure --without-gui \
  && make CFLAGS=-fPIC \
  && make check \
  && make install \
  && cd .. \
  && rm -R ./noir

COPY ./bootstrap.sh /
COPY ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

ENV PROJECT "noir"
ENV MN_NAME "nnode"
ENV MN_CMD "noirnode"
ENV MN_PORT "8255"
ENV RPC_PORT "8822"