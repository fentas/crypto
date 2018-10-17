FROM fentas/crypto:mn-fullnode

ENV VERSION=v1.2.2.1

# Compile wallet
RUN set -ex \
  && git clone https://github.com/smartfoxteam/smartfox \
  && cd ./smartfox \
  && git checkout tags/${VERSION} \
  && ./autogen.sh \
  && ./configure --without-gui \
  && make CFLAGS=-fPIC \
  && make install \
  && cd .. \
  && rm -R ./smartfox

COPY ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD ["foxd"]

ENV PROJECT "fox"
ENV MN_NAME "masternode"
ENV MN_PORT "40428"
ENV RPC_PORT "40424"