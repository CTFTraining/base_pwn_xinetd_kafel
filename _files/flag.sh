#!/bin/bash

echo $FLAG > /home/ctf/flag

chmod 444 /home/ctf/flag

export FLAG=not_flag
FLAG=not_flag

rm -f /flag.sh