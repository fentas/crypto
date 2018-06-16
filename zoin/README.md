# Zoin - Community build, privacy driven

Zoin is a decentralized digital currency created to ensure your transactions are secure, private, and untraceable. Our technology is based on Zerocoin Protocol which provides you complete anonymity over your funds.

[https://zoinofficial.com/](https://zoinofficial.com/)

## Wallet (full node)

Docker hub tags ( `fentas/crypto` )

- `zoin-v0.13.1.6`, `zoin-latest`

## Masternode

## Mining

Replace `<username>`, `<worker>` and `<password>`.

```bash
docker run -d --restart always --name zoin fentas/cpuminer-opt \
  -a lyra2zoin \
  -o stratum+tcp://zoin.netabuse.net:3000 \
  -u <username>.<worker> -p <password>
```