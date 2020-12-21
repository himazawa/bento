_This software is exprimental but we accept suggestions and contributions_

# Bento Toolkit for PT and CTF

_A bento (弁当, bentō) is a single-portion take-out or home-packed meal of Japanese origin._

Bento Toolkit is a simple and minimal docker container for penetration testers and CTF players.

It has the portability of Docker with the addition of X, so you can also run GUI application (like burp).

## Prerequisites

To run bento you need `Docker`  and a `Xorg server` on your host machine.
On Windows you can use [vcxsrv](https://sourceforge.net/projects/vcxsrv/), [xming](https://sourceforge.net/projects/xming/), [cygwin](https://www.cygwin.com/).

We tested this config with `vcxsrv` and `cygwin`.

- `vcxsrv`: just start XLaunch and follow the setup
- `cygwin`: you have to [install xorg](https://x.cygwin.com/docs/ug/setup.html) first, then start XLaunch.
  
## Installation with  Docker

- `git clone https://github.com/higatowa/bento &&  cd ./bento`
- generate keypair and put `authorized_keys`, containing your public key, in `./keys`.
- `docker build -t bento .`
- Since we need to forward X to our machine we need first to get its ip, and then to execute:
`docker run --cap-add=NET_ADMIN --device /dev/net/tun --sysctl net.ipv6.conf.all.disable_ipv6=0 -p 22:22 -d bento`
- Connect via ssh to the docker machine and forward port 6000 (Xorg) with `ssh -R 6000:localhost:6000 -L 8080:localhost:8080  tamago@bentoip`
- On first login you will be asked to change the password.

For GUI tools just run them from the terminal:

![brup](https://i.imgur.com/3kDhMGP.png)

![bytecode vierwer](https://imgur.com/LzktHZj.png)

## Installation with Docker Compose

To be able to quickly deploy multiple instance of bento we decided to write a `docker-compose` this isn't only for style but we also added a collaborative pad, `codimd`. During our wourk we have the need to share informations on the target so we decided to implement in bento the solution we use dailies.
The pad is exposed by default on port `3000`.\

![codimd](https://i.imgur.com/mbGqZeu.png)

Replace the step `3` and `4` of `Installation with Docker` chapter with:

`docker-compose build` and `docker-compose up`

in the project directory. 

If you wanto to deploy only `bento` without `codimd`:

`docker-compose up bento`

## Known issues

- Burp embededed browser is not working if run as user.
    We addressed this in issue #3. We found the issue and while we are waiting for the Portswigger team to fix it, we wrote a small workaround, just run the `/home/tamago/burp_fix/burp_fix.sh` as `root` and it will fix it.

## Current tools and utilities

We don't like [bloated](https://www.kali.org/) [distros](https://www.parrotsec.org/) so we are keeping this container as minimal as possible, adding only tools useful for web and infrastructure PT and CTF but, remember, we are always open to suggestions.

Here is a list of tools and utilities:
- [`codimd`](https://github.com/hackmdio/codimd)  
- [`Burp Suite`](https://forum.portswigger.net)
- [`gobuster`](https://github.com/OJ/gobuster)
- [`SecLists`](https://github.com/danielmiessler/SecLists)
- [`odat`](https://github.com/quentinhardy/odat)
- [`impacket`](https://github.com/SecureAuthCorp/impacket)
- [`sqlmap`](https://github.com/sqlmapproject/sqlmap)
- [`sqlplus`](https://docs.oracle.com/cd/B14117_01/server.101/b12170/qstart.htm),
- `mysql-client`
- [`openvpn`](https://openvpn.net/)
- [`bytecode-viewer`](https://github.com/Konloch/bytecode-viewer)
- [`ghidra`](https://ghidra-sre.org/)