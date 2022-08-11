#!/bin/bash

# @see uno_stalk_story.sh

LIST="datafiles/watchlist.txt"
index=1 # calc start index, since txt/calc not sync
count=0
NLINES=$(wc -l $LIST | xargs | cut -d " " -f1)
# echo $NLINES
if [[ $# -gt 1 ]]; then
    START=$1
    LEN=$2
else
    START=$index
    LEN=$NLINES
fi
TIMESTAMP0=`date '+%Y/%m/%d %H:%M:%S'`
echo "start "$START " len "$LEN " #line "$NLINES

while true; do
    TICKER=( $(sed "$index""q;d" $LIST) )
    ./uno_status.sh $TICKER
    MSG=$(printf "%04d %04d" $index $TICKER)
    echo $MSG
    index=$(($index+1))
    count=$(($count+1))
    if [ $count -ge $NLINES ] ; then
	echo "finish $count items."
	break
    fi
    # In the following line -t for timeout, -N for just 1 character
    read -t 1 input
    if [[ $input = "q" ]] || [[ $input = "Q" ]]; then
	# The following line is for the prompt to appear on a new line.
	echo "abort, finish $count items."
        break
    fi
done

TIMESTAMP1=`date '+%Y/%m/%d %H:%M:%S'`
echo "time: " $TIMESTAMP0 " looping start"
echo "time: " $TIMESTAMP1 " looping end"
echo -ne '\007'

exit 0
