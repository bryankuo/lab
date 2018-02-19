#!/bin/bash

#reset mount
umount -f /Volumes/apexx
mkdir -pv /Volumes/apexx

#mount dir
sshfs apexx@disneyland:/home/apexx/ /Volumes/apexx -oauto_cache,reconnect,defer_permissions,noappledouble,negative_vncache,volname=apexx
