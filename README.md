# Bento Toolkit for PT
This software is exprimental but we accept suggestions and contributions

_A bento (弁当, bentō) is a single-portion take-out or home-packed meal of Japanese origin._

Bento Toolkit is a simple and minimal docker container for penetration testers.

It has the portability of Docker with the addition of X, so you can also run GUI application (like burp).

## Prerequisites
To run bento you need `Docker`  and a `Xorg server` on your host machine.

## Installation
- `git clone https://higatowa/bento`
- `cd bento && docker build -t bento .`
- Since we need to fotward X to our machine we need first to get it's ip, and then execute `docker run --user tamago -p 8080:8080 -e DISPLAY={HOST_IP}:0.0 -it bento`

On linux you can also just execute the bash file in `installation/install.sh`
## Current tools and utilities
We don't like [bloated](https://www.kali.org/) [distros](https://www.parrotsec.org/) so we are keeping ths container as minimal as possible, adding only tools useful for web and infrastructure PT but, remember, we are always open to suggestions.

Here is a list of tools and utilities:
`burp suite`, `gobuster`, `seclist`, `odat`, `impacket`, `sqlmap`, `sqlplus`, `mysql-client`, `openvpn`. 