#!/bin/bash

# ./count_ndays_last_high.sh
#
# count # of (trade) days to get new high
#
# \param in ticker
# \param in $DIR2/????????.all.columns.csv, on daily bases

DIR0="."
DIR2="$DIR0/datafiles/taiex/after.market"
DIR1="$DIR0/uno/unload"
DIR3="$DIR0/datafiles"
DIR4="/Applications/LibreOffice.app/Contents/Resources"

./uno_launch.sh "$DIR3/activity_watchlist.ods"

# // TODO:
d1=$( ls -lt $DIR2/????????.all.columns.csv | head -n 2 \
    | cut -d '/' -f 5 | cut -c 1-8 | xargs | cut -d ' ' -f 1 )

d0=$( ls -lt $DIR2/????????.all.columns.csv | head -n 2 \
    | cut -d '/' -f 5 | cut -c 1-8 | xargs | cut -d ' ' -f 2 )

# echo $d1 $d0
python3 $DIR1/slice_last_high.py $d1 $d0
$DIR4/python "$HOME/github/python/uno/load/addsheet.py" $d1

exit 0
