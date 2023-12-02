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

# html sort by price descending

python3 after_market.py $DATE 1

# @see https://stackoverflow.com/a/26249359
sort -k1 -n -t: -o "$DIR0/$DATE.csv" "$DIR0/$DATE.unsorted.csv"

# grep -rnp --color="auto" -e "6669" ./datafiles/taiex/after.market/????????.csv

ls -lt "$DIR0/$DATE.csv"
wc -l  "$DIR0/$DATE.csv"

cp -v "$DIR0/$DATE.csv" ~/Dropbox/after.market.$DATE.csv

# ./compare_volume.sh 20231129 20231128
N_DAYS=$(ls -lt datafiles/taiex/after.market/????????.csv | wc -l | xargs | cut -d " " -f1)
echo "there are $N_DAYS trade days recorded."
ls -lt datafiles/taiex/after.market/????????.csv | head -n 5

# ./compare_volume.sh 20231201 20231130
# ./uno_launch.sh datafiles/activity_watchlist.ods
# ./uno_vratio.sh 20231201 20231130
exit 0