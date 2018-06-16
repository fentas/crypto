FROM ubuntu:16.04

ENV VERSION=v3.9.22

RUN set -ex \
  && apt-get update \
  && apt-get install -y software-properties-common \
  && add-apt-repository -y ppa:bitcoin/bitcoin \
  && apt-get update \
  && apt-get install dirmngr -y --install-recommends \
  && apt-get install -y \
    build-essential libtool autotools-dev automake pkg-config \
    libssl-dev libevent-dev bsdmainutils libboost-all-dev \
    software-properties-common \
    libdb4.8-dev libdb4.8++-dev \
    libminiupnpc-dev libzmq3-dev \
    libqt5gui5 libqt5core5a libqt5dbus5 \
    qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler libqrencode-dev \
    git \
  && git clone https://github.com/BlocknetDX/BlockDX \
  && cd ./BlockDX \
  && git checkout tags/${VERSION} \
  && ./autogen.sh \
  && ./configure --enable-cxx --disable-shared --with-pic \
  && make \
  && make check \
  && make install \
  && cd .. \
  && rm -R ./BlockDX \
  && apt-get purge -y \
    git \
  && apt-get autoremove -y \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["blocknetdx-qt"]