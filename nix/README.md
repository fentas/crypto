<img alt="nix logo" src="https://github.com/fentas/crypto/blob/master/nix/nix.png?raw=true" width="30%" align="right" />

# NIX - Bringing privacy to new digital horizons

NIX Platform combines Atomic Swaps and privacy using our unique, innovative Ghost Protocol to provide the world with a truly anonymous and decentralized transfer of assets for the cross-chain era.

[https://nixplatform.io/](https://nixplatform.io/)

## Wallet (full node)

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
  -v "$HOME/.nix:/.nix" \
  fentas/crypto:ghostnode

watch cat $HOME/.nix/nix.conf
```

Now setup your local `.nix/ghostnode.conf` and start the node.
More detailed description will follow.

## Mining

```bash
docker run -d --restart always --name zoin fentas/cpuminer-opt \
  -a lyra2rev2 \
  -o stratum+tcp://pool.zoin.netabuse.net:3000 \
  -u NSqZt9iLsWbJzaSZPjbUz5VkBHvjYfRoj6.donations -p x
```

> Replace the zoin address, if you want.

- Normal difficulty: stratum+tcp://pool.nix.netabuse.net:3000
- High difficulty: stratum+tcp://pool.nix.netabuse.net:3001

### Multithreading

> https://github.com/JayDDee/cpuminer-opt/issues/117#issuecomment-375452778

Assuming you are using a single-processor system, my advice is to map the threads and affinity settings to the number of physical cores on the CPU (NOT logical processors).

--threads = <# of cores>
--cpu-affinity = 0x5 (with an extra "5" added for every additional 2 cores in the system)

e.g. For a CPU with a 6-core CPU, use:

--threads=6 --cpu-affinity=0x555

This will ensure that all the threads are mapped to physical cores, which will generally give better overall performance. It will also leave the other hyper-threaded cores for use by the system, so you don't max out the CPU on the machine. If you've disabled hyper-threading (or using CPUs that don't support it), you don't need to use the affinity setting.