#!/bin/bash

# @see uno_stalk_story.sh
if [ "$#" -lt 1 ]; then
    echo "./uno_status_loop.sh 0 for bounty list"
    exit 64 # @see https://stackoverflow.com/a/1535733
fi

cp datafiles/activity_watchlist.ods datafiles/activity_watchlist.0.ods
index=1 # calc start index, while txt/calc not sync
count=0
LIST="datafiles/watchlist.txt"
BOUNTY="datafiles/bountylist.txt"
NLINES=$(wc -l $LIST | xargs | cut -d " " -f1)
if [[ $# -gt 1 ]]; then
    START=$1
    LEN=$2
    index=$1
else
    if [[ $1 -eq 0 ]]; then
	LIST=$BOUNTY
	NLINES=$(wc -l $LIST | xargs | cut -d " " -f1)
	LEN=$NLINES
    else
	START=$index
	LEN=$NLINES
    fi
fi
TIMESTAMP0=`date '+%Y/%m/%d %H:%M:%S'`
echo "time: "$TIMESTAMP0
echo "start "$START " len "$LEN " #line "$NLINES" list "$LIST

while true; do
    TICKER=( $(sed "$index""q;d" $LIST) )
    MSG=$(printf "%04d %04d" $index $TICKER)
    echo $MSG
    ./uno_status.sh $TICKER
    index=$(($index+1))
    count=$(($count+1))
    if [ $count -ge $LEN ] || [ $index -gt $NLINES ] ; then
	# // TODO: enhance to allow adding items during processing
	echo "finish $count items."
	say -v "Mei-Jia" "完成 $count 個項目"
	break
    fi
    # In the following line -t for timeout, -N for just 1 character
    read -t 1 input
    if [[ $input = "q" ]] || [[ $input = "Q" ]]; then
	# The following line is for the prompt to appear on a new line.
	echo "abort, finish $count items."
	say -v "Mei-Jia" "完成了 $count 個項目"
        break
    fi
done

TIMESTAMP1=`date '+%Y/%m/%d %H:%M:%S'`
echo "time: " $TIMESTAMP0 " looping start"
echo "time: " $TIMESTAMP1 " looping end"
echo -ne '\007'

exit 0
