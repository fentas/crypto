<img alt="nor logo" src="https://github.com/fentas/crypto/blob/master/noir/noir.png?raw=true" width="20%" align="right" />

# Noir - Community build, privacy driven

Noir is a decentralized digital currency created to ensure your transactions are secure, private, and untraceable. Our technology is based on Zerocoin Protocol which provides you complete anonymity over your funds.

[https://noirofficial.com/](https://noirofficial.com/)

## Wallet (full node)

Docker hub tags ( `fentas/crypto` )

- `noir-v1.0.0.0`, `noir-latest`

## Noirnode

... comming soon

## Mining

```bash
docker run -d --restart always --name zoin fentas/cpuminer-opt \
  -a lyra2zoin \
  -o stratum+tcp://pool.zoin.netabuse.net:3000 \
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