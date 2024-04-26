#!/bin/bash

# ./scrap_market_value.sh [yyyymmdd]
# scraping market value from ror.sh, load into calc
#
# \param in yyyymmdd, processing date
# \param out OUTF0 $DIR00/market_value.$DATE.csv
# \param out  rs.YYYYMMDD.csv
# return

if [ "$#" -lt 1 ]; then
    echo "usage: ./scrap_market_value.sh [yyyymmdd]"
    echo "       and let safari allow Remote Automation"
    exit 22 # @see https://stackoverflow.com/a/50405954
fi

DIR00="datafiles/taiex"
DIR0="datafiles/taiex/rs"
mkdir -p $DIR0
DATE=$1
DIR1="$DIR0/$DATE" # to archive *.html
mkdir -p $DIR1

OUTF0="$DIR00/market_value.$DATE.csv"
echo "scrap market value ..."
TIMESTAMP0=`date '+%Y/%m/%d %H:%M:%S'`
index=1
count=0
echo "ticker:name:market_value(M)" > $OUTF0
# @see https://superuser.com/a/423086
# -mtime -1
effective=$(find $DIR1 -type f -iname 'ror.[0-9][0-9][0-9][0-9].html' -size +20000c)
for f in $effective; do
    TICKER=${f:32:4}
    MSG=$(printf "%04d %04d %s" $index $TICKER $f)
    echo -n "$MSG "
    python3 get_ticker_market_value.py $TICKER $DATE
    count=$(($count+1))
    index=$(($index+1))
done
TIMESTAMP=`date '+%Y/%m/%d %H:%M:%S'`
echo "time: " $TIMESTAMP0 " looping start"
echo "time: " $TIMESTAMP  " looping end"

# notify user it's done
# echo -ne '\007'
echo $count"     scraped. "
# tput bel

./uno_launch.sh "./datafiles/activity_watchlist.ods"
tput bel
read -p "Press enter to loading calc ..." # let calc regain focus as well
TIMESTAMP0=`date '+%Y/%m/%d %H:%M:%S'`
/Applications/LibreOffice.app/Contents/Resources/python \
    uno_load_market_value.py $DATE
TIMESTAMP=`date '+%Y/%m/%d %H:%M:%S'`
echo "time: " $TIMESTAMP0 " looping start"
echo "time: " $TIMESTAMP  " looping end"
tput bel


# // TODO: housekeeping
# if moving old files, create yyyymmdd folder then move it
# stat -f %Sm -t %Y%m%d ./datafiles/taiex/rs/rs.*.csv | sort | tail -n 1
# FETCH_DATE=$(stat -f %Sm -t %Y%m%d ./datafiles/taiex/rs/rs.*.csv | sort | tail -n 1)
# mkdir -p datafiles/taiex/rs/20231105
# mkdir -p datafiles/taiex/rs/$FETCH_DATE
# mv ./datafiles/taiex/rs/ror.????.html ./datafiles/taiex/rs/$FETCH_DATE/
#
# python$ ./uno_launch.sh datafiles/taiex/rs/rs.20231112.ods
# python$ ./uno_rs.sh 20231112
# find . -type d -iname '*20231201*' -o -type f -iname '*20231201*'  -delete
# trash -v ./20231201

exit 0
