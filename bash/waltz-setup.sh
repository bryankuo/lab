#!/bin/bash
# dropbox
# development tools
sudo apt-get update
sudo apt-get upgrade
sudo apt-get --assume-yes install git libncurses5-dev fcitx-chewing libpcsclite1 pcscd pcsc-tools nautilus-dropbox vim-gnome meld exuberant-ctags cscope ccache wireshark build-essential unity-tweak-tool libpcsclite1 pcscd pcsc-tools vlc gimp flashplugin-installer gcc-multilib g++-multilib cpufrequtils lvm2 btrfs-tools unrar-free p7zip-full gnome-panel sshpass tshark tcpdump libtool autoconf xclip net-tools gnome-nettool mediainfo mysql-workbench tree openssh-server curl

# bash ps1 ( https://superuser.com/a/60563 )
# /etc/network/interfaces
# ethtool for wake on lan

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
sudo apt install git
git config --global user.name "Bryan Kuo"
git config --global user.email bryan.kuo@apexx.com.tw
git config --global diff.external meld
cp ~/github/git/git-meld.sh ~
git config --global diff.external ~/git-meld.sh
# github configuration
mkdir -p /home/apexx/Documents/github
cd /home/apexx/Documents/github
git clone https://github.com/bryankuo/lab.git

# tor browser
sudo apt install torbrowser-launcher

# vi customization
cd ~/Documents/github/lab/vim/
cp -rp ./vim ~
cp -p .vimrc ~
cp -p .gvimrc ~

# linphone binary
sudo add-apt-repository ppa:linphone/release
sudo apt-get update
sudo apt-get install linphone -y

# android studio
sudo apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386

# pdftk on docker ( https://goo.gl/JmJyab )
# to run on ubuntu 18.04
sudo /usr/bin/pdftk
