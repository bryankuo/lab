#!/bin/bash

# Creating a live Fedora USB image from the command line
# ( https://goo.gl/DoYFct )
dd if=Fedora20-Live-X64-KDE.iso of=/dev/sdb

# Step 2. Update Fedora Linux using the terminal dnf command
# ( https://goo.gl/QTjD4v )
sudo dnf update

# fedora disable selinux ( https://goo.gl/d0RfQ7 )
# fedora disable firewall ( https://goo.gl/iVT9PT )
# install unar, 7zip
# dnf groupinstall "Development Tools" ( https://goo.gl/v1vdCg )
#

# dependency - QChart.js
cp /home/racev/Qt/5.12.0/gcc_64/qml/jbQuick/Charts/QChart.js \
    /home/racev/src/dashboard/qml/jbQuick/Charts/QChart.js
scp -r jbQuick/ racev@vtc6210bk:/home/racev/Qt/5.12.0/gcc_64/qml/
# copy Qt shared libraries to machine:
# ldd debug/dashboard | grep -e "Qt5"
cd /home/racev/src/dashboard/qml; scp -r jbQuick/ racev@vtc6210bk:/home/racev/Qt/5.12.0/gcc_64/qml/
bryan@waltz:~$ cp -pr src/dashboard/jbQuick/ ~/Qt/5.12.0/gcc_64/qml/
# QML2_IMPORT_PATH / Qt Creator Project RUN
# ( https://goo.gl/3Zh2ys )
# copy to : /home/racev/Qt/5.12.0/gcc_64/qml/jbQuick/Charts
# add to build environment in dashboard.pro file:
# PKG_CONFIG_PATH  /usr/lib/x86_64-linux-gnu/pkgconfig
# QML2_IMPORT_PATH /home/$(USER)/src/dashboard/jbQuick/Charts
# QML_IMPORT_PATH  /home/$(USER)/src/dashboard/jbQuick/Charts

# binary executable
/home/racev/dashboard

#add TinyTask mouse recording tool for CAN Assistant continuouse press

# use 4.8.0 as development base, qt framework 5.12.0 ( takes time )
# re-mount in order to reinstall qt ( https://goo.gl/Vma9wM ),
# at least 3G /tmp required for installation
mount -o remount,size=3G tmpfs /tmp
# in case size is not enough: @see https://tinyurl.com/y2ry7dtm
umount -l /tmp

# fedora gnome logon as user automatically ( https://goo.gl/4dFA4U )
# “startup applications” user config file ( https://goo.gl/a831Bh )
# ~/.config/autostart
# disable screen saver / setting / power / blank screen / never
# disable OS from locking screen ( https://goo.gl/Ltej6H )

# debian 9 install build essentials ( as root )
# @see https://tinyurl.com/y2dm3gtg
apt install build-essential
# media changed: @see Media change: please insert the disc labeled
# vi /etc/apt/sources.list and comment out 'cdrom'
apt-get install gdb tree

# install CANBus driver for SJA1000
# from: D:\3.供應商文件\3.0.nexcom-新漢智能\3.0.1.SAEJ1939_module摘要\source\R1.4\CANDriver
# initial & set baud & set filter / SJA1000 filtering / PGN
# ~/Downloads/3.0.1.CAN01$ tar -xvf R1.4.tar
# tar -xvf CANDriver.tar
# refer to manual for detailed steps.
# root@debian:/home/racev/Downloads/3.0.1.CAN01/R1.4/driver# make install
# also check debian9.sh
# grant non-root user access to device files ( https://goo.gl/ddCrwc )
sudo chmod +777 /dev/NEXCOM_CAN1
# however, mode changed back to 700. solution: ( https://goo.gl/6vP89j )
udevadm info -a -n /dev/NEXCOM_CAN1
# to see its subsystem
# write udev rules: ( https://goo.gl/h9pEfN ) / ( https://goo.gl/mLvWE5 )
# Udev rule to create node for character device when loading module
# ( https://goo.gl/UKuwc7 )
# KERNEL=="NEXCOM_CAN1" SUBSYSTEM=="NEXCOM_CAN1", ACTION=="add", RUN+="/bin/chmod +777 /dev/NEXCOM_CAN1"
# ( https://to.ly/1yYwy )
# MODE="0666"
# module configuration file is at /etc/modules-load.d/NEXCOM_CAN1.conf
# ( https://is.gd/350N6Y )
# root@debian:/usr/src/linux-headers-4.9.0-11-amd64# cat /etc/modules-load.d/NEXCOM_CAN1.conf
# NEXCOM_CAN1
# also check debian9.sh

#install G-sensor driver for NEXCOM VTC6210-BK
# from: D:\3.供應商文件\3.0.nexcom-新漢智能\3.0.5.G-Sensor
# also check debian9.sh

# bring up NEXCOM GPS
# from: D:\3.供應商文件\3.0.nexcom-新漢智能\3.0.6.GPS
# racev@debian:~/Downloads/3.0.6.GPS$ unzip VTC6210_Linux_SDK1_2.zip
# the rest steps please refers to the manual
racev@debian9xfce:~$ lsmod | grep NEXCOM
NEXCOM_IO              16384  0
NEXCOM_SMBus           16384  0
NEXCOM_CAN1            16384  3
# 65, 68, 70 acc, gps, can
root@debian9xfce:/etc/udev/rules.d# ls -ltr
-rw-r--r-- 1 root root   62 May 13 17:45 70-NEXCOM_CAN1.rules
-rw-r--r-- 1 root root 1162 Jun 19 14:59 20-modem-7304.rules
-rw-r--r-- 1 root root   64 Aug 28 17:19 65-NEXCOM_SMBus.rules
-rw-r--r-- 1 root root   64 Aug 29 16:45 68-NEXCOM_IO.rules

# fedora turn off automatic updates
# systemctl disable dnf-makecache.timer

# start dashboard by adding .desktop file
# /home/racev/.config/autostart/dashboard.desktop

# fedora 29 install kernel source to build module
# run as root source ( https://to.ly/1yXYQ )
# dnf download --source kernel ( current latest version )
dnf install ~/Downloads/kernel-$(uname -r).rpm
#
sudo dnf list 'kernel*'
# sudo dnf --refresh upgrade kernel-devel
# You can install the correct kernel header files like so:
# ( https://to.ly/1yY0N )
# yum install kernel-devel
# debian install kernel source to build module

# Qt source code location
# /home/racev/Qt/5.12.0/Src
# license,

Qt Quick 2 template uses QGuiApplication by default. As Qt Charts utilizes Qt Graphics View Framework for drawing, QApplication must be used.
( https://goo.gl/xri9xX )

Qt CAN Bus Documentation
( https://goo.gl/UYiKUg )
CANBus Qt example,
 CAN Bus example | Qt Serial Bus 5.12
 ( https://goo.gl/tMV6JY )
 'socketCAN' type
 /home/racev/Qt/Examples/Qt-5.12.0/serialbus/can

 Setup virtual CANBus interface
  sudo modprobe vcan
  sudo ip link add dev vcan0 type vcan
  sudo ip link set up vcan0
  cansend / candump ( https://goo.gl/Z4kQkt )
  cangen vcan0 -v
  log2asc
  canplayer
  cansniffer

CAN communication tutorial, using simulated CAN bus
( https://goo.gl/Z4kQkt )

Qt application communication?

# research via google, exclude qt domain:
-inurl:*.qt.io qt open source litigations

# a way to preview qml without running
# ( https://doc.qt.io/qt-5/qtquick-qmlscene.html )
~/Qt/5.12.0/gcc_64/bin/qmlscene HmiDashboard.qml
[racev@localhost dashboard]$ ~/Qt/5.12.0/gcc_64/bin/qmlscene qml/BatteryDeployment.qml

# a note on filtering linux system messages
grep -rnw --color="auto" -e "Kernel command line" -e "Linux version 4.9.0-9-amd64" -e "perf: interrupt took too long" messages*
# Redirect C++ std::clog to syslog on Unix ( https://tinyurl.com/y2hzdaq3 )

# building library
# scanning Qt source folder for:
find ./Qt/ -type f -iname 'LICENSE.GPL3'
find ./Qt/ -type f -iname 'LICENSE.*'

# modifying kernel boot parameter ( https://tinyurl.com/y9t9oa59 )
Command line: BOOT_IMAGE=/boot/vmlinuz-4.9.0-9-amd64 root=/dev/mapper/debian9xfce--vg-root ro quiet vt.global_cursor_default=0 loglevel=0 rd.systemd.show_status=false rd.udev.log_priority=0

# https://tinyurl.com/ogpo7be
sudo vi /etc/default/grub
# must run 'update-grub'
# background image: /usr/share/images/desktop-base/desktop-grub.png
# linux boot splash
# convert xpm @see https://tinyurl.com/y44kannh

# check list:
# pre-boot:
#  memtest86+
# boot-in-progress:
# /var/log/boot.log
# post-boot:
# /var/log/messages
# /var/log/syslog
# /var/log/daemon.log
# dmesg
# System.map
# magic SysRq key : ( https://tinyurl.com/yafqosnp )
# check /boot/config-4.9.0-9-amd64:
# CONFIG_MAGIC_SYSRQ=y
# CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x01b6
# CONFIG_DEBUG_KERNEL=y
# clean RAM gold finger with rubber

# /media/racev/1g or /media/racev/<media name>
# /home/racev/dashboard.d/alarm_tw_20190102.txt

# startup dashboard setting for debian9/xfce via .desktop file
# ~/.config/autostart
# @see https://tinyurl.com/y4luacf9
# @see https://askubuntu.com/a/437030

# add dynamic linking:
# as root:
cd /usr/local/include/
mkdir -p dashboard; cd dashboard
cp /home/racev/src/dashboard/can/handlers/*.h .
cd /home/racev/src/dashboard/can/handlers/dynamic/debug
cp libsharedHandlers.so.1.0.0 /usr/local/lib64/
cd /usr/local/lib64/
ln -s libsharedHandlers.so.1.0.0 libsharedHandlers.so
ln -s libsharedHandlers.so.1.0.0 libsharedHandlers.so.1
export LD_LIBRARY_PATH=/usr/local/lib64; ./dashboard 1 2 3
# LD_LIBRARY_PATH環境變數設定及Linux動態庫查詢方法
# @see https://tinyurl.com/yyt27dyg
# dashboard.pro.user
<value type="QString">PKG_CONFIG_PATH=/usr/local/lib64/pkgconfig</value>
<value type="QString">QML2_IMPORT_PATH=/home/racev/src/dashboard/qml/jbQuick/Charts</value>
<value type="QString">QML_IMPORT_PATH=/home/racev/src/dashboard/qml/jbQuick/Charts</value>

# Understand and configure core dumps on Linux
# @see https://tinyurl.com/y3orcune
# ulimit -c unlimited
# How to disable core dump files?
# @see https://tinyurl.com/y555ybbv
# ulimit -c 0
# gdb with arguments @see https://tinyurl.com/y2yhy6bv
gdb --args dashboard 1 2 345
# How to get a core dump for a segfault on Linux
# @see https://tinyurl.com/y2whedj4
# check coredump via gdb
# @see https://tinyurl.com/y3av3aby
# Where's the core file located in Linux?
# @see https://tinyurl.com/yyqtegye
# Understand and configure core dumps on Linux
# @see https://tinyurl.com/y67fm2uj
# @see https://tinyurl.com/yydncey5
info line *0x10045740

addr2line -e test1 400506
# @see https://tinyurl.com/yy6cwpst

# adxl345 z axis 1g offset calibration how to

# add crontab to user racev
# 3 */1 * * * find /home/racev/dashboard.d/vir -type f -maxdepth 1 -mmin +59 -exec rm {} +
3 */1 * * * find /home/racev/dashboard.d/vir -name "*.csv" -type f -maxdepth 1 -mtime +30 -exec rm -f {} +

# How to enable auto-login in Debian 9 Xfce
# @see https://tinyurl.com/y6ollcky
# as root
sudo nano /usr/share/lightdm/lightdm.conf.d/01_debian.conf
[SeatDefaults]
autologin-user=racev
autologin-user-timeout=0

# ip - DHCP
#

# How to install/change locale on Debian?
# @see https://tinyurl.com/y35ap9rm
# as root:
dpkg-reconfigure locales
# to confirm:
cat /etc/default/locale
#  File generated by update-locale
LANG=en_US.UTF-8

# for convenience:
ssh-copy-id -i ~/.ssh/id_rsa.pub racev@vtc6210bk

# copy dashboard binary to target
scp ./debug/dashboard racev@vtc6210bk:/home/racev/dashboard

# creating required directory:
mkdir -p /home/racev/dashboard.d/
mkdir -p /home/racev/dashboard.d/logs/
mkdir -p /home/racev/dashboard.d/vir/
touch /home/racev/dashboard.d/dashboard.cfg
# // TODO: create a script

# run on target:
~/dashboard A1 A2 ~/dashboard.d/dashboard.cfg
# and validating ldd dashboard required components:

# apt-get install libsasl2-modules if not installed
# root@debian:/usr/lib/x86_64-linux-gnu
ln -s libsasl2.so.2.0.25 libsasl2.so.3
# as root:
cd /usr/lib64
# to copy required shared libraries:
# Enable SSH root login on Debian Linux Server
# @see https://tinyurl.com/zocz8xr
scp -p libQt5Quick.so.5.11.1 root@vtc6210bk:/usr/lib/x86_64-linux-gnu/
# there is alreay some installed qt components on debian9, still required copy

# remote:
# copy from /home/racev/Qt/5.12.0/gcc_64/lib/
mkdir -p /home/racev/Qt/
mkdir -p /home/racev/Qt/5.12.0/
mkdir -p /home/racev/Qt/5.12.0/gcc_64/
mkdir -p /home/racev/Qt/5.12.0/gcc_64/lib/
scp -p libQt5Quick.so.5 libQt5Charts.so.5 libQt5Widgets.so.5 libQt5Gui.so.5 libQt5Qml.so.5 libQt5Network.so.5 libQt5SerialBus.so.5 libQt5SerialPort.so.5 libQt5Core.so.5 libicui18n.so.56 libicuuc.so.56 libicudata.so.56 racev@vtc6210bk:/home/racev/Qt/5.12.0/gcc_64/lib/

# add library path @see https://tinyurl.com/y5fvemfv
racev@debian:~$ LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/racev/Qt/5.12.0/gcc_64/lib/
racev@debian:~$ export LD_LIBRARY_PATH
racev@debian:~$ echo $LD_LIBRARY_PATH

# "kiosk mode modify pannel is not allowed" when logon
# @see https://tinyurl.com/y28f8f6f
# solution: remove files and relogon/reboot
# @see https://tinyurl.com/y46nj2sj
# @see https://tinyurl.com/yynf435z

# Xfce Power Manager:
# 1.security/Light Locker/Auto -> Never
# 2.Display/uncheck 'Handle display...'
# 3.Blank after 'x' minutes -> Never

# qt.qpa.plugin: Could not find the Qt platform plugin "xcb" in ""

# libnmea jacketizer
# install to target by manual, both development and target machine
root@debian:/home/racev/Downloads/1.18.8.jacketizer/libnmea-master# make install
# add Qt .so library path / qt creator add library dependency
# The proper way to do this is like this:
# @see https://tinyurl.com/y22x2esl
# to verify:
root@debian:/home/racev/Downloads/1.18.8.jacketizer/libnmea-master# echo -ne "\$GPGLL,4916.45,N,12311.12,W,225444,A,*1D\r\n" | build/parse_stdin
echo -ne "\$GNGLL,2501.10966,N,12113.97630,E,073206.00,A,D*77\r\n" | build/parse_stdin
# NMEA Revealed @see https://gpsd.gitlab.io/gpsd/NMEA.html
# GPS - NMEA sentence information
# @see https://tinyurl.com/69et8k

# ntp client
# @see https://tinyurl.com/y5c2gbmy
apt-get -y install ntpdate
# run as cron sync every hour
# @see https://tinyurl.com/y5dsgwta

set capability CAP_SYS_TIME to user 'racev'
trigger
get date
set time

# ubuntu @see https://tinyurl.com/y34t6s3c
sudo apt-get install can-utils

# Regarding Qt, beware that Qt uses a parent child ownership.
# @see https://tinyurl.com/y3xm6pp4
sudo apt-get -y install valgrind
sudo apt install -y linux-tools-common
