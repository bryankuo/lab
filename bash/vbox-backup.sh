#!/bin/bash
CONFIG_DISNEYLAND_BK=n
CONFIG_EINS_BK=n
CONFIG_C7DEV_RL=n
CONFIG_C7HA_RL=n
CONFIG_ZWEI_BK=n
CONFIG_DREI_BK=n
CONFIG_VIER_BK=n
CONFIG_C6DEV_BK=n
CONFIG_FOUNF_BK=y

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

if [ $CONFIG_C7HA_RL = "y" ]; then
	echo "c7ha release..."
	vboxmanage export "c7ha" -o ~/Documents/CentOS7-evaluate-pacemaker-gui-the-only-one/c7ha/c7ha-$RLDATE-release.ova --ovf20 --manifest --vsys 1
fi

if [ $CONFIG_EINS_BK = "y" ]; then
	echo "eins backup..."
	vboxmanage export "eins" -o ~/Documents/CentOS7-evaluate-pacemaker-gui-the-only-one/eins/eins-$BKDATE-backup.ova --ovf20 --manifest --vsys 1
fi

if [ $CONFIG_C6DEV_BK = "y" ]; then
        echo "c6dev backup..."
	vboxmanage export "c67i386dev" -o ~/Documents/Centos68-x86/c67i386dev/c67i386dev-$BKDATE-backup.ova --ovf20 --manifest --vsys 1
fi

if [ $CONFIG_ZWEI_BK = "y" ]; then
	echo "zwei backup..."
	vboxmanage export "zwei" -o ~/Documents/CentOS7-evaluate-pacemaker-gui-the-only-one/zwei/zwei-$BKDATE-backup.ova --ovf20 --manifest --vsys 1
fi

if [ $CONFIG_DREI_BK = "y" ]; then
	echo "drei backup..."
	vboxmanage export "drei" -o ~/Documents/CentOS7-evaluate-pacemaker-gui-the-only-one/drei/drei-$BKDATE-backup.ova --ovf20 --manifest --vsys 1
fi

if [ $CONFIG_VIER_BK = "y" ]; then
	echo "vier backup..."
	vboxmanage export "vier" -o ~/Documents/CentOS7-evaluate-pacemaker-gui-the-only-one/vier/vier-$BKDATE-backup.ova --ovf20 --manifest --vsys 1
fi

if [ $CONFIG_FOUNF_BK = "y" ]; then
	echo "founf backup..."
	vboxmanage export "founf" -o ~/Documents/CentOS7-evaluate-pacemaker-gui-the-only-one/founf/founf-$BKDATE-backup.ova --ovf20 --manifest --vsys 1
fi



# vboxmanage export "tt-ippbx1v" "tt-ippbx2v" -o ~/Documents/Centos68-x86/tatung/cluster/ippbx/tt-ippbx12v/tt-ippbx12v-$BKDATE-backup.ova --ovf20 --manifest --vsys 2
# vboxmanage export "tt-ha1v" "tt-ha2v" -o ~/Documents/Centos68-x86/tatung/cluster/ha/tt-ha12v/tt-ha12v-$BKDATE-backup.ova --ovf20 --manifest --vsys 2
# bucket list:
date
exit 0
