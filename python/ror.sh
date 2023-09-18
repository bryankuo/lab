#!/bin/bash

# echo "$#"
index=1
count=0
BOUNTY="datafiles/bountylist.txt"
NLINES=$(wc -l $BOUNTY | xargs | cut -d " " -f1)
START=$index
LEN=$NLINES
TIMESTAMP0=`date '+%Y/%m/%d %H:%M:%S'`
echo "start "$START" len "$NLINES
RETURN=($(python3 get_twse_ror.py | tr -d '[],'))
while true; do
    TICKER=( $(sed "$index""q;d" $BOUNTY) )
    # echo $TICKER
    python3 get_ticker_ror.py $TICKER 0
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
echo -ne '\007'
exit 0
