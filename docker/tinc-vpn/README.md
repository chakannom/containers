tinc
====

[tinc][1] is a Virtual Private Network (VPN) daemon that uses tunnelling and
encryption to create a secure private network between hosts on the Internet.

To use this image, you need to have basic knowledges of tinc. (See this [tutor][2])

## Server Setup

```bash
# run
$ docker compose -f tinc-vpn.yml up -d

# monitor
$ docker compose -f tinc-vpn.yml logs

# stats
$ docker compose -f tinc-vpn.yml exec tinc-vpn netstat -an
```

## Client Setup

```bash
# start
$ tincd -d -D -n netname --pidfile /tmp/tinc.pid

# stop
$ tincd -k --pidfile /tmp/tinc.pid
```

## Client Setup (openwrt)

```bash
$ opkg install tinc ip
 
$ cat > /etc/config/tinc
config tinc-net netname
    option enabled 1
config tinc-host linkit
    option enabled 1
    option net netname
config tinc-host server
    option enabled 1
    option net netname
 
$ mkdir -p /etc/tinc/netname/hosts
 
$ cat > /etc/tinc/netname/tinc.conf
Name = linkit
Interface = tun0
ConnectTo = server
 
$ cat > /etc/tinc/netname/hosts/linkit
Subnet = 10.20.30.125
 
$ tincd -n netname -K < /dev/null
Generating 2048 bits keys:
......+++ p
.....+++ q
Done.
 
$ cat > /etc/tinc/netname/tinc-up
#!/bin/sh
ip link set $INTERFACE up
ip addr add  10.20.30.125/24 dev $INTERFACE
 
$ cat > /etc/tinc/netname/tinc-down
#!/bin/sh
ip addr del 10.20.30.125/24 dev $INTERFACE
ip link set $INTERFACE down
 
$ cat > /etc/tinc/netname/hosts/server-up
#!/bin/sh
ORIGINAL_GATEWAY=`ip route show | grep ^default | cut -d ' ' -f 2-3`
ip route add $REMOTEADDRESS $ORIGINAL_GATEWAY
ip route add 0.0.0.0/1 dev $INTERFACE
ip route add 128.0.0.0/1 dev $INTERFACE
 
$ cat > /etc/tinc/netname/hosts/server-down
#!/bin/sh
ORIGINAL_GATEWAY=`ip route show | grep ^default | cut -d ' ' -f 2-3`
ip route del $REMOTEADDRESS $ORIGINAL_GATEWAY
ip route del 0.0.0.0/1 dev $INTERFACE
ip route del 128.0.0.0/1 dev $INTERFACE
 
$ chmod +x /etc/tinc/netname/tinc-*
$ chmod +x /etc/tinc/netname/hosts/server-*
 
$ scp /etc/tinc/netname/hosts/linkit root@remote-server:/etc/tinc/netname/hosts/
$ scp root@remote-server:/etc/tinc/netname/hosts/server /etc/tinc/netname/hosts/
 
$ /etc/init.d/tinc start
$ /etc/init.d/tinc enable
 
$ ifconfig tun0
 
$ firefox http://192.168.1.125/cgi-bin/luci/
 
# Firewall:
# | lan => wan, vpn | ooo | xx |
# | wan =>          | oox | oo |
# | vpn => wan      | ooo | ox |
```
# Reference
https://github.com/vimagick/dockerfiles/tree/master/tinc

[1]: http://tinc-vpn.org/
[2]: https://www.digitalocean.com/community/tutorials/how-to-install-tinc-and-set-up-a-basic-vpn-on-ubuntu-14-04
