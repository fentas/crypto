# Collection of dockerized cryptocoins

This repository aims to reduce the complexity of cryptocoins.

Currently this whole repository is focused on Linux. If you using MacOS or Windows this can still [work for you](http://somatorio.org/en/post/running-gui-apps-with-docker/).

## Donations - Why I choose open source

I belief open source gives power and knowledge back to the people. Also the concept of open source is a good template for society and economics. Share, progress and leave out greed as much as possible. A future I would like to see and participate.

As I can not live from beliefs and hopes alone if you like or even using this repository consider donating.

**NOIR** \
`ZQ12tQnAV5BBnuXXa3NRCLACxMQgHVz3pd`

**NIX** \
`NSqZt9iLsWbJzaSZPjbUz5VkBHvjYfRoj6`

**BLOCK** \
`Baec3K9TKZSCnEJ6A2ufHtD3fnGfzaTumq`

## Wallet

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/fentas/crypto/master/wallet.sh)"
```

For the first startup I recommend using the cli (to see the download process). Just type the coin name in the terminal.

**TL;DR** \
All described below will be done by the script above. No need to read further if you used it.

### Docker

You need to have docker installed. The easiest way to do this is the following:

```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
```

### X-Server

Next you need to give docker X-Server access via:

```bash
xhost +local:docker
```

### Startup script

Download the required docker command to run the wallet (as executable) into `/usr/local/bin/`.

```bash
# Replace with the coin you want to use
COIN="blocknet"
sudo curl -fsSL -o /usr/local/bin/${COIN} https://raw.githubusercontent.com/fentas/crypto/master/${COIN}/wallet/bin/${COIN}
sudo chmod +x /usr/local/bin/${COIN}
```

### Desktop shortcut

For easy access you can setup also a desktop shortcut.

```bash
# Replace with the coin you want to use
COIN="blocknet"
sudo curl -fsSL -o /usr/share/applications/ https://raw.githubusercontent.com/fentas/crypto/master/${COIN}/wallet/${COIN}.desktop
sudo chmod +x /usr/share/applications/${COIN}.desktop
mkdir -p /usr/share/icons/hicolor/256x256/
sudo curl -fsSL -o /usr/share/icons/hicolor/256x256/ https://raw.githubusercontent.com/fentas/crypto/master/${COIN}/${COIN}.png
```

### Side note

The `wallet.sh` shell script will also install `jq` and `curl`. Helper utilities for processing json and transferring data (http), only a few kilobytes in size.

## Masternode

First of all you need to prepare your masternode.

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/fentas/crypto/master/masternode.sh)"
```

## Overview

List of coins

- [noir](/noir)
- [blocknet](/blocknet)
- [nix](/nix)
- [smartfox](/smartfox)

You'll find specific (e.g. masternode, mining) information/resources there.

## ToDo's

- [ ] remove `--privileged` flag
- [ ] auto download bootstrap
- [ ] try to use static linked binaries (smaller docker images - scratch if possible)
- [ ] more coins