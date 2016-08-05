#!/bin/bash

# server
#OUTPUT=n.out
#OPTIONS="-k -l 4444"
#nc $OPTIONS | tee -a $OUTPUT ; ( exit ${PIPESTATUS} )

# client
#OUTPUT=filename.out
#OPTIONS="-k -l 4444"
#nc 192.168.66.181 4444
#nc -p 12345 192.168.66.181 4444
nc -s 192.168.66.37 192.168.66.181 4444
 

