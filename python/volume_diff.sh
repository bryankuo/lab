#!/bin/bash

# ./volume_diff.sh [yyyymmdd]
#
# to see recent 2 volume changes
#
# \param in yyyymmdd

if [ "$#" -lt 1 ]; then
    echo "usage: ./volume_diff.sh [yyyymmdd]"
    exit 22
fi

DATE=$1
DIR0="./datafiles/taiex/after.market"

currenttime=$(date +%H:%M)
if [[ "$currenttime" > "09:00" ]] && [[ "$currenttime" < "13:30" ]]; then

    python3 after_market.py $DATE 0

    python3 after_market.py $DATE 1

    echo "sorting..."
    # html sort by price descending
    # @see https://stackoverflow.com/a/26249359
    sort -k1 -n -t: -o "$DIR0/$DATE.csv" "$DIR0/$DATE.unsorted.csv"

    cp -v "$DIR0/$DATE.csv" "$DIR0/$DATE.${currenttime:0:2}${currenttime:3:2}.csv"
    ls -lt $DIR0/$DATE.????.csv | head -n 2
    # ls -lt datafiles/taiex/after.market/20231213.????.csv
    THIS_TIME=$( ls -lt $DIR0/$DATE.????.csv | head -n 2 \
	| cut -d '/' -f 5 | cut -c 1-13 | xargs | cut -d ' ' -f 1 )
    LAST_TIME=$( ls -lt $DIR0/$DATE.????.csv | head -n 2 \
	| cut -d '/' -f 5 | cut -c 1-13 | xargs | cut -d ' ' -f 2 )

    ./compare_volume.sh $THIS_TIME $LAST_TIME
    ./uno_vratio.sh     $THIS_TIME $LAST_TIME
else
    echo "market yet open"
fi

exit 0
