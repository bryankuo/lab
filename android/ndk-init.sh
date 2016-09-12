#!/bin/sh

# http://goo.gl/3Oapo0

export ANDROID_NDK=/home/bryan/android/ndk/android-ndk-r9d
export ANDROID_SDK=/home/bryan/adt-bundle-linux-x86-20140702/sdk
export PATH=$PATH:$ANDROID_SDK/tools:$ANDROID_SDK/platform-tools:$ANDROID_NDK

echo "ANDROID_NDK = "$ANDROID_NDK
echo "ANDROID_SDK = "$ANDROID_SDK
echo "Done!"

