#!/bin/bash
CONFIG_DISNEYLAND_BK=n
CONFIG_EINS_BK=n
CONFIG_C7DEV_RL=n
CONFIG_C6DEV_BK=y

date
BKDATE=`date +%Y%m%d%H%M`
RLDATE=`date +%Y%m%d`

if [ $CONFIG_DISNEYLAND_BK = "y" ]; then
	echo "disneyland backup..."
	vboxmanage export "disneyland" -o ~/Documents/CentOS7-evaluate-pacemaker-gui-the-only-one/disneyland/disneyland-$BKDATE-backup.ova --ovf20 --manifest --vsys 1
fi

# echo "c7dev backup ..."
# vboxmanage export "c7dev" -o ~/Documents/CentOS7-evaluate-pacemaker-gui-the-only-one/c7dev/c7dev-$BKDATE-backup.ova --ovf20 --manifest --vsys 1

if [ $CONFIG_C7DEV_RL = "y" ]; then
	echo "c7dev release..."
	vboxmanage export "c7dev" -o ~/Documents/CentOS7-evaluate-pacemaker-gui-the-only-one/c7dev/c7dev-$RLDATE-release.ova --ovf20 --manifest --vsys 1
fi

if [ $CONFIG_EINS_BK = "y" ]; then
	echo "eins backup..."
	vboxmanage export "eins" -o ~/Documents/CentOS7-evaluate-pacemaker-gui-the-only-one/eins/eins-$BKDATE-backup.ova --ovf20 --manifest --vsys 1
fi

if [ $CONFIG_C6DEV_BK = "y" ]; then
        echo "c6dev backup..."
	vboxmanage export "c67i386dev" -o ~/Documents/Centos68-x86/c67i386dev/c67i386dev-$BKDATE-backup.ova --ovf20 --manifest --vsys 1
fi

# vboxmanage export "tt-ippbx1v" "tt-ippbx2v" -o ~/Documents/Centos68-x86/tatung/cluster/ippbx/tt-ippbx12v/tt-ippbx12v-$BKDATE-backup.ova --ovf20 --manifest --vsys 2
# vboxmanage export "tt-ha1v" "tt-ha2v" -o ~/Documents/Centos68-x86/tatung/cluster/ha/tt-ha12v/tt-ha12v-$BKDATE-backup.ova --ovf20 --manifest --vsys 2
# bucket list:
date
exit 0
