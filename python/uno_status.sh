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
CAPE=${OUTPUT[9]%\'}
CAPE=${CAPE#\'}
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

    RANGE=($(python3 range52w.py $TICKER 1 | tr -d '[],'))
    # echo ${RANGE[@]}
    RL52=${RANGE[0]%\'}
    RL52=${RL52#\'}
    RL52P=${RANGE[1]%\'}
    RL52P=${RL52P#\'}
    RH52=${RANGE[2]%\'}
    RH52=${RH52#\'}
    RH52P=${RANGE[3]%\'}
    RH52P=${RH52P#\'}
    printf "ticker: %04d %s %d %04.2f\n" $TICKER $CO_NAME $CO_TYPE $DEAL
    printf "activity: %d %d %d %d\n" $QDI $FUND $RETAIL $TOTAL
    printf "pe: %04.2f %04.2f %04.2f %04.2f\n" $PER $PER_H52 $PER_L52 $PER_PEER
    printf "range: %.2f %.2f %.2f %.2f\n" $RL52 $RL52P $RH52 $RH52P
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
    RL52="n/a"
    RL52P="n/a"
    RH52="n/a"
    RH52P="n/a"
    printf "ticker: %04d %s %d %04.2f\n" $TICKER $CO_NAME $CO_TYPE $DEAL
    printf "activity: %d %d %d %d\n" $QDI $FUND $RETAIL $TOTAL
    printf "pe: %s %s %s %s\n" $PER $PER_H52 $PER_L52 $PER_PEER
    printf "range: %s %s %s %s\n" $RL52 $RL52P $RH52 $RH52P
fi

RETURN=( $(/Applications/LibreOffice.app/Contents/Resources/python \
    uno_kicks.py $TICKER $DEAL $CO_NAME \
    $QDI $FUND $RETAIL $TOTAL \
    $PER $PER_H52 $PER_L52 $PER_PEER \
    $RL52 $RL52P $RH52 $RH52P \
    $EPS2021Q4 $EPS2021Q3 $EPS2021Q2 $EPS2021Q1 \
    $EPS2020Q4 $EPS2020Q3 $EPS2020Q2 $EPS2020Q1 \
    $EPS2019Q4 $EPS2019Q3 $CAPE \
    | tr -d '[],' ) )

O_SPEC=${RETURN[0]%\'}
O_SPEC=${O_SPEC#\'}
# O_SPEC1=${RETURN[1]%\'}
# O_SPEC1=${O_SPEC1#\'}
# O_SPEC2=${RETURN[2]%\'}
# O_SPEC2=${O_SPEC2#\'}
# echo $O_SPEC1" "$O_SPEC2
if [ "$O_SPEC" == "1" ]; then
    echo -ne '\007'
fi

exit 0
