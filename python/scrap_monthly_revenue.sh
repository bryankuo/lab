#!/bin/bash

# ./scrap_monthly_revenue.sh [yyyymmdd]
# 1. scraping from fetch_monthly_revenue.py download files
#
# \param in  yyyymmdd download folder
# \param out datafile/taiex/monthly_revenue/[yyyymmdd].csv
# return

if [ "$#" -lt 1 ]; then
    echo "usage: ./scrap_monthly_revenue.sh [yyyymmdd]"
    exit 22 # @see https://stackoverflow.com/a/50405954
fi

DATE=$1
DIR0="datafiles/taiex/monthly_revenue"
mkdir -p $DIR0
DIR1="$DIR0/$DATE" # fetched *.html
mkdir -p $DIR1

OUTF0="$DIR0/$DATE.0.csv" # unsorted
echo "scrap monthly revenue ..."
TIMESTAMP0=`date '+%Y/%m/%d %H:%M:%S'`
index=1
count=0
echo "ticker:name:year_month:mom%:yoy%:monthly_revenue(K)" > $OUTF0
# @see https://superuser.com/a/423086
effective=$(find $DIR1 -type f -iname '[0-9][0-9][0-9][0-9].html' -mtime -1 -size +10000c)
for f in $effective; do
    TICKER=${f:41:4}
    MSG=$(printf "%04d %04d %s" $index $TICKER $f)
    echo $MSG
    python3 get_ticker_monthly_revenue.py $TICKER $DATE
    count=$(($count+1))
    index=$(($index+1))
done
TIMESTAMP=`date '+%Y/%m/%d %H:%M:%S'`
echo "time: " $TIMESTAMP0 " looping start"
echo "time: " $TIMESTAMP  " looping end"
/usr/bin/sort -k1 -n -t: -o "$DIR0/$DATE.csv" $OUTF0
trash $OUTF0
echo $count"     scraped. $DIR0/$DATE.csv"
# echo -ne '\007'
tput bel
exit 0 # to compare on daily bases
# monthly_revenue$ find . -type f -iname '????????.csv' | xargs grep -rnp --color="auto" -e "113/02"
# cd datafiles/taiex/monthly_revenue
# find . -type f -iname '????????.csv' | xargs grep -rnp --color="auto" -e "113/03" | wc -l | xargs
# exclude "-" minus
# find . -type f -iname '????????.csv' | xargs grep -rnp --color="auto" -e "113/02" | grep -v "-"
# find . -type f -iname '????????.csv' | xargs grep -rnp --color="auto" -e "113/02" | grep -v "$DATE"
#
# find . -type f -iname '20240309.csv' | xargs grep -rnp --color="auto" -e "113/02"  | grep -v "-" | wc -l
# find . -type f -iname '20240?????.csv' | xargs grep -rnp --color="auto" -e "113/02" | cut -d ":" -f 1 | uniq | sort -r
# find . -type f -iname '20240???.csv' | xargs grep -rnp --color="auto" -e "113/02" | grep -rnp --color="auto" -e "1236"
# find . -type f -iname '202403??.csv' | xargs grep -rnp --color="auto" -e "^1236" | sort -r


read -p "Press enter to loading calc ..." # let calc regain focus as well
TIMESTAMP0=`date '+%Y/%m/%d %H:%M:%S'`
# /Applications/LibreOffice.app/Contents/Resources/python \
#    uno_load_monthly_revenue.py $DATE
TIMESTAMP=`date '+%Y/%m/%d %H:%M:%S'`
echo "time: " $TIMESTAMP0 " looping start"
echo "time: " $TIMESTAMP  " looping end"
tput bel

# // TODO: housekeeping

exit 0
