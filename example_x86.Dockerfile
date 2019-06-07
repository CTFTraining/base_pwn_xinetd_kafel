FROM ctftraining/base_pwn_xinetd_kafel:x86

COPY src /tmp/

RUN cp /tmp/pwn /home/ctf/pwn && \
    cp /tmp/pwn.xinetd.conf /etc/xinetd.d/pwn && \
    chown -R root:ctf /home/ctf && \
    chmod 750 /home/ctf/pwn && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
