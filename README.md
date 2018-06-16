# Collection of dockerized cryptocoins

This repository aims to reduce the complexity of cryptocoins.

Currently this whole repository is focused on Linux. If you using MacOS or Windows this can still [work for you](http://somatorio.org/en/post/running-gui-apps-with-docker/).

## Donations - Why I choose open source

I belief open source gives power and knowledge back to the people. Also the concept of open source is a good template for society and economics. Share, progress and leave out greed as much as possible. A future I would like to see and participate.

As I can not live from beliefs and hopes alone if you like or even using this repository consider donating.

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

**TL;DR** \
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

## Setup

List of coins

- [zoin](/zoin)
- [blocknet](/blocknet)
- [nix](/nix)

You'll find specific (e.g. masternode, mining) information there. But generally you can the following instructions.

### Wallets

```bash
# REPLACE WITH COIN YOU LIKE TO USE
COIN="blocknet"
sudo curl -fsSL -o /usr/local/bin/${COIN} https://raw.githubuserconten.com/fentas/crypto/master/${COIN}/wallet/bin/${COIN}
sudo chmod +x /usr/local/bin/${COIN}
```

### Masternodes

... coming soon

## ToDo's

- [ ] auto download bootstrap
- [ ] try to use static linked binaries (smaller docker images - scratch if possible)
- [ ] more coins