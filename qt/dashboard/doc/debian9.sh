#!/bin/bash
# set timezone ( https://to.ly/1yXR8 )
# install development tools ( https://to.ly/1yXRk )
sudo apt update
sudo apt install build-essential
# How To Extract RAR Archives In Debian ( https://to.ly/1yXS4 )
sudo apt install unrar-free tree minicom hddtemp
# debian9 install kernel source to build module
# Build Linux Kernel Module Against Installed Kernel w/o Full Kernel Source Tree
# @see https://tinyurl.com/j4jdqjj
# run as root
apt-get install linux-headers-$(uname -r)
# building driver example ( https://to.ly/1yYri )
# run as root
# cd /usr/src/linux-headers-4.9.0-9-amd64/
cd /usr/src/linux-headers-$(uname -r)/
mkdir -p NEXCOM_CAN1
cd NEXCOM_CAN1/
# vi Makefile, add one line
cp /home/racev/Downloads/R1.4/driver/NEXCOM_CAN1.c .
# copy Makefile as well
root@debian:/usr/src/linux-headers-4.9.0-11-amd64/NEXCOM_CAN1# cp /home/racev/Downloads/3.0.1.CAN01/R1.4/driver/Makefile .
# make -C /usr/src/linux-headers-4.9.0-9-amd64/ M='/usr/src/linux-headers-4.9.0-9-amd64/NEXCOM_CAN1' modules
make -C /usr/src/linux-headers-$(uname -r)/ M='/usr/src/linux-headers-'$(uname -r)'/NEXCOM_CAN1' modules
insmod NEXCOM_CAN1.ko
lsmod | grep NEXCOM_CAN1
# change permission / writing udev rules / to load at boot
# ref. ( readme.sh, line 60 )
# add entry to /etc/modules-load.d/modules.conf( different from fedora )
# copy NEXCOM_CAN1.ko to ?
# ref. ( NEXCOM_CAN1 Makefile example, modules_install )

# module configuration file
root@debian:/usr/src/linux-headers-4.9.0-11-amd64# ls -ltr /dev/NEXCOM_CAN1
crw------- 1 root root 246, 0 Oct  3 11:58 /dev/NEXCOM_CAN1

# udev file
root@debian9xfce:/etc/udev/rules.d# ls -ltr
-rw-r--r-- 1 root root   62 May 13 17:45 70-NEXCOM_CAN1.rules
touch /etc/udev/rules.d/70-NEXCOM_CAN1.rules

# cd /usr/src/linux-headers-4.9.0-9-amd64/NEXCOM_CAN1/
# make modules_install,
# udev rules ( https://to.ly/1z26f ),
# load modules at boot
KERNEL=="NEXCOM_CAN1", SUBSYSTEM=="NEXCOM_CAN1", MODE="0666"
# before:
root@debian:/usr/src/linux-headers-4.9.0-11-amd64# ls -ltr /dev/NEXCOM_CAN1
crw------- 1 root root 246, 0 Oct  3 11:58 /dev/NEXCOM_CAN1
# after:
racev@debian:~$ ls -ltr /dev/NEXCOM_CAN1
crw-rw-rw- 1 root root 246, 0 Oct  3 13:10 /dev/NEXCOM_CAN1


# checking if module loaded using lsmod
# @see https://tinyurl.com/yxc6vs5ja
# udev rules number is "sorted and processed in lexical order"
# @see https://tinyurl.com/yyzkg9s9
# -rw-r--r-- 1 root root   62 Aug 28 17:18 65-NEXCOM_SMBus.rules
# root@debian9xfce:/etc/udev/rules.d# vi 65-NEXCOM_SMBus.rules
racev@debian:~/Downloads/3.0.5.G-Sensor$ tar -vxf G-sensorR10.tar
mkdir -p /usr/src/linux-headers-4.9.0-11-amd64/NEXCOM_SMBus/
cd /usr/src/linux-headers-4.9.0-11-amd64/NEXCOM_SMBus/
cp /home/racev/Downloads/3.0.5.G-Sensor/G-sensorR1.0/install/Makefile .
cp /home/racev/Downloads/3.0.5.G-Sensor/G-sensorR1.0/install/NEXCOM_SMBus.c .
root@debian:/usr/src/linux-headers-4.9.0-11-amd64/NEXCOM_SMBus# cp /home/racev/Downloads/3.0.5.G-Sensor/G-sensorR1.0/install/install.sh .
make -C /usr/src/linux-headers-$(uname -r)/ M='/usr/src/linux-headers-'$(uname -r)'/NEXCOM_SMBus' modules
# /usr/src/linux-headers-4.9.0-11-amd64/NEXCOM_SMBus/NEXCOM_SMBus.c:86:10: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
  .read = NEXCOM_SMBus_read,
# change from int to 'ssize_t' to solve the issue
# ref.BUG1:編譯時出現下面的報錯
# @see https://tinyurl.com/y3nr3owl
# notes to pdf as well:
# 2. change return type of R/W function pointer
# 3. @see https://tinyurl.com/y27puyx4
echo "NEXCOM_SMBus" > /etc/modules-load.d/NEXCOM_SMBus.conf
touch /etc/udev/rules.d/65-NEXCOM_SMBus.rules
cat /etc/udev/rules.d/65-NEXCOM_SMBus.rules
KERNEL=="NEXCOM_SMBus", SUBSYSTEM=="NEXCOM_SMBus", MODE="0666"
insmod NEXCOM_SMBus.ko
lsmod | grep NEXCOM_SMBus
ls -ltr /dev/NEXCOM_SMBus
# ( the right NEXCOM_SMBus.conf such that the right permission after insmod )
root@debian:/usr/src/linux-headers-4.9.0-11-amd64/NEXCOM_SMBus# ./install.sh

#
root@debian:/usr/src/linux-headers-4.9.0-11-amd64/NEXCOM_IO# cp /home/racev/Downloads/3.0.6.GPS/VTC6210_Linux_SDK1_2/IO_R1.2/install/revised/NEXCOM_IO.c .
root@debian:/usr/src/linux-headers-4.9.0-11-amd64/NEXCOM_IO# cp /home/racev/Downloads/3.0.6.GPS/VTC6210_Linux_SDK1_2/IO_R1.2/install/install.sh .
root@debian:/usr/src/linux-headers-4.9.0-11-amd64/NEXCOM_IO# cp /home/racev/Downloads/3.0.6.GPS/VTC6210_Linux_SDK1_2/IO_R1.2/install/Makefile .
make -C /usr/src/linux-headers-$(uname -r)/ M='/usr/src/linux-headers-'$(uname -r)'/NEXCOM_IO' modules
touch /etc/udev/rules.d/68-NEXCOM_IO.rules
# and add:
KERNEL=="NEXCOM_IO", SUBSYSTEM=="NEXCOM_IO", MODE="0666"

# debian 9 start program at boot
# How do I make a program auto-start every time I log in?
# @see https://tinyurl.com/yx9889dm
# application autostart -
# setting session and startup / add command line and arguments
# panel 1
# remove panel 2


# minicom / expect(xautomation) / QProcess to get output
# /etc/minicom/minirc.dfl
# bring-up GPS:
[racev@localhost OtherIO]$ pwd
/home/racev/Documents/6.NEXCOM/VTC6210_Linux_SDK1_2/IO_R1.2/demo/OtherIO
[racev@localhost OtherIO]$ gcc demo_GPS_Power_Switch.c OtherIO.c -o demo_GPS_Power_Switch
      ^~~~~~~~~~~~~~~~~~~~~~~~~
[racev@localhost OtherIO]$ ./demo_GPS_Power_Switch
Please select what you wnat to set:
0) Disable GPS power.
1) Enable GPS power.
Please select the number (0~1):
minicom -b 9600 -o -D /dev/ttyS3
# on debian9: first start
minicom -D /dev/ttyS3
groups racev
# add to group
usermod -a -G dialout racev
# // TODO: via udev rules
# root: chmod 666 /dev/ttyS3

# MC7304 driver on Debian9
# @see https://tinyurl.com/y6dcgv6h
# Linux QMI Driver @see https://tinyurl.com/y4nuqcx6
# email register is required, using 'stewart.shih@racev.com'
# ( download previously )
# check 08/27 email
# tar xjvf SierraLinuxQMIdriversS2.37N2.58.tar.bz2
root@debian:/home/racev/Downloads/3.0.4.LTE# cp -r GobiNet/ /usr/src/linux-headers-4.9.0-11-amd64/
root@debian:/home/racev/Downloads/3.0.4.LTE# cp -r GobiSerial/ /usr/src/linux-headers-4.9.0-11-amd64/
make -C /usr/src/linux-headers-$(uname -r)/ M='/usr/src/linux-headers-'$(uname -r)'/GobiNet' modules
root@debian:/usr/src/linux-headers-4.9.0-11-amd64/GobiSerial#
make -C /usr/src/linux-headers-$(uname -r)/ M='/usr/src/linux-headers-'$(uname -r)'/GobiSerial' modules

OUTPUTDIR=/lib/modules/`uname -r`/kernel/drivers/usb/serial/

install: all
        mkdir -p $(OUTPUTDIR)
        cp -f GobiSerial.ko $(OUTPUTDIR)
        depmod
# as well as 'GobiNet'
# reboot and dmesg will find loaded
root@debian:~#
lsmod | grep Gobi
# next is to 'setup'
# mPCiE Modem QMI Interface Internet Connection Setup #1
# @see https://tinyurl.com/y43tvhf2
root@debian:~# apt-get install libqmi-utils

# MC7304 Driver Problem on Debian
# @see https://tinyurl.com/y6dcgv6h
ttyUSB0 - DM port (not useful for me)
ttyUSB1 - NMEA GPS data (needs blindly “echo $GPS_START > /dev/ttyUSB1” to enable data output)
ttyUSB2 - AT port (modem)
# Can see more output with modem-manager-cli
mmcli -m 0
# AirPrime MC73XX-8805 AT Command Reference
# @see https://tinyurl.com/y6fpntap

# echo is faster than minicom way:
# @see https://tinyurl.com/y6dcgv6h

# reference doc: Qualcomm Gobi Device on Linux
# @see https://tinyurl.com/yxowq6mn

# make sure module loading @see https://tinyurl.com/y3jyudy2
# root@debian:~# as module
grep -rn --color="auto" -e "CONFIG_USB_NET_QMI_WWAN" /boot/config-$(uname -r)

# via mmcli (TBD):
racev@debian:~$ mmcli -m 0 | grep -e "imei"
  3GPP     |           imei: '356853051908038'
mmcli -m 0 | grep -e "signal quality"
racev@debian:~$ mmcli -m 0 | grep -e "state"
           |          state: 'registered'
           |    power state: 'on'
/org/freedesktop/ModemManager1/Modem/0
racev@debian:~$ mmcli -L

Found 1 modems:
	/org/freedesktop/ModemManager1/Modem/0 [Sierra Wireless, Incorporated]
# man page @see https://tinyurl.com/y8xrs9wn
mmcli -m 0 --simple-connect="pin=1234,apn=internet"
nmcli dev status

# via qmicli
# how to get IMEI ( by way of root rc.local redirect IMEI.cfg ):
# qmicli --device=/dev/cdc-wdm0 --device-open-proxy --dms-get-ids | grep -e "IMEI" | grep -oP "(?<=').*?(?=')" > /home/racev/IMEI.cfg
# grep a string between two single quotes
# ( https://stackoverflow.com/a/35202408 )
# Automatically execute script at Linux startup with Debian 9 (Stretch)
# ( https://is.gd/RZu8Ej )

# How to set up a simple data connection
# over Qualcomm QMI interface using libqmi and driver qmi_wwan in Linux?
# @see https://tinyurl.com/y2uartjg

# How to use 4G LTE modems like the MC7455 on both Debian/Ubuntu and OpenWRT using MBIM
# @see https://tinyurl.com/yxd576kz

# The VID/PID of the MC7xxx when in QMI mode is 1199/68A2
# @see https://tinyurl.com/y6dcgv6h
# Technically it possible to change VID/PID of the unit through the at!udpid command
# @see https://tinyurl.com/yyaxq96h
# /dev/cdc-wdm0 (wwp0s29u1u4u4i8)
# @see https://tinyurl.com/yyvlplzg

qmi-network /dev/cdc-wdm0 start
qmi-network /dev/cdc-wdm0 status
# check/reconfigure the modems data link format method to 802-3
# @see https://tinyurl.com/y43tvhf2
qmicli -d /dev/cdc-wdm0 --wda-get-data-format
qmicli -d /dev/cdc-wdm0 --wda-set-data-format=802-3
# Loading profile at /etc/qmi-network.conf...

# SIMs APN configuration is set by creating and then adding a line to /etc/qmi-network.conf
# How to step by step set up a data connection over QMI interface
# @see https://tinyurl.com/y4a9fhwe
# If a SIM pin is required for the SIM card,
qmicli --device=/dev/cdc-wdm0 -p --dms-uim-verify-pin=PIN,0000
# The name of the related network interface to QMI control channel can be acquired:
qmicli --device=/dev/cdc-wdm0 --device-open-proxy --get-wwan-iface
# enable network interface:
ip link set dev wwp0s29u1u4u4i8 up
# data connection in the cellular module can be activated:
qmicli --device=/dev/cdc-wdm0 --device-open-proxy --wds-start-network="ip-type=4,apn=emome" --client-no-release-cid
# when started, send a DHCP request on the network interface.
udhcpc -q -f -n -i wwp0s29u1u4u4i8
echo "APN=emome" >/etc/qmi-network.conf
apt-get install udhcpc
# set udev rules for Sierra Wireless
# @see https://tinyurl.com/y4qj9yqg
qmicli -d /dev/cdc-wdm0 --wds-get-packet-statistics
