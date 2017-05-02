vboxmanage controlvm
vboxmanage controlvm "tt-ha2v" pause
vboxmanage controlvm "tt-ha2v" resume
vboxmanage controlvm "w7u32bitMpoll" poweroff
vboxmanage list runningvms
vboxmanage list vms
vboxmanage startvm "c67i386dev" --type headless
vboxmanage export tt-ippbx2 -o ~/Documents/Centos68-x86/tatung/cluster/ippbx/tt-ippbx2.ova

# vboxmanage list snapshot
vboxmanage snapshot "tt-ha2v" list
# vboxmanage restore snapshot
vboxmanage snapshot "tt-ha2v" restore "Snapshot 4"
# create snapshot
vboxmanage snapshot "tt-ha2v" take "Snapshot 5"
# discard snapshot
vboxmanage snapshot "tt-ha2v" delete "Snapshot 3"
