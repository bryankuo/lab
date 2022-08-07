#!/bin/bash

# @see uno_stalk.sh

./check_bountylist.sh

STORY="遊戲"
LIST="datafiles/bountylist.txt"
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
echo "time: "$TIMESTAMP0 " stalk " $LIST " #line " $NLINES

while true; do
    # // TODO: uno_activity.sh
    # @see https://stackoverflow.com/a/6022441
    # awk 'NR==1071' datafiles/watchlist.txt
    TICKER=( $(sed "$index""q;d" $LIST) )

    RETURN=( $(/Applications/LibreOffice.app/Contents/Resources/python \
	uno_story.py $TICKER $STORY | \
	tr -d '[],' ) )
    O_SPEC=${RETURN[0]%\'}
    O_SPEC=${O_SPEC#\'}
    echo $index $TICKER $O_SPEC # return from calc

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
    sleep 3
done
TIMESTAMP=`date '+%Y/%m/%d %H:%M:%S'`
echo "time: " $TIMESTAMP " looping end"
echo -ne '\007'
exit 0
