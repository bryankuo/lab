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
    echo "./uno_kicks.sh [looping] [ticker|start len]"
    # @see https://stackoverflow.com/a/1535733
    exit 64
    # echo "./uno_kicks.sh [looping] [start] [len]"
fi
LOOPING=$1

if [[ $LOOPING -eq 1 ]]
then
    cp datafiles/activity_watchlist.ods datafiles/activity_watchlist.0.ods
    index=1 # calc start index, while txt/calc not sync
    count=0
    NLINES=( $(wc -l datafiles/watchlist.txt | cut -d " " -f5) )
    if [[ $# -gt 1 ]]; then
	START=$2
	LEN=$3
    else
	START=0
	LEN=$NLINES
    fi
    TIMESTAMP=`date '+%Y/%m/%d %H:%M:%S'`
    echo "time: " $TIMESTAMP " looping " $LOOPING

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
	# OUTPUT=($(python3 basic.py $TICKER | tr -d '[],'))
	# CO_NAME=${OUTPUT[1]%\'}
	# CO_NAME=${CO_NAME#\'}
	# MSG=$(printf "%04d %04d %04.2f %s" $index $TICKER $DEAL $CO_NAME)
	MSG=$(printf "%04d %04d %04.2f %s" $index $TICKER $DEAL )
	echo $MSG
	/Applications/LibreOffice.app/Contents/Resources/python \
	    uno_kicks.py $TICKER $DEAL
	index=$(($index+1))
	count=$(($count+1))
	if [[ $count -ge $LEN ]]; then
	    echo "finish $count items."
	    break
	fi
	sleep 2
    done < datafiles/watchlist.txt
    echo "done."
    TIMESTAMP=`date '+%Y/%m/%d %H:%M:%S'`
    echo "time: " $TIMESTAMP " looping " $LOOPING
else
    TICKER=$2
    # update a single ticker
    OUTPUT=($(python3 quote.py $TICKER | tr -d '[],'))
    DEAL=${OUTPUT[0]%\'}
    DEAL=${DEAL#\'}
    OUTPUT=($(python3 basic.py $TICKER | tr -d '[],'))
    CO_NAME=${OUTPUT[1]%\'}
    CO_NAME=${CO_NAME#\'}
    CO_TYPE=${OUTPUT[2]%\'}
    CO_TYPE=${CO_TYPE#\'}
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
    else
	# // TODO:
	QDI=0
	FUND=0
	RETAIL=0
	TOTAL=0
    fi
    MSG=$(printf "%04d %s %04.2f %s %s %s %s" \
	$TICKER $CO_NAME $DEAL $QDI $FUND $RETAIL $TOTAL)
    echo $MSG
    # OUTPUT=($(python3 briefing.py $TICKER | tr -d '[],'))
    RETURN=( $(/Applications/LibreOffice.app/Contents/Resources/python \
	uno_kicks.py $TICKER $DEAL $CO_NAME \
	$QDI $FUND $RETAIL $TOTAL  | tr -d '[],' ) )
    OPUT=${RETURN[0]%\'}
    OPUT=${OPUT#\'}
    # echo $OPUT # test return from calc
fi

exit 0
