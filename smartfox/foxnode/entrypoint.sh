#!/bin/bash
set -e

: ${MN_NAME:?}
: ${MN_CMD:=${MN_NAME}}
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
: ${EXTERNAL_IP:=$(curl --connect-timeout 2 -s4 https://icanhazip.com)}

if [ "$1" != "${DEAMON_BIN}" ]; then
  exec "$@"
fi
if [ "${1:0:1}" = '-' ]; then
	set -- "${DEAMON_BIN}" "$@"
fi

if [ -d "/.${PROJECT}" ] && [ ! -d "/root/.${PROJECT}" ]; then
  ln -s "/.${PROJECT}" "/root/.${PROJECT}"
fi

if [ ! -d ~/.${PROJECT} ]; then
  echo "Please mount `.${PROJECT}` directory!"
  echo "  --volume \"${HOME}/.${PROJECT}:/.${PROJECT}\""
  exit 1
fi

if [ -f /bootstrap.sh ]; then
  /bootstrap.sh
fi

if [ ! -f /root/.${PROJECT}/${PROJECT}.conf ]; then
  ${DEAMON_BIN} -daemon
  until ${CLI_BIN} getnetworkinfo 2>/dev/null; do sleep 1; done
  PRIVKEY="${PRIVKEY:-$(${CLI_BIN} ${MN_CMD} genkey)}"
  ${CLI_BIN} stop
cat <<EOF > /root/.${PROJECT}/${PROJECT}.conf
rpcuser=${RPC_USER}
rpcpassword=${PRC_PASSWORD}
rpcallowip=${RPC_ALLOW_IP}
rpcport=${RPC_PORT}
port=${MN_PORT}
listen=1
server=1
daemon=0
logtimestamps=1
maxconnections=256
txindex=1
${MN_NAME}=1
externalip=${EXTERNAL_IP}
masternodeaddr=${EXTERNAL_IP}
bind=${EXTERNAL_IP}:${MN_PORT}
${MN_NAME}privkey=${PRIVKEY}
addnode=192.241.194.150:40428
addnode=178.128.2.124:40428
addnode=37.139.25.58:40428
addnode=206.189.100.225:40428
addnode=159.65.139.141:40428
addnode=178.128.32.73:40428
EOF
fi

if [ "$#" -eq 0 ]; then
  set -- "${DEAMON_BIN}" "-conf=${CONFIG_FOLDER}/${CONFIG_FILE}" "-datadir=${CONFIG_FOLDER}"
fi

cleanup()
{
  if [ "$(ps -C ${DEAMON_BIN} -o pid | wc -l)" -eq 2 ]; then
    kill $(ps -C ${DEAMON_BIN} -o pid | tail -1)
  fi
}
trap cleanup 1 2 3 6

"$@"
sleep 5
while test "$(ps -C ${DEAMON_BIN} -o pid | wc -l)" -eq 2; do
  sleep 1
done