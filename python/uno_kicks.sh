#!/bin/bash

# idea 1: import module in LO (WIP)
# PYTHONPATH=$PYTHONPATH:/Library/Frameworks/Python.framework/Versions/3.9/lib/python3.9/site-packages
# PATH=$PATH:/Library/Frameworks/Python.framework/Versions/3.9/lib/python3.9/site-packages
# (WIP) make sure python3-uno installed ( in LO maybe? )
# /Library/Frameworks/Python.framework/Versions/3.9/bin/python3.9 -m pip install --upgrade pip
# python3 -m pip install uno

# idea 2: glue 2 scripts by bash
# make sure running uno.sh
# echo "$#"
if [ "$#" -lt 1 ]; then
    echo "./uno_kicks.sh [start] [len]"
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
TIMESTAMP=`date '+%Y/%m/%d %H:%M:%S'`
echo "time: "$TIMESTAMP " start "$START " len "$LEN " #line "$NLINES

while read p; do
    TICKER=$p
    # echo $index $START $LEN $TICKER
    if [[ $index -lt $START ]]
    then
	index=$(($index+1))
	continue
    fi
    # // TODO: handle newly added item when process is ongoing
    # @see https://stackoverflow.com/a/6022441
    # sed '443q;d' datafiles/watchlist.txt
    # sed '1072!d' datafiles/watchlist.txt
    # awk 'NR==1071' datafiles/watchlist.txt
    # TKR=( $(sed '1070q;d' datafiles/watchlist.txt) )
    # echo $TKR
    # exit 0

    OUTPUT=($(python3 quote.py $TICKER | tr -d '[],'))
    # echo ${OUTPUT[@]}
    DEAL=${OUTPUT[0]%\'}
    DEAL=${DEAL#\'}
    MSG=$(printf "%04d %04d %04.2f" $index $TICKER $DEAL )
    echo $MSG
    RETURN=( $(/Applications/LibreOffice.app/Contents/Resources/python \
	uno_kicks.py $TICKER $DEAL | tr -d '[],' ) )
    O_SPEC=${RETURN[0]%\'}
    O_SPEC=${O_SPEC#\'}
    # echo $OPUT # test return from calc
    if [ "$O_SPEC" == "1" ]; then
	echo -ne '\007'
    fi
    index=$(($index+1))
    count=$(($count+1))
    if [[ $count -ge $LEN ]]; then
	echo "finish $count items."
	break
    fi
    sleep 2
done < datafiles/watchlist.txt
TIMESTAMP=`date '+%Y/%m/%d %H:%M:%S'`
echo "time: " $TIMESTAMP " looping end"

exit 0
