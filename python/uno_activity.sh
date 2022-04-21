#!/bin/bash

# make sure running uno.sh
# echo "$#"
if [ "$#" -lt 1 ]; then
    echo "./uno_activity.sh [start] [len]"
    exit 64 # @see https://stackoverflow.com/a/1535733
fi

cp datafiles/activity_watchlist.ods datafiles/activity_watchlist.0.ods
index=1 # calc start index, while txt/calc not sync
count=0
NLINES=( $(wc -l datafiles/watchlist.txt | cut -d " " -f5) )
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
    if [[ $index -lt $START ]]
    then
	index=$(($index+1))
	continue
    fi
    # @see https://stackoverflow.com/a/6022441
    # awk 'NR==1071' datafiles/watchlist.txt
    TICKER=( $(sed "$index""q;d" datafiles/watchlist.txt) )
    # echo $TICKER
    # : <<'END'
    OUTPUT=($(python3 basic.py $TICKER | tr -d '[],'))
    CO_TYPE=${OUTPUT[2]%\'}
    CO_TYPE=${CO_TYPE#\'}
    CO_NAME=${OUTPUT[1]%\'}
    CO_NAME=${CO_NAME#\'}
    if [ "$CO_TYPE" == "2" ] || [ "$CO_TYPE" == "4" ]; then
	ACTIVITY=($(python3 activity.py $TICKER 1 | tr -d '[],'))
	QDI=${ACTIVITY[0]%\'}
	QDI=${QDI#\'}
	FUND=${ACTIVITY[1]%\'}
	FUND=${FUND#\'}
	RETAIL=${ACTIVITY[2]%\'}
	RETAIL=${RETAIL#\'}
	TOTAL=${ACTIVITY[3]%\'}
	TOTAL=${TOTAL#\'}
	printf "ticker: %04d %s %d\n" $TICKER $CO_NAME $CO_TYPE
	printf "activity: %d %d %d %d\n\n" $QDI $FUND $RETAIL $TOTAL
	RETURN=( $(/Applications/LibreOffice.app/Contents/Resources/python \
	    uno_activity.py $TICKER   \
	    $QDI $FUND $RETAIL $TOTAL \
	    | tr -d '[],' ) )
    else
	continue
    fi
    # END
    index=$(($index+1))
    count=$(($count+1))
    if [ $count -ge $LEN ] || [ $index -gt $NLINES ] ; then
	echo "finish $count items."
	break
    fi
    sleep 5
done
TIMESTAMP1=`date '+%Y/%m/%d %H:%M:%S'`
echo "time: " $TIMESTAMP0 " looping start"
echo "time: " $TIMESTAMP1 " looping end"

exit 0
