#!/bin/bash

# ./ror.sh [net|file]
# scraping ror from a list, and generate rs into csv for calc.
# \param in 0: net, 1:file
# \param in bountylist.txt
# \param out OUTF0 ror.YYYYMMDD.csv
# \param out  rs.YYYYMMDD.csv
# return

clear

# echo "$#"
# incase repeated: uniq -i datafiles/bountylist.txt
# BOUNTY="datafiles/bountylist.txt"
# BOUNTY="datafiles/taiex.watchlist.txt" # // FIXME: symbolic link
BOUNTY="datafiles/watchlist.20231023.txt"
NLINES=$(wc -l $BOUNTY | xargs | cut -d " " -f1)
START=$index
LEN=$NLINES
echo "start "$START" len "$NLINES

DIR0="datafiles/taiex/rs"
mkdir -p $DIR0
# // FIXME: date may be not today, but input parameter to get_ticker_ror.py
DATE=`date '+%Y%m%d'`
OUTF0="$DIR0/ror.$DATE.csv"
OUTF1="$DIR0/rs.$DATE.csv"
OUTF2="$DIR0/rs.$DATE.ods"
TSE_ROR="$DIR0/ror.twse.html"
echo "clean up data files..."
trash -v $OUTF0 $OUTF1 $OUTF2 # $TSE_ROR

echo "fetch ticker files..."
TIMESTAMP0=`date '+%Y/%m/%d %H:%M:%S'`
# index=1
# n_fetched=0
# // TODO: connection pooling instead of frequent access
# if [ ! -f "$OUTF0" ]; then
trash -v ror.????.html ror.????????.html
# @see https://stackoverflow.com/a/34491383
# if you have to do just a few requests,
# Otherwise you'll want to manage sessions yourself.
# here comes connection pooling
TICKER=1101
python3 fetch_ticker_ror.py $TICKER 0
TIMESTAMP=`date '+%Y/%m/%d %H:%M:%S'`
echo "time: " $TIMESTAMP0 " looping start"
echo "time: " $TIMESTAMP  " looping end"
#fi
exit 0

BENCHMARK=""
if [ ! -f "$TSE_ROR" ]; then
    echo "get twse ror..."
    echo "ticker:name:1d:1w:1m:2m:3m:6m:1y:ytd:3y" > $OUTF0
    # generate csv header and twse ror
    BENCHMARK=($(python3 get_twse_ror.py | tr -d '[],'))
else
    # // TODO: by reading from OUTF0
    BENCHMARK=""
fi
echo "twse: " ${BENCHMARK[@]}

# // TODO:
# if moving old files, create yyyymmdd folder then move it
# stat -f %Sm -t %Y%m%d ./datafiles/taiex/rs/rs.*.csv | sort | tail -n 1
# mkdir -p "$DIR0/[last yyyymmdd]"


echo "generate the rs against twse..."
index=1
count=0
TIMESTAMP0=`date '+%Y/%m/%d %H:%M:%S'`
echo "ticker:name:1d:1w:1m:2m:3m:6m:1y:ytd:3y" > $OUTF1
if [ -z "${BENCHMARK[@]}" ]; then
    echo "TBD" ${BENCHMARK[@]}
else
    # // TODO: for f in *; do echo "File -> $f" done
    # @see https://superuser.com/a/423086
    while true; do
	TICKER=( $(sed "$index""q;d" $BOUNTY) )
	# echo ${BENCHMARK[@]}
	# check if file has been fetched
	TICKER_FILE="$DIR0/ror.$TICKER.html"
	if [ -f "$TICKER_FILE" ]; then
	    python3 get_ticker_ror.py $TICKER ${BENCHMARK[@]}
	    count=$(($count+1))
	    MSG=$(printf "g %04d %04d" $index $TICKER)
	    echo $MSG
	    if [[ $count -ge $LEN ]]; then
		echo "finish $count items."
		break
	    fi
	fi
	index=$(($index+1))
    done

    TIMESTAMP=`date '+%Y/%m/%d %H:%M:%S'`
    echo "time: " $TIMESTAMP0 " looping start"
    echo "time: " $TIMESTAMP  " looping end"
fi

# notify user it's done
echo -ne '\007'
ls -lt "$DIR0/"rs.*.csv "$DIR0/"ror.*.csv "$DIR0/"ror.????????.html
ls -lt "$DIR0/"ror.????.html "$DIR0/"rs.*.ods | wc -l
echo $n_fetched" fetched."
echo $count"     parsed. "

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
# // FIXME:     r_ytd = soup.findAll('table')[0] \
# IndexError: list index out of range
#
# find ./datafiles/ -type f -iname 'ror.*.html' -mtime -1 -print | wc -l
# // TODO: seperate fetch and get
echo "done, file name is "$OUTF2
exit 0
