# Collection of dockerized cryptocoins

This repository aims to reduce the complexity of cryptocoins.
Currently this whole repository is focused on Linux (could also work on MacOS). If you using Windows you should consider setup a Linux system anyway.

## Donations - Why I choose open source

I belief open source gives back power and knowledge back to the people. Also it is open source a good template for society and economics. Share, progress and leave out greed as much as possible. A future I would like to see.

As I can not live from beliefs and hopes alone please if you like or using this repository consider donating.

**BTC** \
``

**ETH** \
``

**ZOIN** \
``

**BLOCK** \
``

## Preparations

```bash
curl -fsSL https://raw.githubuserconten.com/fentas/crypto/master/prepare.sh | sh
```

**TL;DR**
All described here will be done by the script above. No need to read further if you used it.

### Docker

You need to have docker installed. The easiest way to do this is the following:

```bash
curl -fsSL https://get.docker.com | sh
```

### X-Server

Next you need to give docker X-Server access via:

```bash
xhost +local:docker
```

## Wallets

```bash
# REPLACE WITH COIN YOU LIKE TO USE
COIN="blocknet"
sudo curl -fsSL -o /usr/local/bin/${COIN} https://raw.githubuserconten.com/fentas/crypto/master/${COIN}/wallet/bin/${COIN}
sudo chmod +x /usr/local/bin/${COIN}
```

## Masternodes

...