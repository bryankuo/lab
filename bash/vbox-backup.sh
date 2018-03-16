#!/bin/bash
vboxmanage export "c7disneyland" -o ~/Documents/CentOS7-evaluate-pacemaker-gui-the-only-one/disneyland/c7disneyland-20180316-backup --ovf20 --manifest --vsys 1
vboxmanage export "c67i386dev" -o ~/Documents/Centos68-x86/c67i386dev/c67i386dev-20180316-backup.ova --ovf20 --manifest --vsys 1
vboxmanage export "tt-ippbx1v" "tt-ippbx2v" -o ~/Documents/Centos68-x86/tatung/cluster/ippbx/tt-ippbx12v/tt-ippbx12v-20180316-backup.ova --ovf20 --manifest --vsys 2
vboxmanage export "tt-ha1v" "tt-ha2v" -o ~/Documents/Centos68-x86/tatung/cluster/ha/tt-ha12v/tt-ha12v-20180316-backup.ova --ovf20 --manifest --vsys 2
exit 0
