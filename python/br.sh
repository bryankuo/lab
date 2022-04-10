#!/bin/bash
STEP=$2
TICKER=$1

if [[ $STEP -eq 1 ]]; then
    # open and download frame as html source
    python3 br_ticker.py $TICKER

elif [[ $STEP -eq 2 ]]; then

    BASIC=($(python3 basic.py $TICKER | tr -d '[],'))
    echo ${BASIC[@]}

    CO_ADDR=${BASIC[6]%\'}
    CO_ADDR=${CO_ADDR#\'}
    KEYWORD=`echo ${CO_ADDR} | cut -c1-2`
    echo $CO_ADDR" "$KEYWORD

    grep --color="auto" -e $KEYWORD datafiles/broker_list.csv \
       | cut -d ":" -f 1,2,4 > datafiles/${TICKER}_geo.txt
    ls -ltr datafiles/${TICKER}_geo.txt

elif [[ $STEP -eq 3 ]]; then
    # down frame as html source
    python3 transaction.py ~/Downloads/bsContent.html > \
	datafiles/${TICKER}_20220401.txt
    ls -ltr datafiles/${TICKER}_20220401.txt
fi

exit 0
