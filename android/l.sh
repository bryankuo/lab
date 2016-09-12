#!/bin/bash

source ./devices.sh

adb -s $DEVICE -d logcat -c

rm -f $OUTPUT

# 
# ImageManager:V ListActivity:V ApexxWebChromeClient:V ApexxWebViewClient:V 
#   MainActivity:V EntryActivity:V WebActivityInterface:V WebActivity:V HorizontalListView:V
# RecvActivity:V MessageBoxActivity:V HorizontalListViewDemo:V
# 
CLASS='EntryActivity:V WebAppInterface:V ApexxWebChromeClient:V ApexxWebViewClient:V'

# -s '*:S' 
adb -s $DEVICE -d logcat -v time $CLASS -s '*:S' | tee -a $OUTPUT ; ( exit ${PIPESTATUS} )


