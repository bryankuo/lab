#!/bin/bash
# Sort uniq IP address in from Apache log ( https://goo.gl/Fp2SpN ) :
sudo cat /var/log/httpd/access_log  | awk '{print $1}' | sort -n | uniq -c | sort -nr | head -20
