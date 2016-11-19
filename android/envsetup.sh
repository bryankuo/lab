#!/bin/sh

case "$1" in
android)
# export ANDROID_NDK=/home/bryan/android/ndk/android-ndk-r9d
# export ANDROID_SDK=/home/bryan/adt-bundle-linux-x86-20140702/sdk
# export PATH=$PATH:$ANDROID_SDK/tools:$ANDROID_SDK/platform-tools:$ANDROID_NDK
# echo "ANDROID_NDK = "$ANDROID_NDK
# echo "ANDROID_SDK = "$ANDROID_SDK
;;

gradle)
export GRADLE_HOME=/usr/local/bin/gradle-2.8
export PATH=$PATH:$GRADLE_HOME/bin
echo "GRADLE_HOME = "$GRADLE_HOME
;;

ccache)
export USE_CCACHE=1
# /dev/mapper/ubuntu--vg-ccache on /home/bryan/.ccache type ext4 (rw)
export CCACHE_DIR=/home/bryan/.ccache
;;

aosp)
# must running as root!
export USE_CCACHE=1
export CCACHE_DIR=/home/bryan/.ccache
export OUT_DIR_COMMON_BASE=/home/bryan/out
export WORKING_DIRECTORY=/home/bryan/source
export PATH=~/bin:$PATH
export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH
;;

*)
echo "Usage: $0 [android|gradle|ccache]"
;;

esac

echo "envsetup" $1 "is done!"

# TODO: with parameter, android, gradle, etc...
