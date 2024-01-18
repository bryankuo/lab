#!/bin/bash

# ./after_market.sh [yyyymmdd]
#
# a wrapper of after_market.py
#
# \param in yyyymmdd

if [ "$#" -lt 1 ]; then
    echo "usage: ./after_market.sh [yyyymmdd]"
    exit 22 # @see https://stackoverflow.com/a/50405954
fi

DATE=$1
DIR0="./datafiles/taiex/after.market"

python3 after_market.py $DATE 0
python3 after_market.py $DATE 1

currenttime=$(date +%H:%M)
TIME=${currenttime:0:2}${currenttime:3:2}
cp -v "$DIR0/$DATE.all.columns.csv" "$DIR0/$DATE.$TIME.all.columns.csv"

echo "sorting..."
# html sort by price descending
# @see https://stackoverflow.com/a/26249359
sort -k1 -n -t: -o "$DIR0/$DATE.csv" "$DIR0/$DATE.unsorted.csv"
# grep -rnp --color="auto" -e "6669" ./datafiles/taiex/after.market/????????.csv
wc -l  "$DIR0/$DATE.csv"
N_DAYS=$( ls -lt datafiles/taiex/after.market/????????.csv \
    | wc -l | xargs | cut -d " " -f1 )
echo "there are $N_DAYS trade days recorded."
ls -lt $DIR0/????????.csv | head -n 3

# ./after_market.sh 20231201
# ./uno_launch.sh datafiles/activity_watchlist.ods
#read -p "save to ods, and let focus when ready ..."
# ./uno_bquote.sh 20231201

exit 0
