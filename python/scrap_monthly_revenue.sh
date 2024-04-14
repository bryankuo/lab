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
echo "ticker:name:year_month:mom%:yoy%:monthly_revenue(K)" > $OUTF0

OUTF1="$DIR0/$DATE.mom.c3i.0.csv"
echo "ticker:name:mom0%:mom1%:mom2%" > $OUTF1

OUTF2="$DIR0/$DATE.yoy.c3i.0.csv"
echo "ticker:name:yoy0%:yoy1%:yoy2%" > $OUTF2

echo "scrap monthly revenue ..."
TIMESTAMP0=`date '+%Y/%m/%d %H:%M:%S'`
index=1
count=0

# @see https://superuser.com/a/423086
effective=$(find $DIR1 -type f -iname '[0-9][0-9][0-9][0-9].html' \
    -size +10000c) # -mtime -1

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
/usr/bin/sort -k1 -n -t: -o "$DIR0/$DATE.mom.c3i.csv" $OUTF1
/usr/bin/sort -k1 -n -t: -o "$DIR0/$DATE.yoy.c3i.csv" $OUTF2
echo $count"     scraped. $DIR0/$DATE.csv"
N_MC3I=$(($(wc -l "$DIR0/$DATE.mom.c3i.csv" | xargs | cut -d ' ' -f 1)-1))
N_YC3I=$(($(wc -l "$DIR0/$DATE.yoy.c3i.csv" | xargs | cut -d ' ' -f 1)-1))
echo "# mom c3i: $N_MC3I"
echo "# yoy c3i: $N_YC3I"

trash $OUTF0 $OUTF1 $OUTF2
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
