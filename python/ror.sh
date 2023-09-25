#!/bin/bash

# ./ror.sh
# scraping ror and generate rs into csv for calc.
# return

# echo "$#"
index=1
count=0
BOUNTY="datafiles/bountylist.txt"
NLINES=$(wc -l $BOUNTY | xargs | cut -d " " -f1)
START=$index
LEN=$NLINES
TIMESTAMP0=`date '+%Y/%m/%d %H:%M:%S'`
echo "start "$START" len "$NLINES

echo "clean up data files..."
rm -f ror.*.html ror.*.csv

echo "done, get twse ror..."
# generate csv header and twse ror
BENCHMARK=($(python3 get_twse_ror.py | tr -d '[],'))

echo "done, looping fetch file..."
# echo ${BENCHMARK[@]}
while true; do
    TICKER=( $(sed "$index""q;d" $BOUNTY) )
    python3 fetch_ticker_ror.py $TICKER 0
    index=$(($index+1))
    count=$(($count+1))
    if [[ $count -ge $LEN ]]; then
	echo "finish $count items."
	break
    fi
    sleep 1
done
TIMESTAMP=`date '+%Y/%m/%d %H:%M:%S'`
echo "time: " $TIMESTAMP0 " looping start"
echo "time: " $TIMESTAMP  " looping end"


# DIR0="./datafiles/taiex"
DIR0="."
mkdir -p $DIR0
# // FIXME: date may be not today, but input parameter to get_ticker_ror.py
DATE=`date '+%Y%m%d'`
OUTF0="$DIR0/rs.$DATE.csv"
OUTF1="$DIR0/rs.$DATE.ods"

echo "done, figure out ror for each ticker..."
index=1
count=0
TIMESTAMP0=`date '+%Y/%m/%d %H:%M:%S'`
# // generate the rs against twse, append csv
echo "ticker:name:1d:1w:1m:2m:3m:6m:1y:ytd:3y" > $OUTF0
while true; do
    TICKER=( $(sed "$index""q;d" $BOUNTY) )
    python3 get_ticker_ror.py $TICKER 0
    index=$(($index+1))
    count=$(($count+1))
    if [[ $count -ge $LEN ]]; then
	echo "finish $count items."
	break
    fi
done
TIMESTAMP=`date '+%Y/%m/%d %H:%M:%S'`
echo "time: " $TIMESTAMP0 " looping start"
echo "time: " $TIMESTAMP  " looping end"

# notify user it's done
echo -ne '\007'
ls -ltr ror.*.html ror.*.csv rs.*.csv
echo "done."

# read -p "Press enter to continue $OUTF0 ..."
python3 launch.py $OUTF0
# manual process here...
while true ; do
    if [ ! -f "$OUTF1" ]; then
        read -p "Save $OUTF0  to ods when ready ..."
    else
	break
    fi
done

exit 0
