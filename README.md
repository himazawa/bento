
_This software is exprimental but we accept suggestions and contributions_
# Bento Toolkit for PT and CTF


_A bento (弁当, bentō) is a single-portion take-out or home-packed meal of Japanese origin._

Bento Toolkit is a simple and minimal docker container for penetration testers and CTF players.

It has the portability of Docker with the addition of X, so you can also run GUI application (like burp).

## Prerequisites

To run bento you need `Docker`  and a `Xorg server` on your host machine.
On Windows you can use [vcxsrv](https://sourceforge.net/projects/vcxsrv/), [xming](https://sourceforge.net/projects/xming/), [xgwin](https://www.cygwin.com/).

With `vcxsrv` you just need to start XLaunch, on `cygwin` you have to [install xorg](https://x.cygwin.com/docs/ug/setup.html) first.

We tested this config with `vcxsrv` and `cygwin`.

- `vcxsrv`: just start XLaunch and follow the setup
- `cygwin`: you have to [install xorg](https://x.cygwin.com/docs/ug/setup.html) first, then start XLaunch.
  
## Installation

- `git clone https://github.com/higatowa/bento`
- `cd bento && docker build -t bento .`
- generate keypair and put `authorized_keys`, contianing your public key, in `./keys`.
- Since we need to fotward X to our machine we need first to get it's ip, and then to execute:
`docker run --cap-add=NET_ADMIN --device /dev/net/tun --sysctl net.ipv6.conf.all.disable_ipv6=0 -p 22:22 -d bento`.
- Connect via ssh to the docker machine and forward port 6000 (Xorg) with `ssh -R 6000:localhost:6000 -L 8080:localhost:8080  tamago@bentoip`.
- On first login you will be asked to change the password.

## Current tools and utilities

We don't like [bloated](https://www.kali.org/) [distros](https://www.parrotsec.org/) so we are keeping this container as minimal as possible, adding only tools useful for web and infrastructure PT and CTF but, remember, we are always open to suggestions.

Here is a list of tools and utilities:
`burp suite`, `gobuster`, `seclist`, `odat`, `impacket`, `sqlmap`, `sqlplus`, `mysql-client`, `openvpn`, `bytecode-viewer`, `ghidra`.
