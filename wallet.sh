#!/bin/sh
set -e

install_docker() {
  curl -fsSL https://get.docker.com -o /tmp/get-docker.sh
  sh /tmp/get-docker.sh
  sudo usermod -aG docker $USER
  echo "... Log out and log back so that your group membership is re-evaluated!"
}

install_dependencies() {
  echo "Installing dependencies (jq and curl) ..."
  sudo apt-get update
  sudo apt-get install -y jq curl
}

install_coin() {
  echo "\nSetting up coin wallet ..."
  sudo curl -fsSL -o /usr/local/bin/${COIN} \
    https://raw.githubusercontent.com/fentas/crypto/master/${COIN}/wallet/bin/${COIN}
  sudo chmod +x /usr/local/bin/${COIN}
  echo "✔ ${COIN} executable"
  # Install desktop shortcut
  if [ -d /usr/share/applications ]; then
    sudo curl -fsSL -o /usr/share/applications/${COIN}.desktop \
      https://raw.githubusercontent.com/fentas/crypto/master/${COIN}/wallet/${COIN}.desktop
    sudo chmod +x /usr/share/applications/${COIN}.desktop
    echo "✔ Desktop shortcut (1/2)"
    mkdir -p /usr/share/icons/hicolor/256x256/crypto/
    sudo curl -fsSL -o /usr/share/icons/hicolor/256x256/crypto/${COIN}.png \
      https://raw.githubusercontent.com/fentas/crypto/master/${COIN}/${COIN}.png
    echo "✔ Desktop shortcut (2/2)"
  fi
}

list_coins() {
  curl -s https://api.github.com/repos/fentas/crypto/contents/ \
    | jq -rc '. | map(select(.type == "dir")) | .[].name' \
    | grep -v '^_'
}

contains () {
  local e match="$1"
  shift
  for e; do [ "$e" = "$match" ] && return 0; done
  return 1
}

choose_coin() {
  local coins
  coins="$(list_coins)"
  until contains "${COIN}" ${coins}; do
    echo "You need to choose a coin from the list"
    printf '$ %s\n' ${coins}
    echo -n "Select coin: "
    IFS= read -r COIN
  done
}

# Check if jq exists
if ! ( [ -x "$(command -v jq)" ] && [ -x "$(command -v curl)" ] ); then
  install_dependencies
fi

# Check if docker exists
if ! [ -x "$(command -v docker)" ]; then
  install_docker
fi

# Choose coin
export COIN
if [ -z "${COIN}" ]; then
  choose_coin
fi

# Everything is set to install coin wallet
install_coin

# Give docker the rights to access the X-Server
if [ -x "$(command -v xhost)" ]; then
  xhost +local:docker
fi

echo "✔ All done"