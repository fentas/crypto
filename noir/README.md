<img alt="nor logo" src="https://github.com/fentas/crypto/blob/master/noir/noir.png?raw=true" width="20%" align="right" />

# Noir - Community build, privacy driven

Noir is a decentralized digital currency created to ensure your transactions are secure, private, and untraceable. Our technology is based on Zerocoin Protocol which provides you complete anonymity over your funds.

[https://noirofficial.com/](https://noirofficial.com/)

## Wallet (full node)

Docker hub tags ( `fentas/crypto` )

- `noir-v1.0.0.1`, `noir-v1.0.0.0`, `noir-latest`

## Noirnode

First of all make sure you [prepared](../README.md#masternode) your masternode.

You need to allow the ghostnode to communicate.

```sh
ufw allow 8255/tcp
```

And finally start it up.

```sh
mkdir -p $HOME/.noir
docker run -d --name noirnode \
  -p "8255:8255" \
  -v "$HOME/.noir:/.noir" \
  fentas/crypto:ghostnode

watch docker exec ghostnode noir-cli getnetworkinfo
cat $HOME/.noir/noir.conf
```

Now setup your local `.noir/noirnode.conf` and start the node.
More detailed description will follow.

## Mining

```bash
docker run -d --restart always --name noir fentas/cpuminer-opt \
  -a lyra2z330 \
  -o stratum+tcp://noir.pools.netabuse.net:3000 \
  -u ZQ12tQnAV5BBnuXXa3NRCLACxMQgHVz3pd.donations -p x
```

> Replace the noir address, if you want.


### Multithreading

> https://github.com/JayDDee/cpuminer-opt/issues/117#issuecomment-375452778

Assuming you are using a single-processor system, my advice is to map the threads and affinity settings to the number of physical cores on the CPU (NOT logical processors).

--threads = <# of cores>
--cpu-affinity = 0x5 (with an extra "5" added for every additional 2 cores in the system)

e.g. For a CPU with a 6-core CPU, use:

--threads=6 --cpu-affinity=0x555

This will ensure that all the threads are mapped to physical cores, which will generally give better overall performance. It will also leave the other hyper-threaded cores for use by the system, so you don't max out the CPU on the machine. If you've disabled hyper-threading (or using CPUs that don't support it), you don't need to use the affinity setting.

## FAQ

### No block source available...

Create `noir.conf` within your wallet folder (default `${HOME}/.noir`) and add the following:

```
addnode=106.72.145.64
addnode=113.161.230.70
addnode=117.181.56.196
addnode=140.82.16.151
addnode=194.118.31.182
addnode=199.247.28.146
addnode=209.250.238.242
addnode=37.17.168.174
addnode=94.192.170.192
addnode=106.69.222.142
addnode=109.97.198.88
addnode=149.28.134.177
addnode=172.104.235.228
addnode=174.138.9.198
addnode=185.220.101.44
addnode=188.116.27.110
addnode=190.142.80.103
addnode=192.210.241.47
addnode=195.24.140.254
addnode=31.49.251.187
addnode=40.121.32.89
addnode=45.32.223.229
addnode=45.76.225.55
addnode=51.15.113.88
addnode=51.15.68.66
addnode=72.193.246.33
addnode=95.216.137.140
addnode=95.97.232.226
addnode=96.32.133.91
```