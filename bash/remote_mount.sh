#!/bin/bash
# example:
# ./remote_mount.sh apexx@disneyland:/home/apexx/ ~/Documents/disneyland/ disneyland
if [ "$#" -ne 3 ]; then
    echo $0" [remote] [local] [label]"
    exit 1;
fi
REMOTE=$1
LOCAL=$2
LABEL=$3

#reset mount
# umount -f ~/Documents/disneyland/
#umount -f $LOCAL
#sudo mkdir -pv $LOCAL

#mount dir
#sshfs apexx@disneyland:/home/apexx ~/Documents/disneyland/  -oauto_cache,reconnect,defer_permissions,noappledouble,negative_vncache,volname=disneyland

sshfs $REMOTE $LOCAL -oauto_cache,reconnect,defer_permissions,noappledouble,negative_vncache,volname=$LABEL

exit 0;
