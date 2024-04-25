#!/bin/bash

# ./ndays_2new_high.sh [ticker]
#
# count # of (trade) days to get new high (low)
#
# \param in ticker
# \param in $DIR2/????????.all.columns.csv, on daily bases

if [ "$#" -lt 1 ]; then
    echo "usage: ./ndays_2new_high.sh [ticker]"
    exit 22
fi
TKR=$1

DIR0="."
DIR2="$DIR0/datafiles/taiex/after.market"
DIR1="$DIR0/uno/unload"
DIR3="$DIR0/datafiles"
DIR4="/Applications/LibreOffice.app/Contents/Resources"

N_DAYS=$( ls -lt $DIR2/????????.all.columns.csv \
    | wc -l | xargs | cut -d " " -f1 )
# echo $N_DAYS

# output:
# yyyymmdd:aaa.bb
HI_BY_DATE_ASC=$( grep -r --color="auto" -e "^$TKR" \
    $DIR2/????????.all.columns.csv | cut -d ':' -f 1,10 \
    | cut -c 32-39,56- )

# LO_BY_DATE_DSC=$( grep -r --color="auto" -e "^$TKR" \
#     $DIR2/????????.all.columns.csv | cut -d ':' -f 1,11 \
#    | cut -c 32-39,56- | sort -r )

echo $HI_BY_DATE_ASC | tr " " "\n" | while read -r line; do
    # echo "$line"
    TDAY=$( echo $line | cut -d ":" -f 1 )
    DAY_HI=$( echo $line | cut -d ":" -f 2 )
    echo $TDAY $DAY_HI
done

exit 0
# // TODO: get 1st high , 2nd high, slope
