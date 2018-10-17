<img alt="nor logo" src="https://github.com/fentas/crypto/blob/master/smartfox/smartfox.png?raw=true" width="20%" align="right" />

# SmartFox

SmartFox provides reliable storage of text information, media files, and even websites, as well as rewards users in exchange for sharing their disk space!

[https://http://smartfox.network/](https://http://smartfox.network/)

## Wallet (full node)

Docker hub tags ( `fentas/crypto` )

- `fox-v1.2.2.1`, `fox`

## Foxnode

First of all make sure you [prepared](../README.md#masternode) your masternode.

You need to allow the ghostnode to communicate.

```sh
ufw allow 40428/tcp
```

And finally start it up.

```sh
mkdir -p $HOME/.fox
docker run -d --name foxnode \
  -p "40428:40428" \
  -v "$HOME/.fox:/.fox" \
  fentas/crypto:foxnode

watch docker exec foxnode fox-cli getnetworkinfo
cat $HOME/.fox/fox.conf
```

Now setup your local `.fox/masternode.conf` and start the node.
More detailed description will follow.