#!/bin/sh
set -e

: ${PROJECT:?}

if [ -f "/root/.${PROJECT}/chainstate/CURRENT" ];then
  echo "[bootstrap] Nothing to do."
  exit 0
fi

curl -fsSLo Blockchain.tar.gz https://blockchain.noirofficial.org/bootstraps/noir-blockchain-2020-08-20.tar.gz
tar -xzvf Blockchain.tar.gz
mv ./blocks ./chainstate ./peers.dat /root/.${PROJECT}/
rm -R ./Blockchain.tag.gz

echo "[bootstrap] All done."