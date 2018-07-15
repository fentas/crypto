#!/bin/bash
set -e

cat <<EOF
Loading ${MN_NAME:?}...

PROJECT:      ${PROJECT:?}
CLI BIN:      ${CLI_BIN:=${PROJECT}-cli}
DEAMON BIN:   ${DEAMON_BIN:=${PROJECT}d}
CONFIG FILE:  ${CONFIG_FILE:=${PROJECT}.conf}
MN PORT:      ${MN_PORT:?}

RPC PORT:     ${RPC_PORT:?}
RPC USER:     ${RPC_USER:=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c32)}
RPC PASSWORD: ${PRC_PASSWORD:=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c32)}
RPC ALLOW IP: ${RPC_ALLOW_IP:=127.0.0.1}

PRIVATE KEY: ${PRIVKEY:=$(${CLI_BIN} ${MN_NAME} genkey)}
EOF

if [ -d /.${PROJECT} ]; then
  ln -s /.${PROJECT} ~/.${PROJECT}
fi

if [ ! -d ~/.${PROJECT} ]; then
  echo "Please mount `.${PROJECT}` directory!"
  echo "  --volume \"${HOME}/.${PROJECT}:/.${PROJECT}\""
  exit 1
fi

if [ -f /bootstrap.sh ]; then
  /bootstrap.sh
fi

cat <<EOF > ~/.${PROJECT}/${PROJECT}.conf
rpcuser=${RPC_USER}
rpcpassword=${PRC_PASSWORD}
rpcallowip=${RPC_ALLOW_IP}
rpcport=${RPC_PORT}
port=${MN_PORT}
listen=1
server=1
daemon=1
logtimestamps=1
maxconnections=256
txindex=1
${MN_NAME}=1
externalip=$(dig +short myip.opendns.com @resolver1.opendns.com):${MN_PORT}
${MN_NAME}privkey=${PRIVKEY}
EOF

exec ${DEAMON_BIN}