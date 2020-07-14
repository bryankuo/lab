#!/bin/bash
HOST=ftp.speed.hinet.net
PORT=21
USER=ftp
# PASSWORD=ftp
PASSWORD=`echo ZnRwCg== | base64 --decode`

# ftp -npv $HOST $PORT <<EOF
ftp -np $HOST $PORT <<EOF
user $USER $PASSWORD
put /home/bryan/src/dashboard/compile_commands.json compile_commands.json
bye
EOF
