#!/bin/bash

DST_HOST=tt-ha2v

ssh-keygen -t rsa
(enter)
(enter)
# source
chmod 700 /home/$USER/.ssh/id_rsa

# destination
sudo vi /etc/ssh/sshd_config
sudo sed -i "42s/.*/PermitRootLogin without-password/" /etc/ssh/sshd_config
# PermitRootLogin yes to allow login manually via ssh
# sudo sed -i "42s/.*/PermitRootLogin yes/" /etc/ssh/sshd_config
sudo service sshd restart

# source
ssh-copy-id root@$DST_HOST
ssh-copy-id $USER@$DST_HOST

# destination
# offline:
chmod 755 /home/$USER
chmod 700 /home/$USER/.ssh/
chmod 700 /home/$USER/.ssh/authorized_keys
# online ( partition changed ):
cp -R .ssh/ /tmp/
# cluster down,  then mount (up)
mv /tmp/.ssh/ .
exit 0;
