#!/bin/bash
if [ "$#" -lt 1 ]; then
    echo "./uno_status.sh [ticker]"
    exit 64
fi
TICKER=$1
OUTPUT=($(python3 quote.py $TICKER | tr -d '[],'))
DEAL=${OUTPUT[0]%\'}
DEAL=${DEAL#\'}
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
    OUTPUT=($(python3 pe.py $TICKER 1 | tr -d '[],'))
    PER=${OUTPUT[0]%\'}
    PER=${PER#\'}
    PER_H52=${OUTPUT[1]%\'}
    PER_H52=${PER_H52#\'}
    PER_L52=${OUTPUT[2]%\'}
    PER_L52=${PER_L52#\'}
    PER_PEER=${OUTPUT[3]%\'}
    PER_PEER=${PER_PEER#\'}
    MSG=$(printf \
	"%04d %s %d %04.2f activity:%7d %7d %7d %7d pe:%04.2f %04.2f %04.2f %04.2f\n" \
	$TICKER $CO_NAME $CO_TYPE $DEAL $QDI $FUND $RETAIL $TOTAL \
	$PER $PER_H52 $PER_L52 $PER_PEER)
else
    # // TODO:
    QDI=0
    FUND=0
    RETAIL=0
    TOTAL=0
    PER="n/a"
    PER_H52="n/a"
    PER_L52="n/a"
    PER_PEER="n/a"
    MSG=$(printf \
	"%04d %s %d %04.2f activity:%7d %7d %7d %7d pe:%s %s %s %s\n" \
	$TICKER $CO_NAME $CO_TYPE $DEAL $QDI $FUND $RETAIL $TOTAL \
	$PER $PER_H52 $PER_L52 $PER_PEER)
fi
echo $MSG
RETURN=( $(/Applications/LibreOffice.app/Contents/Resources/python \
    uno_kicks.py $TICKER $DEAL $CO_NAME \
    $QDI $FUND $RETAIL $TOTAL \
    $PER $PER_H52 $PER_L52 $PER_PEER \
    | tr -d '[],' ) )
O_SPEC=${RETURN[0]%\'}
O_SPEC=${O_SPEC#\'}
# echo $OPUT # test return from calc
if [ "$O_SPEC" == "1" ]; then
    echo -ne '\007'
fi

exit 0
