#!/bin/bash

export PATH=~/bin:$PATH
export USE_CCACHE=1
export CCACHE_DIR=~/out/ccache
export OUT_DIR_COMMON_BASE=/home/out

#source build/envsetup.sh
#prebuilts/misc/linux-x86/ccache/ccache -M 50G
#lunch aosp_arm-eng

#for source tree
#/source/master1 and /source/master2

#the output dir
#/output/master1 and /output/master2

#make -j8
#emulator
#make clean
#time make -j8 showcommands
