#!/bin/bash

# Simply running u-boot

# make versatilepb_config ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- distclean
# make versatileqemu_config
# time make -j2 -s ARCH=arm CROSS_COMPILE=arm-linux-gnueabi-

# To notice - it has not specified CPU.
qemu-system-arm \
 -M vexpress-a9 \
 -m 1024m \
 -serial stdio \
 -sd /home/bryan/raspberrypi/simple.img \
 -kernel /usr/local/src/u-boot/u-boot

# gdb-multiarch
