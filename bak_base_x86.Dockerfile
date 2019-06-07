FROM i386/debian:stretch-slim as build-stage-i386

RUN sed -i 's/deb.debian.org/mirrors.tuna.tsinghua.edu.cn/' /etc/apt/sources.list && \
    sed -i 's/security.debian.org/mirrors.tuna.tsinghua.edu.cn/' /etc/apt/sources.list && \
    echo "deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ stretch main contrib non-free" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y wget bison flex build-essential unzip && \
    apt-get build-dep -y xinetd && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    cd /opt && \
    wget https://github.com/google/kafel/archive/master.zip && \
    unzip master.zip && \
    rm master.zip && \
    mv kafel-master kafel && \
    cd kafel && \
    make && \
    cd /opt && \
    wget https://github.com/Asuri-Team/xinetd-kafel/archive/master.zip && \
    unzip master.zip && \
    rm master.zip && \
    mv xinetd-kafel-master xinetd && \
    cd xinetd && \
    ./configure --prefix=/usr --with-kafel=/opt/kafel --with-loadavg --with-libwrap && \
    make

FROM i386/debian:stretch-slim

LABEL Organization="CTFHUB <www.ctfhub.com>" Author="Virink <virink@outlook.com>"
MAINTAINER Virink@CTFHUB <virink@outlook.com>

COPY _files /tmp
COPY --from=build-stage-i386 /opt/xinetd/xinetd/xinetd /tmp/
# /usr/sbin/xinetd

RUN sed -i 's/deb.debian.org/mirrors.tuna.tsinghua.edu.cn/' /etc/apt/sources.list && \
    sed -i 's/security.debian.org/mirrors.tuna.tsinghua.edu.cn/' /etc/apt/sources.list && \
    apt-get update && \
    # netbase tcpdump 
    apt-get install -y --no-install-recommends lib32ncurses5 lib32z1 libwrap0 netbase tcpdump; \
    # Configure
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
    # pwn dir
    useradd -U -m ctf && \
    mkdir -p /home/ctf && \
    chown -R root:ctf /home/ctf; \
    # clean
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*;

WORKDIR /home/ctf

VOLUME /var/lib/tcpdump

EXPOSE 10000

CMD ["/start.sh"]