#!/bin/bash
if [ "$#" -lt 1 ]; then
    echo "./uno_status.sh [ticker]"
    exit 64
fi

TICKER=$1
# // TODO: grep type as input parameter instead of judging inside quote.py
LIST_TYPE=($(grep -rnp --color="auto" -e "$TICKER" datafiles/listed_[245].txt \
    | cut -d "." -f 1 | cut -d "_" -f 2 ))
if [ "$LIST_TYPE" != "2" ] && [ "$LIST_TYPE" != "4" ] \
    && [ "$LIST_TYPE" != "5" ]; then
	echo $TICKER " is not listed."
	say -v "Mei-Jia" \
	    ${TICKER:0:1} ${TICKER:1:1} ${TICKER:2:1} ${TICKER:3:1} \
	    "[[slnc 200]]" " is not listed."
	exit 0
fi
OUTPUT=($(python3 quote.py $TICKER $LIST_TYPE | tr -d '[],'))
QUOTE=${OUTPUT[0]%\'}
QUOTE=${QUOTE#\'}
OUTPUT=($(python3 basic.py $TICKER | tr -d '[],'))
CO_TYPE=${OUTPUT[2]%\'}
CO_TYPE=${CO_TYPE#\'}
CO_NAME=${OUTPUT[1]%\'}
CO_NAME=${CO_NAME#\'}
CAPE=${OUTPUT[9]%\'}
CAPE=${CAPE#\'}

python3 board.py $TICKER 1

say -v "Mei-Jia" \
    ${TICKER:0:1} ${TICKER:1:1} ${TICKER:2:1} ${TICKER:3:1} \
    "[[slnc 200]]" $CO_NAME

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

    SMA=($(python3 sma5.py $TICKER 1 | tr -d '[],'))
    SMA5=${SMA[0]%\'}
    SMA5=${SMA5#\'}
    SMA5_D=${SMA[1]%\'}
    SMA5_D=${SMA5_D#\'}

    SMA20=${SMA[2]%\'}
    SMA20=${SMA20#\'}
    SMA20_D=${SMA[3]%\'}
    SMA20_D=${SMA20_D#\'}

    SMA60=${SMA[4]%\'}
    SMA60=${SMA60#\'}
    SMA60_D=${SMA[5]%\'}
    SMA60_D=${SMA60_D#\'}

    EPSs=($(python3 eps.py $TICKER 1 | tr -d '[],'))
    # // TODO: starting from q0, 10 columns
    EPS_Q0=${EPSs[0]%\'}; EPS_Q0=${EPS_Q0#\'}
    EPS_Q1=${EPSs[1]%\'}; EPS_Q1=${EPS_Q1#\'}
    EPS_Q2=${EPSs[2]%\'}; EPS_Q2=${EPS_Q2#\'}
    EPS_Q3=${EPSs[3]%\'}; EPS_Q3=${EPS_Q3#\'}
    EPS_Q4=${EPSs[4]%\'}; EPS_Q4=${EPS_Q4#\'}
    EPS_Q5=${EPSs[5]%\'}; EPS_Q5=${EPS_Q5#\'}
    EPS_Q6=${EPSs[6]%\'}; EPS_Q6=${EPS_Q6#\'}
    EPS_Q7=${EPSs[7]%\'}; EPS_Q7=${EPS_Q7#\'}
    EPS_Q8=${EPSs[8]%\'}; EPS_Q8=${EPS_Q8#\'}
    EPS_Q9=${EPSs[9]%\'}; EPS_Q9=${EPS_Q9#\'}

    printf "ticker: %04d %s %d %04.2f\n" $TICKER $CO_NAME $CO_TYPE $QUOTE
    printf "activity: %d %d %d %d\n" $QDI $FUND $RETAIL $TOTAL
    printf "pe: %04.2f %04.2f %04.2f %04.2f\n" $PER $PER_H52 $PER_L52 $PER_PEER
    printf "range: %.2f %.2f %.2f %.2f\n" $RL52 $RL52P $RH52 $RH52P
    printf "sma: %s %s %s %s %s %s\n" $SMA5 $SMA5_D $SMA20 $SMA20_D $SMA60 $SMA60_D
    printf "eps: %s %s %s %s %s %s %s %s %s %s\n" \
	$EPS_Q0 $EPS_Q1 $EPS_Q2 $EPS_Q3 $EPS_Q4 \
	$EPS_Q5 $EPS_Q6 $EPS_Q7 $EPS_Q8 $EPS_Q9

    RETURN=( $(/Applications/LibreOffice.app/Contents/Resources/python \
       uno_eps.py $TICKER                                              \
       $EPS_Q0 $EPS_Q1 $EPS_Q2 $EPS_Q3 $EPS_Q4                         \
       $EPS_Q5 $EPS_Q6 $EPS_Q7 $EPS_Q8 $EPS_Q9                         \
       | tr -d '[],' ) )

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
    printf "ticker: %04d %s %d %04.2f\n" $TICKER $CO_NAME $CO_TYPE $QUOTE
    printf "activity: %d %d %d %d\n" $QDI $FUND $RETAIL $TOTAL
    printf "pe: %s %s %s %s\n" $PER $PER_H52 $PER_L52 $PER_PEER
    printf "range: %s %s %s %s\n" $RL52 $RL52P $RH52 $RH52P
fi

RETURN=( $(/Applications/LibreOffice.app/Contents/Resources/python \
    uno_kicks.py $TICKER $QUOTE $CO_NAME           \
    $QDI $FUND $RETAIL $TOTAL                     \
    $PER $PER_H52 $PER_L52 $PER_PEER              \
    $RL52 $RL52P $RH52 $RH52P                     \
    $EPS2021Q4 $EPS2021Q3 $EPS2021Q2 $EPS2021Q1   \
    $EPS2020Q4 $EPS2020Q3 $EPS2020Q2 $EPS2020Q1   \
    $EPS2019Q4 $EPS2019Q3 $CAPE                   \
    $SMA5 $SMA5_D $SMA20 $SMA20_D $SMA60 $SMA60_D \
    | tr -d '[],' ) )

O_SPEC=${RETURN[0]%\'}
O_SPEC=${O_SPEC#\'}
# O_SPEC1=${RETURN[1]%\'}
# O_SPEC1=${O_SPEC1#\'}
# O_SPEC2=${RETURN[2]%\'}
# O_SPEC2=${O_SPEC2#\'}
# echo $O_SPEC1" "$O_SPEC2
if [ $O_SPEC -eq 1 ]; then
    # echo -ne '\007' # beep
    CONDITION="跌破支撐" # $((5 % 2**3))
    say -v "Mei-Jia" \
	${TICKER:0:1} ${TICKER:1:1} ${TICKER:2:1} ${TICKER:3:1} \
	"[[slnc 400]]" $QUOTE \
	"[[slnc 300]]條件" $O_SPEC "[[slnc 200]]" $CONDITION
elif [ $((O_SPEC/(2**1))) -eq 1 ] && [ $((O_SPEC%(2**1))) -eq 0 ]; then
    CONDITION="突破壓力"
    say -v "Mei-Jia" \
	${TICKER:0:1} ${TICKER:1:1} ${TICKER:2:1} ${TICKER:3:1} \
	"[[slnc 400]]" $QUOTE \
	"[[slnc 300]]條件" $O_SPEC "[[slnc 200]]" $CONDITION
# elif [ $((O_SPEC/(2**2))) -eq 1 ] && [ $((O_SPEC%(2**2))) -eq 0 ]; then
    # CONDITION="跌破52週新低"
    # say -v "Mei-Jia" \
    #    ${TICKER:0:1} ${TICKER:1:1} ${TICKER:2:1} ${TICKER:3:1} \
    #    "[[slnc 400]]" $QUOTE \
    #    "[[slnc 300]]條件" $O_SPEC "[[slnc 200]]" $CONDITION
elif [ $((O_SPEC/(2**3))) -eq 1 ] && [ $((O_SPEC%(2**3))) -eq 0 ]; then
    CONDITION="跌入合理區間"
    say -v "Mei-Jia" \
	${TICKER:0:1} ${TICKER:1:1} ${TICKER:2:1} ${TICKER:3:1} \
	"[[slnc 400]]" $QUOTE \
	"[[slnc 300]]條件" $O_SPEC "[[slnc 200]]" $CONDITION
# elif [ $((O_SPEC/(2**4))) -eq 1 ] && [ $((O_SPEC%(2**4))) -eq 0 ]; then
    # CONDITION="突破52週新高"
    # say -v "Mei-Jia" \
    #    ${TICKER:0:1} ${TICKER:1:1} ${TICKER:2:1} ${TICKER:3:1} \
    #    "[[slnc 400]]" $QUOTE \
    #    "[[slnc 300]]條件" $O_SPEC "[[slnc 200]]" $CONDITION
# else
    # say -v "Mei-Jia" \
    #     ${TICKER:0:1} ${TICKER:1:1} ${TICKER:2:1} ${TICKER:3:1} \
    #    "[[slnc 400]]" $QUOTE
fi

if [ $(echo $QUOTE'>'$SMA5 | bc -l) -eq 1 ] \
    && [ $(echo $QUOTE'>'$SMA20 | bc -l) -eq 1 ] \
    && [ $(echo $QUOTE'>'$SMA60 | bc -l) -eq 1 ]; then
    CONDITION="站上所有均線"
    say -v "Mei-Jia" \
	${TICKER:0:1} ${TICKER:1:1} ${TICKER:2:1} ${TICKER:3:1} \
	"[[slnc 400]]" $QUOTE "[[slnc 300]]" $CONDITION
fi

# be aware the usage
# python3 hbs30.py $TICKER
echo

exit 0
