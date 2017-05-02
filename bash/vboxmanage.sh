vboxmanage controlvm
vboxmanage list runningvms
vboxmanage list vms
vboxmanage startvm "c67i386dev" --type headless
vboxmanage controlvm "w7u32bitMpoll" poweroff
vboxmanage export tt-ippbx2 -o ~/Documents/Centos68-x86/tatung/cluster/ippbx/tt-ippbx2.ova
# vboxmanage list snapshot
vboxmanage snapshot "tt-ha2v" list
# vboxmanage restore snapshot
vboxmanage snapshot "tt-ha2v" restore "Snapshot 4"
# create snapshot
vboxmanage snapshot "tt-ha2v" take "Snapshot 5"
# discard snapshot
