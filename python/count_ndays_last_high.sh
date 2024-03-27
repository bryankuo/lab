#!/bin/bash

# ./count_ndays_last_high.sh [ticker]
#
# count # of (trade) days to get new high
#
# \param in ticker
# \param in $DIR2/????????.all.columns.csv, on daily bases

if [ "$#" -lt 1 ]; then
    echo "usage: ./count_ndays_last_high.sh [ticker]"
    exit 22 # @see https://stackoverflow.com/a/50405954
fi
TKR=$1

# DIR0="$HOME/github/python"
DIR0="."
DIR2="$DIR0/datafiles/taiex/after.market"
DIR1="$DIR0/uno/unload"
DIR3="$DIR0/datafiles"
DIR4="/Applications/LibreOffice.app/Contents/Resources"

# ls -lt $DIR2/????????.all.columns.csv

# N_DAYS=$( ls -lt $DIR2/????????.all.columns.csv \
#    | wc -l | xargs | cut -d " " -f1 )

# grep -r --color="auto" -e "^1101" $DIR2/????????.all.columns.csv \
#    | cut -d '/' -f 9 | sort -k 1 -r | cut -d ":" -f 1,10 \
#    | sed 's/.all.columns.csv//g'

# \
#    | sed 's/.all.columns.csv//g'

HIGHS=$( grep -r --color="auto" -e "^$TKR" $DIR2/????????.all.columns.csv \
    | cut -d '/' -f 9 | sort -k 1 -r | cut -d ":" -f 1,10 \
    | sed 's/.all.columns.csv//g' )

# // TODO: get 1st high , 2nd high, slope
echo $HIGHS | tr " " "\n" | while read -r line; do
    # echo "$line"
    TDAY=$( echo $line | cut -d ":" -f 1 )
    DAY_HI=$( echo $line | cut -d ":" -f 2 )
    echo $TDAY $DAY_HI
done

./uno_launch.sh "$DIR3/activity_watchlist.ods"

# // TODO:
d1=$( ls -lt $DIR2/????????.all.columns.csv | head -n 2 \
    | cut -d '/' -f 5 | cut -c 1-8 | xargs | cut -d ' ' -f 1 )

d0=$( ls -lt $DIR2/????????.all.columns.csv | head -n 2 \
    | cut -d '/' -f 5 | cut -c 1-8 | xargs | cut -d ' ' -f 2 )

python3 $DIR1/slice_last_high.py $d1 $d0

$DIR4/python "$HOME/github/python/uno/load/addsheet.py" $DATE

exit 0
