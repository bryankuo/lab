#!/bin/bash

source ./devices.sh

adb -s $DEVICE -d logcat -c

rm -f $OUTPUT

# TelephonyManager:V
# PreferencesProviderWrapper:V  DeviceStateReceiver:V 
# MediaManager:V
#

#SYSTEM0="ConnectivityService:V"
#SYSTEM1="MobileDataStateTracker:V MobileDataStateTracker:V"
#SYSTEM2="DataConnection:V DataConnectionTracker:V  ConnectivityManager:V"
#SYSTEM3="GsmDataConnectionTracker:V WiFiManager:V"
#SYSTEM=""

#PJSIP="pjsua_acc.c:V"

#APP0="DeviceStateReceiver:V DialerFragment:V DialerCallBar:V"
#APP="SipHome:V DialerFragment:V DialerCallBar:V"

#CLASS="$PJSIP $APP"  DialerFragment:V 

#FILTER=''  -s '*:S'
adb -s $DEVICE -d logcat -v time "MediaManager:V UAStateReceiver:V PjSipService:V AudioFocus8:V DialerFragment:V" -s '*:S' | tee -a $OUTPUT ; ( exit ${PIPESTATUS} )

#persistent on-device logcat:
#logcat -v time -r 512 -n 32 -f /storage/sdcard0/CSipSimple/logs/logcat-hwuawei.log "SipService:V SipHome:V DialerFragment:V DialerCallBar:V" -s '*:S' &
#adb pull /storage/sdcard0/CSipSimple/logs/logcat-hwuawei.log
#source ./ndk-init.sh
#ndk-build

