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
num_mount=$(mount | grep ${LABEL} | wc -l)
#echo $num_mount
if [ $num_mount -le "       0" ]; then
# //TODO: trim "       0"
#mount dir
#sshfs apexx@disneyland:/home/apexx ~/Documents/disneyland/  -oauto_cache,reconnect,defer_permissions,noappledouble,negative_vncache,volname=disneyland

sshfs $REMOTE $LOCAL -oauto_cache,reconnect,defer_permissions,noappledouble,negative_vncache,volname=$LABEL
else
	echo "unmount first."
#reset mount
# umount -f ~/Documents/disneyland/
#umount -f $LOCAL
#sudo mkdir -pv $LOCAL
# rm -rf ~/Documents/disneyland/
# umount -f ~/Documents/disneyland/  ; rm -rf ~/Documents/disneyland/
# umount -f ~/Documents/disneyland/ && rm -rf ~/Documents/disneyland/
# umount -f ~/Documents/eins/ && rm -rf ~/Documents/eins/
# echo $(mount | grep disneyland | wc -l)
fi

exit 0;
