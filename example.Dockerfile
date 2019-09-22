FROM ctftraining/base_pwn_xinetd_kafel

COPY src /tmp/

RUN cp /tmp/pwn /home/ctf/pwn && \
    cp /tmp/pwn.xinetd.conf /etc/xinetd.d/pwn && \
    chown root:ctf /home/ctf/pwn && \
    chmod 750 /home/ctf/pwn && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
