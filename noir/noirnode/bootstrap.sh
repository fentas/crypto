#!/bin/sh
set -e

: ${PROJECT:?}

if [ -f "/root/.${PROJECT}/chainstate/CURRENT" ];then
  echo "[bootstrap] Nothing to do."
  exit 0
fi

curl -fsSLo Blockchain.zip https://github.com/noirofficial/noir/releases/download/v1.0.0.2/Blockchain.zip
unzip Blockchain.zip
mv ./blocks ./chainstate ./peers.dat /root/.${PROJECT}/
rm -R ./Blockchain.zip

echo "[bootstrap] All done."