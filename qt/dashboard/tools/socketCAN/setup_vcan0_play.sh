 #!/bin/bash
sudo modprobe vcan
sudo ip link add dev vcan0 type vcan
sudo ip link set up vcan0
#sudo ip link set up can0 type can bitrate 250000
# // FIXME: not support
# sudo ip link set up vcan0 type can bitrate 250000 restart-ms 100
lsmod | grep vcan
ip a | grep vcan0
# canplayer -vl i -g 100 -s 1 -t -I candump-dsim-bam.log
 canplayer -vl i -g 20 -s 1 -t -I \
    /home/racev/Documents/8.socketcan/sja1000-cap.txt
# sudo ip link set vcan0 down
# sudo ip link del dev vcan0
# ip a | grep vcan0
exit 0
