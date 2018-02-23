#!/bin/bash
if [ "$#" -ne 3 ]; then
    echo $0" [remote] [local] [label]"
    exit 1;
fi
# example:
# ./remote_mount.sh apexx@disneyland:/home/apexx ~/Documents/disneyland4/ disneyland4
REMOTE=$1
LOCAL=$2
LABEL=$3

#reset mount
#umount -f $LOCAL
#sudo mkdir -pv $LOCAL

#mount dir
sshfs $REMOTE $LOCAL -oauto_cache,reconnect,defer_permissions,noappledouble,negative_vncache,volname=$LABEL

exit 0;
