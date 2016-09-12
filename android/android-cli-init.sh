#!/bin/sh

# http://goo.gl/3Oapo0
# android create project --activity MyActivity --package com.bryan.myfirstapp --target android-21 --name MyFirstApp --path ~/test/MyFirstApp --gradle --gradle-version 0.12.+
# JAVA_HOME?
export ANDROID_NDK=/home/bryan/android/ndk/android-ndk-r9d
export ANDROID_SDK=/home/bryan/adt-bundle-linux-x86-20140702/sdk
export PATH=$PATH:$ANDROID_SDK/tools:$ANDROID_SDK/platform-tools:$ANDROID_NDK

export GRADLE_HOME=/usr/local/bin/gradle-2.8
export PATH=$PATH:$GRADLE_HOME/bin

echo "ANDROID_NDK = "$ANDROID_NDK
echo "ANDROID_SDK = "$ANDROID_SDK
echo "GRADLE_HOME = "$GRADLE_HOME
echo "Done!"

