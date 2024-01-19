#!/bin/bash

# ./volume_diff.sh
#
# to see recent 2 volume changes
#

DATE=$(date +%Y%m%d)
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

cp -v "$DIR0/$DATE.csv" "$DIR0/$DATE.$TIME.csv"

ls -lt $DIR0/$DATE.????.csv | head -n 2
# ls -lt datafiles/taiex/after.market/20231213.????.csv
RIGHT_NOW=$( ls -lt $DIR0/$DATE.????.csv | head -n 2 \
    | cut -d '/' -f 5 | cut -c 1-13 | xargs | cut -d ' ' -f 1 )
LAST_TIME=$( ls -lt $DIR0/$DATE.????.csv | head -n 2 \
    | cut -d '/' -f 5 | cut -c 1-13 | xargs | cut -d ' ' -f 2 )

python3 compare_volume.py $RIGHT_NOW $LAST_TIME
tput bel
read -p "open calc..."
./uno_launch.sh "./datafiles/activity_watchlist.ods"

tput bel
read -p "Press enter update vt1, vt0, $RIGHT_NOW $LAST_TIME"
/Applications/LibreOffice.app/Contents/Resources/python \
    uno_vratio.py $RIGHT_NOW $LAST_TIME

tput bel

exit 0
