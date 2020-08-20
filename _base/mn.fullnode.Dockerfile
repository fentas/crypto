FROM ubuntu:18.04

# Qt fullnode wallet dependencies
RUN set -ex \
  && apt-get update \
  && apt-get install -y software-properties-common \
  && add-apt-repository -y ppa:bitcoin/bitcoin \
  && apt-get update \
  && apt-get install dirmngr -y --install-recommends \
  && apt-get install -y \
    build-essential libtool autoconf autotools-dev automake pkg-config \
    libssl-dev libevent-dev bsdmainutils \
    software-properties-common \
    libboost-dev libboost-chrono-dev libboost-filesystem-dev libboost-program-options-dev \
    libboost-system-dev libboost-test-dev libboost-thread-dev \
    libdb4.8-dev libdb4.8++-dev libdb5.3++ \
    libminiupnpc-dev libgmp3-dev libzmq3-dev \
    git unzip curl \
  && apt-get autoremove -y \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*