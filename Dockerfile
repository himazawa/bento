FROM fedora:latest
ENV path=$path:/usr/local/bin

#install dependcies,
RUN yum check-update; exit 0 
RUN yum -y install nmap hping3 wget zsh tcpdump \
    tmux python3 gdb python-pip python3-pip golang \
    openssh libaio libnsl java-11-openjdk net-tools mysql sqlite nss libX11-xcb libdrm libwayland-server libgbm

#create new user tamago
RUN useradd -ms /bin/zsh tamago
USER tamago 
WORKDIR /home/tamago

#download burp gobuster, sqlmap, odat, impacket and SecList
RUN wget 'https://portswigger.net/burp/releases/download?product=community&version=2020.11.1&type=Linux' -O burpinstall.sh
ENV GOPATH=/home/tamago/.go
RUN mkdir tools && \
    go get -v github.com/OJ/gobuster && \
    git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git tools/sqlmap && \
    git clone --depth 1 https://github.com/danielmiessler/SecLists lists tools/sqlmap && \
    git clone https://github.com/quentinhardy/odat tools/odat && \
        git clone https://github.com/SecureAuthCorp/impacket impacket && \
    cd impacket && pip3 install --user . && cd .. && rm -rf impacket
# download sqlplus and depencencies
RUN wget https://download.oracle.com/otn_software/linux/instantclient/199000/oracle-instantclient19.9-basic-19.9.0.0.0-1.x86_64.rpm -O instantclient.rpm && \
    wget https://download.oracle.com/otn_software/linux/instantclient/199000/oracle-instantclient19.9-sqlplus-19.9.0.0.0-1.x86_64.rpm -O sqlplus.rpm

#install burp and sqlplus
USER root
RUN rpm -hiv instantclient.rpm sqlplus.rpm && \
    rm instantclient.rpm sqlplus.rpm && \
    bash burpinstall.sh -q && \
    rm burpinstall.sh && \
    mv  /usr/local/bin/BurpSuiteCommunity /usr/local/bin/burp