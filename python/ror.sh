#!/bin/bash

# ./ror.sh [net|file]
# scraping ror and generate rs into csv for calc.
# \param in 0: net, 1:file
# \param in bountylist.txt
# \param out OUTF0 ror.YYYYMMDD.csv
# \param out  rs.YYYYMMDD.csv
# return
:'
if [ "$#" -lt 1 ]; then
    echo "usage: ./ror.sh [net|file]"
    echo "       and let safari allow Remote Automation"
    exit 22 # @see https://stackoverflow.com/a/50405954
fi
'

clear

# echo "$#"
index=1
count=0
# incase repeated: uniq -i datafiles/bountylist.txt
BOUNTY="datafiles/bountylist.txt"
NLINES=$(wc -l $BOUNTY | xargs | cut -d " " -f1)
START=$index
LEN=$NLINES
TIMESTAMP0=`date '+%Y/%m/%d %H:%M:%S'`
echo "start "$START" len "$NLINES

echo "clean up data files..."
DIR0="datafiles/taiex/rs"
# DIR0="."
mkdir -p $DIR0
# // FIXME: date may be not today, but input parameter to get_ticker_ror.py
DATE=`date '+%Y%m%d'`
OUTF0="$DIR0/ror.$DATE.csv"
OUTF1="$DIR0/rs.$DATE.csv"
OUTF2="$DIR0/rs.$DATE.ods"
trash -v $OUTF0 $OUTF1 $OUTF2

BENCHMARK=""
if [ ! -f "$OUTF0" ]; then
    trash -v ror.????.html ror.????????.html
    echo "done, get twse ror..."
    echo "ticker:name:1d:1w:1m:2m:3m:6m:1y:ytd:3y" > $OUTF0
    # generate csv header and twse ror
    BENCHMARK=($(python3 get_twse_ror.py | tr -d '[],'))

    echo "done, looping fetch ticker file..."
    echo ${BENCHMARK[@]}
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

    echo "done, figure out ror for each ticker..."
fi

index=1
count=0
TIMESTAMP0=`date '+%Y/%m/%d %H:%M:%S'`

# // generate the rs against twse, append csv
echo "ticker:name:1d:1w:1m:2m:3m:6m:1y:ytd:3y" > $OUTF1
while true; do
    TICKER=( $(sed "$index""q;d" $BOUNTY) )
    # echo ${BENCHMARK[@]}
    python3 get_ticker_ror.py $TICKER ${BENCHMARK[@]}
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
ls -lt "$DIR0/"rs.*.csv "$DIR0/"ror.*.csv "$DIR0/"ror.????????.html
ls -l "$DIR0/"ror.????.html | wc -l

read -p "Press enter to continue $OUTF1 ..."
# open via subprocess, can not modify from outside python
python3 launch.py $OUTF1

# manual process here...
while true ; do
    if [ ! -f "$OUTF2" ]; then
        read -p "Save $OUTF1 to ods when ready ..."
    else
	break
    fi
done

./uno_launch.sh $OUTF2
# so as to let uno_rs.sh adding formula

# echo "done extracting rs, ready to rank in 10 seconds..."
# sleep 10
# ./uno_rs.sh $OUTF2
# // FIXME: launch in the same script

echo "done, file name is "$OUTF2
exit 0
