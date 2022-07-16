#!/bin/bash

LIST="datafiles/bountylist.txt"
index=1 # calc start index, while txt/calc not sync
count=0
n_add=0
NLINES=$(wc -l $LIST | xargs | cut -d " " -f1)
echo $NLINES
if [[ $# -gt 1 ]]; then
    START=$1
    LEN=$2
else
    START=$index
    LEN=$NLINES
fi
TIMESTAMP0=`date '+%Y/%m/%d %H:%M:%S'`
echo "time: "$TIMESTAMP0 " check bounty list " $LIST " #line " $NLINES

while true; do
    # // TODO: uno_activity.sh
    # @see https://stackoverflow.com/a/6022441
    # awk 'NR==1071' datafiles/watchlist.txt
    TICKER=( $(sed "$index""q;d" $LIST) )
    echo $TICKER
    num_line=$( grep -rnp --color="auto" datafiles/listed_[245].txt \
	datafiles/watchlist.txt -e "$TICKER" | wc -l )
    echo $num_line
    if [[ $num_line -eq 1 ]]; then
	echo $TICKER >> datafiles/watchlist.txt
	echo "add $TICKER to watchlist"
	n_add=$(($n_add+1))
    fi

    index=$(($index+1))
    count=$(($count+1))
    if [ $count -ge $NLINES ] ; then
	echo "finish $count items, add $n_add to watch list."
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
    # sleep 1
done
TIMESTAMP=`date '+%Y/%m/%d %H:%M:%S'`
echo "time: " $TIMESTAMP " looping end"
exit 0
