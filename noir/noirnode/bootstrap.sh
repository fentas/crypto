#!/bin/sh
set -e

: ${PROJECT:?}

if [ -f "/root/.${PROJECT}/chainstate/CURRENT" ];then
  echo "[bootstrap] Nothing to do."
  exit 0
fi

curl -fsSLo Blockchain16102018.zip https://github.com/noirofficial/noir/releases/download/v1.0.0.1/Blockchain16102018.zip
unzip Blockchain16102018.zip
mv ./16102018/* /root/.${PROJECT}/
rm -R ./16102018 ./Blockchain16102018.zip

echo "[bootstrap] All done."