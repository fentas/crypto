#!/bin/bash
set -e

: ${MN_NAME:?}
: ${PROJECT:?}
: ${CLI_BIN:=${PROJECT}-cli}
: ${DEAMON_BIN:=${PROJECT}d}
: ${CONFIG_FILE:=${PROJECT}.conf}
: ${CONFIG_FOLDER:=/root/.${PROJECT}}
: ${MN_PORT:?}
: ${RPC_PORT:?}
: ${RPC_USER:=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c32)}
: ${PRC_PASSWORD:=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c32)}
: ${RPC_ALLOW_IP:=127.0.0.1}

if [ "${1:0:1}" = '-' ]; then
	set -- "${DEAMON_BIN}" "$@"
fi

if [ -d "/.${PROJECT}" ]; then
  ln -s "/.${PROJECT}" "~/.${PROJECT}"
fi

if [ "$1" = "${DEAMON_BIN}" ]; then

  if [ ! -d ~/.${PROJECT} ]; then
    echo "Please mount `.${PROJECT}` directory!"
    echo "  --volume \"${HOME}/.${PROJECT}:/.${PROJECT}\""
    exit 1
  fi

  if [ -f /bootstrap.sh ]; then
    /bootstrap.sh
  fi

  ${DEAMON_BIN} -daemon
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
${MN_NAME}privkey=${PRIVKEY:=$(${CLI_BIN} ${MN_NAME} genkey)}
EOF
  ${CLI_BIN} stop

  if [ "$#" -eq 0 ]; then
    set -- "${DEAMON_BIN}" "-daemon" "-conf=${CONFIG_FOLDER}/${CONFIG_FILE}" "-datadir=${CONFIG_FOLDER}"
  fi
fi

exec "$@"