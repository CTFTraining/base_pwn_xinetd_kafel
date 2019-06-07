# Base image with xinetd and kafel for pwn

A docker image to hold pwn challenges in ctf war

> [Asuri-Team/xinetd-kafel](https://github.com/Asuri-Team/xinetd-kafel)

## Usage

Please check *.Dockerfile

## Env Vars

| Key                | Default Value    | Description                                                |
| ------------------ | ---------------- | ---------------------------------------------------------- |
| TCPDUMP_ENABLE     | (empty)          | Whether enable tcpdump or not                              |
| TCPDUMP_DIR        | /var/lib/tcpdump | Directory to write dump files (name=capture-$timestr.pcap) |
| TCPDUMP_ROTATE_SEC | 600              | Rotate time interval of capture file                       |
| FLAG               | (empty)          | Flag save in /flag                                         |
