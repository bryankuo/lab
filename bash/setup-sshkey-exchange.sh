#!/bin/bash

# source dir.mk
# assume user 'apexx':
# number of user at destination is possibly more than 2 (apexx, root)...

DST_HOST=tt-ha2

cd ~
# (all)
ssh-keygen -t rsa
# create another for drbd backed partition ( when online ):
# ssh-keygen -t 'rsa' -f .ssh/id_rsa_drbd
# (enter)
# (enter)

# local:
# ls -latr .ssh/id_rsa
chmod 700 /home/$USER/.ssh/id_rsa

# destination
sudo vi /etc/ssh/sshd_config
# assume line number the same
sudo sed -i "42s/.*/PermitRootLogin without-password/" /etc/ssh/sshd_config
sudo service sshd restart

# source
# PermitRootLogin yes to allow login manually via ssh
# sudo sed -i "42s/.*/PermitRootLogin yes/" /etc/ssh/sshd_config
# sudo -i
# copy public key
ssh-copy-id root@$DST_HOST
ssh-copy-id $USER@$DST_HOST
# can not use this name, or you will have to specify the file like:
# ssh -v -v -v -i .ssh/id_rsa_drbd tt-ippbx2 -- sudo shutdown -Fah now;
# openssh is hardcoded with 'id_rsa'
# ssh-copy-id -i .ssh/id_rsa_drbd.pub root@DST_HOST
# ssh-copy-id -i .ssh/id_rsa_drbd.pub $USER@DST_HOST

# (offline, destination, user, directory, file):
# ls -latr /home/ , 755
# sudo chown apexx:apexx /home/apexx ?
chmod 755 /home/$USER
# ls -latr /home/apexx/, (note the ownership)
# sudo chown -R apexx:apexx /home/apexx/.ssh/ ?
chmod 700 /home/$USER/.ssh/
# ls -latr /home/apexx/.ssh/authorized_keys
chmod 700 /home/$USER/.ssh/authorized_keys
# online ( partition changed ):
cp -R .ssh/ /tmp/
# cluster down,  then mount (up)
mv /tmp/.ssh/ .
exit 0;
