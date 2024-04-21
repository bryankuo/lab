#!/bin/bash

# ./bholding.sh [yyyymmdd]
#
# 1. scraping ratio from a list,
# 2. for each fetched html, scrapge ratio into csv.
# // TODO: zck chips.py insider_trade.py

if [ "$#" -lt 1 ]; then
    echo "usage: ./bholding.sh [yyyymmdd]"
    exit 22 # @see https://stackoverflow.com/a/50405954
fi

echo "scraping board holding ratio..."
TIMESTAMP0=`date '+%Y/%m/%d %H:%M:%S'`
index=1
count=0
DIR0="./datafiles/taiex/board.holding/$1"
OUTF1="$DIR0/bholding.csv"
trash -v $OUTF1
echo "ticker:ratio" > $OUTF1

# @see https://superuser.com/a/423086
effective=$(find $DIR0 -type f  \
    -iname '[0-9][0-9][0-9][0-9].html' \
    -size +7000c)
# -mtime -1
# find ./datafiles/taiex/board.holding/ -type f -iname '[0-9][0-9][0-9][0-9].html' -size +7000c

for f in $effective; do
    TICKER=${f:41:4}
    MSG=$(printf "%04d %04d %s" $index $TICKER $f)
    echo $MSG
    python3 get_bhr.py $TICKER $1
    count=$(($count+1))
    index=$(($index+1))
done

# notify user it's done
echo -ne '\007'

ls -lt $OUTF1

exit 0
