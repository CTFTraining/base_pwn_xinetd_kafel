FROM ubuntu:16.04 as build-stage

WORKDIR /opt

RUN sed -i 's/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/' /etc/apt/sources.list && \
    sed -i 's/# deb-src/deb-src/' /etc/apt/sources.list && \
    sed -i '/security/d' /etc/apt/sources.list && \
    apt-get update -y && \
    apt-get upgrade -y

RUN apt-get install -y wget bison flex build-essential unzip

RUN apt-get build-dep -y xinetd

RUN wget https://github.com/google/kafel/archive/master.zip && \
    unzip master.zip && \
    rm master.zip && \
    mv kafel-master kafel && \
    cd kafel && make 

RUN wget https://github.com/Asuri-Team/xinetd-kafel/archive/master.zip && \
    unzip master.zip && \
    rm master.zip && \
    mv xinetd-kafel-master xinetd && \
    cd xinetd && \
    ./configure --prefix=/usr --with-kafel=/opt/kafel --with-loadavg --with-libwrap && \
    make

FROM ubuntu:16.04

LABEL Organization="CTFTraining" Author="Virink <virink@outlook.com>"
MAINTAINER Virink@CTFTraining <virink@outlook.com>

COPY _files /tmp
COPY --from=build-stage /opt/xinetd/xinetd/xinetd /tmp/xinetd

RUN sed -i 's/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/' /etc/apt/sources.list && \
    sed -i 's/# deb-src/deb-src/' /etc/apt/sources.list && \
    sed -i '/security/d' /etc/apt/sources.list && \
    apt-get update -y && \
    apt-get upgrade -y; \
    # netbase tcpdump xinetd
    apt-get install -y --no-install-recommends netbase tcpdump xinetd; \
    # lib
    apt-get install -y lib32ncurses5 lib32z1 lib32stdc++6; \
    # xinetd configure
    mkdir -p /etc/xinetd.d && \
    mv /tmp/xinetd.conf /etc/xinetd.conf && \
    mv /tmp/pwn.xinetd.conf /etc/xinetd.d/pwn && \
    mv /tmp/pwn.kafel /etc/pwn.kafel && \
    mv /tmp/banner_fail /etc/banner_fail && \
    mv /tmp/flag.sh /flag.sh && \
    mv /tmp/start.sh /start.sh && \
    mv /tmp/xinetd /usr/sbin/xinetd && \
    chmod +x /start.sh && \
    chmod +x /usr/sbin/xinetd; \
    # pwn home dir
    useradd -U -m ctf && \
    mkdir -p /home/ctf && \
    # lib
    cp -R /lib* /home/ctf && \
    cp -R /usr/lib* /home/ctf; \
    # bin
    mkdir /home/ctf/bin && \
    cp /bin/sh /home/ctf/bin && \
    cp /bin/ls /home/ctf/bin && \
    cp /bin/cat /home/ctf/bin; \
    # pwn home dir permission
    chown -R root:ctf /home/ctf; \
    chmod -R 750 /home/ctf && \
    # dev
    mkdir /home/ctf/dev && \
    mknod /home/ctf/dev/null c 1 3 && \
    mknod /home/ctf/dev/zero c 1 5 && \
    mknod /home/ctf/dev/random c 1 8 && \
    mknod /home/ctf/dev/urandom c 1 9 && \
    chmod 666 /home/ctf/dev/*; \
    # clean
    apt-get clean && \
    # /var/lib/apt/lists/* 
    rm -rf /tmp/* /var/tmp/*;

WORKDIR /home/ctf

VOLUME /var/lib/tcpdump

EXPOSE 10000

CMD ["/start.sh"]