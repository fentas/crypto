#!/usr/bin/env bash
set -e

.install_docker() {
  curl -fsSL https://get.docker.com | sh
  sudo usermod -aG docker $USER
  echo "> Log out and log back so that your group membership is re-evaluated."
}

.install_jq() {
  sudo apt-get update
  sudo apt-get install -y jq
}

.install_coin() {
  : ${COIN:?}
  sudo curl -fsSL -o /usr/local/bin/${COIN} https://raw.githubuserconten.com/fentas/crypto/master/${COIN}/wallet/bin/${COIN}
  sudo chmod +x /usr/local/bin/${COIN}
  # Install desktop shortcut
  if [ -d /usr/share/applications ]; then
    sudo curl -fsSL -o /usr/share/applications/ https://raw.githubuserconten.com/fentas/crypto/master/${COIN}/wallet/${COIN}.desktop
    sudo chmod +x /usr/share/applications/${COIN}.desktop
    mkdir -p /usr/share/icons/hicolor/256x256/
    sudo curl -fsSL -o /usr/share/icons/hicolor/256x256/ https://raw.githubuserconten.com/fentas/crypto/master/${COIN}/${COIN}.png
  fi
}

.list_coins() {
  curl -s https://api.github.com/repos/fentas/crypto/contents/ \
    | jq -rc '. | map(select(.type == "dir")) | .[].name' \
    | grep -v '^_'
}

.contains () {
  local e match="$1"
  shift
  for e; do [[ "$e" == "$match" ]] && return 0; done
  return 1
}

.choose_coin() {
  local coins=($(.list_coins))
  printf '$ %s\n' "${coins[@]}"
  echo -n "Select coin: "
  read COIN
}

# Check if jq exists
if ! [ -x "$(command -v jq)" ]; then
  .install_jq
fi

# Check if docker exists
if ! [ -x "$(command -v docker)" ]; then
  .install_docker
fi

# Choose coin
export COIN
COINS=($(.list_coins))
until .contains "${COIN}" "${COINS[@]}"; do
  echo "You need to choose a coin from the list"
  .choose_coin
done

# Everything is set to install coin wallet
.install_coin

# Give docker the rights to access the X-Server
if [ -x "$(command -v xhost)" ]; then
  xhost +local:docker
fi  