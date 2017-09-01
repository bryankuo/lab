#!/bin/bash

# source dir.mk
# assume user 'apexx':
# number of user at destination is possibly more than 2 (apexx, root)...

DST_HOST=tt-ha2

cd ~
# (all)
ssh-keygen -t rsa
# create another for drbd backed partition:
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
ssh-copy-id root@$DST_HOST
ssh-copy-id $USER@$DST_HOST
# ssh-copy-id -i .ssh/id_rsa_drbd root@tt-ha2
# ssh-copy-id -i .ssh/id_rsa_drbd apexx@tt-ha2

# (offline, destination, user, directory, file):
# ls -latr /home/
chmod 755 /home/$USER
# ls -latr /home/apexx/
chmod 700 /home/$USER/.ssh/
# ls -latr /home/apexx/.ssh/authorized_keys
chmod 700 /home/$USER/.ssh/authorized_keys
# online ( partition changed ):
cp -R .ssh/ /tmp/
# cluster down,  then mount (up)
mv /tmp/.ssh/ .
exit 0;
