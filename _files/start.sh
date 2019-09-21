#!/bin/bash

if [[ -f /flag.sh ]]; then
	source /flag.sh
fi

if [[ -f /home/ctf/pwn ]]; then
	chown root:ctf /home/ctf/pwn
	chmod 750 /home/ctf/pwn
fi

if [ -z $TCPDUMP_ENABLE ]; then
    echo "Set TCPDUMP_ENABLE to enable packet capture."
else
	TCPDUMP_DIR=/var/lib/tcpdump
	if [ -z $TCPDUMP_ROTATE_SEC ]; then
		TCPDUMP_ROTATE_SEC=600
	fi
	TCPDUMP_FILENAME="capture-%F-%H-%M-%S.pcap"
	mkdir -p $TCPDUMP_DIR
	echo "TCPDUMP: capture port: 10000, rotate interval: ${TCPDUMP_ROTATE_SEC}s, capture filename: capture-\$time.pcap"
	exec /usr/sbin/tcpdump -i eth0 port 10000 -U -w $TCPDUMP_DIR/$TCPDUMP_FILENAME -G $TCPDUMP_ROTATE_SEC &
fi

export FLAG=not_flag
FLAG=not_flag

echo "Start Run xinetd"
exec /usr/sbin/xinetd -dontfork -stayalive -inetd_compat &

sleep 5s
echo "Xinetd Running..."

tail -F /var/log/xinetd.log