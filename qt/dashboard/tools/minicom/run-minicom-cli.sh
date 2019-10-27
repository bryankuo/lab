#!/bin/bash
MINICOM="-con" export MINICOM;
minicom -b 115200 -D /dev/ttyUSB0 -w -C stdout -S voib-can06.txt
exit 0;
