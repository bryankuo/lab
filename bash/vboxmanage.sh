vboxmanage controlvm
vboxmanage controlvm "tt-ha2v" pause
vboxmanage controlvm "tt-ha2v" resume
vboxmanage controlvm "w7u32bitMpoll" poweroff
vboxmanage list runningvms
vboxmanage list vms
vboxmanage startvm "c67i386dev" --type headless
vboxmanage startvm "c67i386dev" --type gui
vboxmanage export "c7disneyland" -o ~/Documents/CentOS7-evaluate-pacemaker-gui-the-only-one/disneyland/c7disneyland-20180316-backup.ova --ovf20 --manifest --vsys 1
vboxmanage export tt-ha1v tt-ha2v -o ~/Documents/Centos68-x86/tatung/cluster/ha/tt-ha12v.ova --ovf20 --manifest --vsys 2
vboxmanage import c7disneyland-20180319-backup.ova

# first time running assign --nic1 enp1s0
# VBoxManage modifyvm OracleLinux6Test --nic1 bridged --bridgeadapter1 eth0
# ( https://goo.gl/EAGQyi )

# vboxmanage list snapshot
vboxmanage snapshot "tt-ha2v" list
# vboxmanage restore snapshot
vboxmanage snapshot "tt-ha2v" restore "Snapshot 4"
# create snapshot
vboxmanage snapshot "tt-ha2v" take "Snapshot 5"
# discard snapshot
vboxmanage snapshot "tt-ha2v" delete "Snapshot 3"
vboxmanage unregistervm "eins" --delete

#clone VM with command
vboxmanage clonevm "eins" --name "founf" --register
# include all snapshots
vboxmanage clonevm "eins" --mode all --name "c7ha" --register
