#!/bin/bash

# ./after_market.sh [yyyymmdd]
#
# a wrapper of after_market.py
#
# \param in yyyymmdd

if [ "$#" -lt 1 ]; then
#    echo "usage: ./after_market.sh [yyyymmdd]"
#    exit 22 # @see https://stackoverflow.com/a/50405954
    DATE=$(date +%Y%m%d)
else
    DATE=$1
fi

DIR0="$HOME/github/python/datafiles/taiex/after.market"
# instead of xcode command line
PATH="/Library/Frameworks/Python.framework/Versions/3.9/bin:${PATH}"
export PATH

python3 $HOME/github/python/after_market.py $DATE 0
python3 $HOME/github/python/after_market.py $DATE 1

currenttime=$(date +%H:%M)
TIME=${currenttime:0:2}${currenttime:3:2}
/bin/cp "$DIR0/$DATE.all.columns.csv" "$DIR0/$DATE.$TIME.all.columns.csv"

# echo "sorting..."
# html sort by price descending
# @see https://stackoverflow.com/a/26249359
/usr/bin/sort -k1 -n -t: -o "$DIR0/$DATE.csv" "$DIR0/$DATE.price.desc.csv"
# grep -rnp --color="auto" -e "6669" ./datafiles/taiex/after.market/????????.csv
# wc -l  "$DIR0/$DATE.csv"
# N_DAYS=$( ls -lt datafiles/taiex/after.market/????????.csv \
#     | wc -l | xargs | cut -d " " -f1 )
# echo "there are $N_DAYS trade days recorded."
# ls -lt $DIR0/????????.csv | head -n 3

# ./after_market.sh 20231201
# ./uno_launch.sh datafiles/activity_watchlist.ods
#read -p "save to ods, and let focus when ready ..."
# ./uno_bquote.sh 20231201

# // TODO: if market is closed, count # of up, down
#if [[ "$currenttime" > "13:31" ]]; then
# fi

exit 0
