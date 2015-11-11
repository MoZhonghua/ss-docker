How to build
------------------

```bash
git clone https://github.com/MoZhonghua/docker-ss

cd docker-ss/base
docker built -t ss/base .

cd ../client
docker built -t ss/client .

cd ../server
docker built -t ss/server .
```

Start Shadowsocks client and polipo
------------------

Start using environment variables
===========================

```bash
docker run -d --name ssclient --restart=always \
    -e SERVER=45.62.113.246 \
    -e SERVER_PORT=4433 \
    -e PASSWORD=password \
    -e LOCAL_PORT=8091 \
    -e POLIPO_PORT=8090 \
    -p 8091:8091 \
    -p 8090:8090 \
    ss/client
```

Environment variables
=========================
`SERVER`: IP address of your Shadowsocks server

`SERVER_PORT`: Listening port of your Shadowsocks server

`PASSWORD`: Password of Shadowsocks server

`LOCAL_PORT`: Shadowsocks client will listen on this port (socks proxy)

`POLIPO_PORT`: polipo will listen on this port (http proxy)


Start uinsg exsting configuration file
=========================
```bash
mkdir shadowsocks
cp client/sslocal.conf.example shadowsocks/sslocal.conf

# mdoify shadowsocks/sslocal.conf
docker run -d --name ssclient --restart=always \
    -v $(pwd)/shadowsocks:/etc/shadowsocks \
    -p 8091:8091 \
    -p 8090:8090 \
    ss/client

```

Start Shadowsocks server
---------------------

Start using environment variables
===========================

```bash
docker run -d --name=ssserver --restart=always \
    -e SERVER_PORT=4433 \
    -e PASSWORD=123456 \
    -p 8388:8388 \
    ss/server
```

Environment variables
===========================
`SERVER_PORT`: Listening port of your Shadowsocks server

`PASSWORD`: Password of Shadowsocks server

Start uinsg exsting configuration file
=========================
```bash
mkdir shadowsocks
cp server/ssserver.conf.example shadowsocks/ssserver.conf

# mdoify shadowsocks/sslocal.conf
docker run -d --name ssserver --restart=always \
    -v $(pwd)/shadowsocks:/etc/shadowsocks \
    -p 8388:8388 \
    ss/server
```
