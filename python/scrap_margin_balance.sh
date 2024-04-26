#!/bin/bash

# ./scrap_margin_balance.sh [yyyymmdd]
# 1. scraping from fetch_margin_balance.py download files
#
# \param in  yyyymmdd download folder
# \param out datafile/taiex/margin_balance/[yyyymmdd].csv
# return

if [ "$#" -lt 1 ]; then
    echo "usage: ./scrap_margin_balance.sh [yyyymmdd]"
    exit 22 # @see https://stackoverflow.com/a/50405954
fi

DATE=$1
DIR0="datafiles/taiex/margin_balance"
mkdir -p $DIR0
DIR1="$DIR0/$DATE" # fetched *.html
mkdir -p $DIR1

OUTF0="$DIR0/$DATE.0.csv" # unsorted
echo "ticker:margin_balance(lot)" > $OUTF0

echo "scrap margin balance ..."
TIMESTAMP0=`date '+%Y/%m/%d %H:%M:%S'`
index=1
count=0

# @see https://superuser.com/a/423086
effective=$(find $DIR1 -type f -iname '[0-9][0-9][0-9][0-9].html' \
    -size +15000c) # -mtime -1

for f in $effective; do
    TICKER=${f:40:4}
    MSG=$(printf "%04d %04d %s" $index $TICKER $f)
    echo -n $MSG
    python3 get_ticker_margin_balance.py $TICKER $DATE
    count=$(($count+1))
    index=$(($index+1))
done
TIMESTAMP=`date '+%Y/%m/%d %H:%M:%S'`
echo "time: " $TIMESTAMP0 " looping start"
echo "time: " $TIMESTAMP  " looping end"
/usr/bin/sort -k1 -n -t: -o "$DIR0/$DATE.csv" $OUTF0
echo $count"     scraped. $DIR0/$DATE.csv"

trash $OUTF0
# echo -ne '\007'
tput bel
exit 0 # to compare on daily bases
# margin_balance$ find . -type f -iname '????????.csv' | xargs grep -rnp --color="auto" -e "113/02"

read -p "Press enter to loading calc ..." # let calc regain focus as well
TIMESTAMP0=`date '+%Y/%m/%d %H:%M:%S'`
# /Applications/LibreOffice.app/Contents/Resources/python \
#    uno_load_margin_balance.py $DATE
TIMESTAMP=`date '+%Y/%m/%d %H:%M:%S'`
echo "time: " $TIMESTAMP0 " looping start"
echo "time: " $TIMESTAMP  " looping end"
tput bel

exit 0
