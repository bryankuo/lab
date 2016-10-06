#!/bin/bash
# dropbox
# development tools
sudo apt-get update
sudo apt-get upgrade
sudo apt-get --assume-yes install git libncurses5-dev default-jre fcitx-chewing libpcsclite1 pcscd pcsc-tools nautilus-dropbox vim-gnome meld exuberant-ctags cscope ccache wireshark build-essential unity-tweak-tool libpcsclite1 pcscd pcsc-tools gstreamer0.10-plugins-base gstreamer0.10-plugins-good gstreamer0.10-x libgstreamer0.10-0 vlc gimp flashplugin-installer gcc-multilib g++-multilib cpufrequtils lvm2 mysql-workbench-community btrfs-tools unrar-free p7zip-full gnome-panel sshpass tshark tcpdump libtool autoconf xclip

# wireshark
# wireshark add non-root capture
# http://goo.gl/rd8XGq
sudo groupadd wireshark
sudo usermod -a -G wireshark bryan
sudo chmod 750 /usr/bin/dumpcap
# need to restart to take effect
# sudo apt-get install --assume-yes wireshark
sudo groupadd wireshark
sudo usermod -a -G wireshark $USER
sudo chgrp wireshark /usr/bin/dumpcap
sudo chmod 750 /usr/bin/dumpcap
sudo setcap cap_net_raw,cap_net_admin=eip /usr/bin/dumpcap
sudo getcap /usr/bin/dumpcap
# need to restart to take effect

# common access card utility
# ( https://goo.gl/t6WwO )
sudo apt-get install libpcsclite1 pcscd pcsc-tools
# cpu tool
sudo apt install cpufrequtils
# xnview
sudo apt-get -y install gstreamer0.10-plugins-base gstreamer0.10-plugins-good gstreamer0.10-x libgstreamer0.10-0
wget http://download.xnview.com/XnViewMP-linux-x64.deb
sudo dpkg -i XnViewMP-linux-x64.deb

# jdk
sudo apt-get install openjdk-8-jdk
# wget? android studio
JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/ ./studio.sh

# line chrome extension

# git configuration
git config --global diff.external meld
cp ~/github/git/git-meld.sh ~
git config --global diff.external ~/git-meld.sh
