FROM ubuntu:16.04

# Qt fullnode wallet dependencies
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
    git unzip curl \
  && apt-get autoremove -y \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*