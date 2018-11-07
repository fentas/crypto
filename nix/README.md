<img alt="nix logo" src="https://github.com/fentas/crypto/blob/master/nix/nix.png?raw=true" width="20%" align="right" />

# NIX - Bringing privacy to new digital horizons

NIX Platform combines Atomic Swaps and privacy using our unique, innovative Ghost Protocol to provide the world with a truly anonymous and decentralized transfer of assets for the cross-chain era.

[https://nixplatform.io/](https://nixplatform.io/)

## Wallet (full node)

- `nix-v2.1.0`
- `nix-beta-v1.0.0`

## Ghostnode

First of all make sure you [prepared](../README.md#masternode) your masternode.

You need to allow the ghostnode to communicate.

```sh
ufw allow 6214/tcp
```

And finally start it up.

```sh
mkdir -p $HOME/.nix
docker run -d --name ghostnode \
  -p "6214:6214" \
  -v "$HOME/.nix:/.nix" \
  fentas/crypto:ghostnode

watch docker exec ghostnode nix-cli getnetworkinfo
cat $HOME/.nix/nix.conf
```

Now setup your local `.nix/ghostnode.conf` and start the node.
More detailed description will follow.