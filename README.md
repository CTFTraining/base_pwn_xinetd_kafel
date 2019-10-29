# Base image with xinetd and kafel for pwn

A docker image to hold pwn challenges in ctf war

> [Asuri-Team/xinetd-kafel](https://github.com/Asuri-Team/xinetd-kafel)

## Usage



1. Copy your `pwn`  file to src/
2. Change  FLAG in `docker-compose.yml`
3. `docker-compose up -d`
4. You can delete `_files`, `Dockerfile` and `test`, but `src` is requied
## Env Vars

| Key                | Default Value    | Description                                                |
| ------------------ | ---------------- | ---------------------------------------------------------- |
| TCPDUMP_ENABLE     | (empty)          | Whether enable tcpdump or not                              |
| TCPDUMP_DIR        | /var/lib/tcpdump | Directory to write dump files (name=capture-$timestr.pcap) |
| TCPDUMP_ROTATE_SEC | 600              | Rotate time interval of capture file                       |
| FLAG               | (empty)          | Flag save in /flag                                         |
