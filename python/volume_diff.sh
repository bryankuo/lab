#!/bin/bash

# ./volume_diff.sh
#
# to see recent 2 volume changes
#

DATE=$(date +%Y%m%d)
DIR0="./datafiles/taiex/after.market"

python3 after_market.py $DATE 0
python3 after_market.py $DATE 1

echo "sorting..."
# html sort by price descending
# @see https://stackoverflow.com/a/26249359
sort -k1 -n -t: -o "$DIR0/$DATE.csv" "$DIR0/$DATE.unsorted.csv"

currenttime=$(date +%H:%M)
cp -v "$DIR0/$DATE.csv" "$DIR0/$DATE.${currenttime:0:2}${currenttime:3:2}.csv"
ls -lt $DIR0/$DATE.????.csv | head -n 2
# ls -lt datafiles/taiex/after.market/20231213.????.csv
THIS_TIME=$( ls -lt $DIR0/$DATE.????.csv | head -n 2 \
    | cut -d '/' -f 5 | cut -c 1-13 | xargs | cut -d ' ' -f 1 )
LAST_TIME=$( ls -lt $DIR0/$DATE.????.csv | head -n 2 \
    | cut -d '/' -f 5 | cut -c 1-13 | xargs | cut -d ' ' -f 2 )

./compare_volume.sh $THIS_TIME $LAST_TIME
./uno_launch.sh "./datafiles/activity_watchlist.ods"
tput bel
echo "volume_diff.sh $THIS_TIME $LAST_TIME"
read -p "Press enter to continue ..."
./uno_vratio.sh $THIS_TIME $LAST_TIME

exit 0
