Dante - A free SOCKS server
===========================

[Dante][1] is a product developed by Inferno Nettverk A/S. It consists of a
SOCKS server and a SOCKS client, implementing RFC 1928 and related standards.
It is a flexible product that can be used to provide convenient and secure
network connectivity. 

## up and running

```bash
$ docker compose -f dante-socks5-proxy.yml up -d

# To enable username authentication, please uncomment `socksmethod: username`.
$ docker exec -it dante-socks5-proxy bash
>>> useradd username
>>> echo username:password | chpasswd
>>> exit

$ curl -x socks5h://username:password@127.0.0.1:1080 https://www.youtube.com
```

[1]: http://www.inet.no/dante/index.html


# Reference
https://github.com/vimagick/dockerfiles/tree/master/dante
