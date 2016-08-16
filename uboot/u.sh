#!/bin/bash

# Simply running u-boot

# make versatilepb_config ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- distclean
# make versatileqemu_config
# time make -j2 -s ARCH=arm CROSS_COMPILE=arm-linux-gnueabi-

# To notice - it has not specified CPU.
qemu-system-arm \
 -M versatilepb \
 -m 128M \
 -serial stdio \
 -no-reboot \
 -kernel /usr/local/src/u-boot/u-boot \
 -S \
 -s

# gdb-multiarch
