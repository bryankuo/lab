#!/bin/bash

# @see uno_stalk_story.sh
# get_rs.sh with respect to the 1st

# ./check_bountylist.sh

DATE=`date '+%Y%m%d%H%M%S'`
OUTF0=datafiles/rs.$DATE.txt

LIST="datafiles/bountylist.txt"
index=1
count=0
NLINES=$(wc -l $LIST | xargs | cut -d " " -f1)
if [[ $# -gt 1 ]]; then
    START=$1
    LEN=$2
else
    START=$index
    LEN=$NLINES
fi
TIMESTAMP0=`date '+%Y/%m/%d %H:%M:%S'`
echo "time: "$TIMESTAMP0
echo "start "$START " len "$LEN " #line "$NLINES" list "$LIST

while true; do
    TICKER=( $(sed "$index""q;d" $LIST) )
    MSG=$(printf "%04d %04d" $index $TICKER)
    echo $MSG

    # https://stackoverflow.com/a/42251434
    found2=$(grep --color="auto" -c -e $TICKER datafiles/listed_2.txt)
    found4=$(grep --color="auto" -c -e $TICKER datafiles/listed_4.txt)
    if [ $found2 -eq 1 ]; then
	# ohlc_2.py
	python3 ohlc_2.py $TICKER $OUTF0 $index
    elif [ $found4 -eq 1 ]; then
	# ohlc_4.py
	python3 ohlc_4.py $TICKER $OUTF0 $index
    else
	echo $rt2 $rt4
    fi
    index=$(($index+1))
    count=$(($count+1))
    if [ $count -ge $NLINES ] ; then
	echo "finish $count items."
	break
    fi
    # sleep 1
    # In the following line -t for timeout, -N for just 1 character
    read -t 1 input
    if [[ $input = "q" ]] || [[ $input = "Q" ]]; then
	# The following line is for the prompt to appear on a new line.
        echo
        break
    fi
    sleep 1
done
TIMESTAMP1=`date '+%Y/%m/%d %H:%M:%S'`
echo "time: " $TIMESTAMP0 " looping start"
echo "time: " $TIMESTAMP1 " looping end"
echo -ne '\007'
python3 launch.py $OUTF0

exit 0
