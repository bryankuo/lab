#!/bin/bash

# tcp server
#OUTPUT=n.out
#OPTIONS="-k -l 4444"
#nc $OPTIONS | tee -a $OUTPUT ; ( exit ${PIPESTATUS} )

# tcp client
#OUTPUT=filename.out
#OPTIONS="-k -l 4444"
#nc 192.168.66.181 4444
#nc -p 12345 192.168.66.181 4444
nc -s 192.168.66.37 192.168.66.181 4444

# udp server
nc -ul  localhost 2399
nc -ulv localhost 2399
nc -ulv localhost 2399 > /tmp/123.txt

# udp client
netcat -u host port
echo -en "abc" | nc -u localhost 2399
echo -en "\x80" | nc -u localhost 2399

# watching udp socket connection
watch -n 3 "netstat | grep 2399"
hexdump -Cv /tmp/123.txt
