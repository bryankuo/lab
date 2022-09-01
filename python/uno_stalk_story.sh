#!/bin/bash

# @see uno_stalk.sh

./check_bountylist.sh

STORY="AMD"
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
echo "time: "$TIMESTAMP0
echo "start "$START " len "$LEN " #line "$NLINES" list "$LIST

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
    MSG=$(printf "%04d %04d %04.2f" $index $TICKER $O_SPEC)
    echo $MSG
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
exit 0
