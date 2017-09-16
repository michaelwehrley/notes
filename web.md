# General Web

## IP Address vs DNS
_11.222.333.44_ === wehrley.com.

Note: If a DNS (Domanin Names Service) goes down, the IP address still exists and can be accessed.

## Ping

`$ ping google.com` or `$ ping 172.217.1.46`

```
$ ping google.com

PING google.com (172.217.1.46): 56 data bytes
64 bytes from 172.217.1.46: icmp_seq=0 ttl=54 time=25.472 ms
64 bytes from 172.217.1.46: icmp_seq=1 ttl=54 time=23.295 ms
64 bytes from 172.217.1.46: icmp_seq=2 ttl=54 time=23.828 ms
64 bytes from 172.217.1.46: icmp_seq=3 ttl=54 time=23.114 ms
64 bytes from 172.217.1.46: icmp_seq=4 ttl=54 time=25.141 ms

--- google.com ping statistics ---
5 packets transmitted, 5 packets received, 0.0% packet loss
round-trip min/avg/max/stddev = 23.114/24.170/25.472/0.963 ms
```

```
$ ping 172.217.1.46

PING 172.217.1.46 ( 172.217.1.46): 56 data bytes
Request timeout for icmp_seq 0
Request timeout for icmp_seq 1
Request timeout for icmp_seq 2
Request timeout for icmp_seq 3
Request timeout for icmp_seq 4

--- 172.217.1.46 ping statistics ---
6 packets transmitted, 0 packets received, 100.0% packet loss
```

## Cache Poisoning
* No way for your local browser (i.e., Chrome or Safari) to not know that website.com is *not* at 999.999.999.999 but should be at 111.222.333.444
  - The server @ 111.222.333.444 has a verified certificate that says "DNS lives at this IP Address" so the browser knows it is the correct IPA address for the website.

## Traceroute - sends ICMP
* `$ traceroute netflix.com`
*  homeportal (192.168.1.254)  2.978 ms  2.266 ms  2.023 ms (home router)
* IP - Internet Protocol
* TCP - Transmission Control Protocol
* ICMP - Internet Control Message Packet

## Servers
1. *Dedicated Server* My own Server, but EXPENSIVE
1. *VPS - Virtual Private Server* - it can be broken up and multiple VPSs on one Dedicated Server; scalable; on demand
  - AWS, Rackspace, Digital Ocean

## View Available Users on a Virtual Private Server (VPS)
* `https://www.digitalocean.com/community/tutorials/how-to-view-system-users-in-linux-on-ubuntu`
* How To View System Users in Linux on Ubuntu `less /etc/passwd`
* How To View Available Groups on a VPSless /etc/group
* You can have multiple SSH key pairs `ssh-keygen -t rsa`
* generating a new key pair: `ssh-keygen -t rsa -b 4096 -C "your_email@example.com"` [-b bits] [-t dsa |

## SSH Key
1. Logging in with your ssh key for the first time: (remember your passkey - you will use that when you add it!)
`ssh -i ~/.ssh/digital_ocean_ubuntu root@111.222.333.444` (`-i` is for identity; we are sending our private key so if the fingerprint message comes up - be careful)
1. `~/.ssh/known_hosts` *is the directory that stores all keys your SERVER has connected with*

```
  The authenticity of host \'111.222.333.444 (111.222.333.444)\' can\'t be established.
  ECDSA key fingerprint is SHA256:....
  Are you sure you want to continue connecting (yes/no)? yes
  Warning: Permanently added \'111.222.333.444\' (ECDSA) to the list of known hosts.
```

1. `top` or `htop` - but need to install `htop`.  For installing via Ubunto you need to run `apt-get install htop` or `apt install htop`

## Set up Server

`#` is going to mean root
`/` is NOT root.

1. Naming the server
```bash
# FrontEndMastersFullStack is the name of the server
root@FrontEndMastersFullStack:~#
```

1. Update the server - good idea: `apt-get update`
1. Add User so we don't have to use root: `adduser mike`
1. Add them to a group so they have permissions such as sudo (Substitute User Do):
  - `root@FrontEndMastersFullStack:~# usermod -aG sudo mike`
  - ("a" is for add); "G" is group
1. Swith to user mike: `root@FrontEndMastersFullStack:~# su mike`
  - `mike@FrontEndMastersFullStack:/root$`
1. To run a command as administrator (user "root"), use "sudo <command>".
  - See "man sudo_root" for details.

## Root Permissions
1. Example of only sudo: `cat /var/log/auth.log`; so user "mike" can run `sudo cat /var/log/auth.log`, but needs to enter password.
1. now I can't run `ls`, I have to run `sudo ls`
1. `$ sudo !!` will replay that last command with sudo in front.

## Create Server SSH key
This way we don't need to enter password every time
`cat ~/.ssh/id_rsa.pub | ssh root@111.222.333.444 "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"`
