FROM fedora:latest
ENV path=$path:/usr/local/bin

#install dependecies,
RUN yum check-update; exit 0 
RUN yum -y install nmap hping3 wget zsh tcpdump \
    tmux python3 gdb python-pip python3-pip golang \
    openssh libaio libnsl java-11-openjdk net-tools \
    mysql sqlite nss libX11-xcb libdrm libwayland-server \
    libgbm openvpn iputils bind-utils whois sudo openssh-server \
    passwd

#create new user tamago
RUN useradd -G wheel -ms /bin/zsh tamago
USER tamago 
WORKDIR /home/tamago

#download gobuster, sqlmap, odat, impacket and SecList
ENV GOPATH=/home/tamago/.go
RUN mkdir tools && \
    go get -v github.com/OJ/gobuster && \
    git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git tools/sqlmap && \
    #git clone --depth 1 https://github.com/danielmiessler/SecLists tools/seclist && \
    git clone https://github.com/quentinhardy/odat tools/odat && \
    git clone https://github.com/SecureAuthCorp/impacket impacket && \
    cd impacket && pip3 install --user . && cd .. && rm -rf impacket && \
    wget https://github.com/Konloch/bytecode-viewer/releases/download/v2.9.21/Bytecode-Viewer-2.9.21.jar -O tools/bytecode_viewer.jar && \
    wget https://ghidra-sre.org/ghidra_9.2_PUBLIC_20201113.zip -O tools/ghidra.zip && cd tools &&  unzip ghidra.zip && rm -rf gidra.zip

#configure SSH server
USER root
COPY ./keys/authorized_keys /home/tamago/.ssh/authorized_keys
RUN ssh-keygen -A && \
    chown tamago:tamago /home/tamago/.ssh/authorized_keys && \
    chmod 644 /home/tamago/.ssh/authorized_keys && \
    echo "PasswordAuthentication no" /etc/ssh/sshd_config && \
    sed -i 's/PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config.d/50-redhat.conf && \
    sed -i 's/GSSAPIAuthentication.*/GSSAPIAuthentication no/' /etc/ssh/sshd_config.d/50-redhat.conf

# download and install burp and sqlplus
RUN wget 'https://portswigger.net/burp/releases/download?product=community&version=2020.11.1&type=Linux' -O burpinstall.sh && \
    wget https://download.oracle.com/otn_software/linux/instantclient/199000/oracle-instantclient19.9-basic-19.9.0.0.0-1.x86_64.rpm -O instantclient.rpm && \
    wget https://download.oracle.com/otn_software/linux/instantclient/199000/oracle-instantclient19.9-sqlplus-19.9.0.0.0-1.x86_64.rpm -O sqlplus.rpm && \
    rpm -hiv instantclient.rpm sqlplus.rpm && \
    rm instantclient.rpm sqlplus.rpm && \
    bash burpinstall.sh -q && \
    rm burpinstall.sh && \
    mv  /usr/local/bin/BurpSuiteCommunity /usr/local/bin/burp 

ENTRYPOINT [ "/usr/sbin/sshd", "-D" ]