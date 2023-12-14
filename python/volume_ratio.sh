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
    # LAST_TIME=$( ls -lt $DIR0/$DATE.????.csv | head -n 2 \
    #	| cut -d '/' -f 5 | cut -c 1-13 | xargs | cut -d ' ' -f 2 )
    # // TODO: volume_diff.sh [t1] [t0]

    # // TODO: volume_ratio.sh [t1] [t0]
    LAST_TRADE_DAY="20231213" # // FIXME:
    ./compare_volume.sh $THIS_TIME $LAST_TRADE_DAY
    ./uno_vratio.sh     $THIS_TIME $LAST_TRADE_DAY
else
    echo "market yet open"
    exit 0
    # grep -rnp --color="auto" -e "6669" ./datafiles/taiex/after.market/????????.csv
    # wc -l  "$DIR0/$DATE.csv"
    # cp -v "$DIR0/$DATE.csv" ~/Dropbox/after.market.$DATE.csv
    # ./compare_volume.sh 20231129 20231128
    # N_DAYS=$( ls -lt datafiles/taiex/after.market/????????.csv \
    #	| wc -l | xargs | cut -d " " -f1 )
    echo "there are $N_DAYS trade days recorded."
    # ls -lt $DIR0/????????.csv | head -n 3

    # ./after_market.sh 20231201

    # ./uno_launch.sh datafiles/activity_watchlist.ods

    #read -p "save to ods, and let focus when ready ..."

    # ./uno_bquote.sh 20231201
fi

exit 0
