#!/bin/bash

# ./ror.sh [fetching|figuring] [yyyymmdd]
# 1. scraping market value from ror.sh download files
#
# \param in 0: net, 1:file
# \param in bountylist.txt
# \param out OUTF0 ror.YYYYMMDD.csv
# \param out  rs.YYYYMMDD.csv
# return

if [ "$#" -lt 1 ]; then
    echo "usage: ./scrap_market_value.sh [yyyymmdd]"
    echo "       and let safari allow Remote Automation"
    exit 22 # @see https://stackoverflow.com/a/50405954
fi

DIR0="datafiles/taiex/rs"
mkdir -p $DIR0
DATE=$1
DIR1="$DIR0/$DATE" # to archive *.html
mkdir -p $DIR1

OUTF0="$DIR0/market_value.$DATE.csv"
echo "scrap market value ..."
TIMESTAMP0=`date '+%Y/%m/%d %H:%M:%S'`
index=1
count=0
echo "ticker:name:market_value" > $OUTF0
# @see https://superuser.com/a/423086
effective=$(find $DIR1 -type f -iname 'ror.[0-9][0-9][0-9][0-9].html' -mtime -2 -size +20000c)
for f in $effective; do
    TICKER=${f:32:4}
    MSG=$(printf "%04d %04d %s" $index $TICKER $f)
    echo $MSG
    # python3 get_ticker_ror.py $TICKER ${BENCHMARK[@]}
    count=$(($count+1))
    index=$(($index+1))
done
TIMESTAMP=`date '+%Y/%m/%d %H:%M:%S'`
echo "time: " $TIMESTAMP0 " looping start"
echo "time: " $TIMESTAMP  " looping end"

# notify user it's done
echo -ne '\007'
echo $count"     scraped. "
tput bel
exit 0

# // TODO: launch activity ods
read -p "Press enter to continue $OUTF0 ..."
./uno_launch.sh $OUTF0
tput bel

# manual process here...
while true ; do
    if [ ! -f "$OUTF2" ]; then
	read -p "Save $OUTF0 to ods when ready ..."
    else
	break
    fi
done

# // load into calc

# ./uno_launch.sh $OUTF2
# assume ready and focused, uno_rs.sh adding formula
# ./uno_rs.sh $DATE # abandon ./uno_rs.sh
# // FIXME:     r_ytd = soup.findAll('table')[0] \
# IndexError: list index out of range
TIMESTAMP0=`date '+%Y/%m/%d %H:%M:%S'`
# /Applications/LibreOffice.app/Contents/Resources/python \
#     uno_load_market_value.py $DATE
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
