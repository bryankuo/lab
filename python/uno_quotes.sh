#!/bin/bash
# make sure running uno.sh
# echo "$#"
if [ "$#" -lt 1 ]; then
    echo "./uno_quotes.sh [start] [len]"
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
echo "time: "$TIMESTAMP0 " start "$START " len "$LEN " #line "$NLINES

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
    if [ $((O_SPEC/(2**1))) -eq 0 ] && [ $((O_SPEC%(2**1))) -eq 1 ]; then
	# echo -ne '\007' # beep
	CONDITION="跌破支撐" # $((5 % 2**3))
	say -v "Mei-Jia" \
	    ${TICKER:0:1} ${TICKER:1:1} ${TICKER:2:1} ${TICKER:3:1} \
	    "[[slnc 400]]" $DEAL \
	    "[[slnc 300]]條件" $O_SPEC "[[slnc 200]]" $CONDITION
    elif [ $((O_SPEC/(2**1))) -eq 1 ] && [ $((O_SPEC%(2**1))) -eq 0 ]; then
	CONDITION="突破壓力"
	say -v "Mei-Jia" \
	    ${TICKER:0:1} ${TICKER:1:1} ${TICKER:2:1} ${TICKER:3:1} \
	    "[[slnc 400]]" $DEAL \
	    "[[slnc 300]]條件" $O_SPEC "[[slnc 200]]" $CONDITION
    # elif [ $((O_SPEC/(2**2))) -eq 1 ] && [ $((O_SPEC%(2**2))) -eq 0 ]; then
	# CONDITION="跌破52週新低"
	# say -v "Mei-Jia" \
	#    ${TICKER:0:1} ${TICKER:1:1} ${TICKER:2:1} ${TICKER:3:1} \
	#    "[[slnc 400]]" $DEAL \
	#    "[[slnc 300]]條件" $O_SPEC "[[slnc 200]]" $CONDITION
    elif [ $((O_SPEC/(2**3))) -eq 1 ] && [ $((O_SPEC%(2**3))) -eq 0 ]; then
	CONDITION="跌入合理區間"
	say -v "Mei-Jia" \
	    ${TICKER:0:1} ${TICKER:1:1} ${TICKER:2:1} ${TICKER:3:1} \
	    "[[slnc 400]]" $DEAL \
	    "[[slnc 300]]條件" $O_SPEC "[[slnc 200]]" $CONDITION
    # elif [ $((O_SPEC/(2**4))) -eq 1 ] && [ $((O_SPEC%(2**4))) -eq 0 ]; then
	# CONDITION="突破52週新高"
	# say -v "Mei-Jia" \
	#    ${TICKER:0:1} ${TICKER:1:1} ${TICKER:2:1} ${TICKER:3:1} \
	#    "[[slnc 400]]" $DEAL \
	#    "[[slnc 300]]條件" $O_SPEC "[[slnc 200]]" $CONDITION
    # else
	# say -v "Mei-Jia" \
	#     ${TICKER:0:1} ${TICKER:1:1} ${TICKER:2:1} ${TICKER:3:1} \
	#    "[[slnc 400]]" $DEAL
    fi

    index=$(($index+1))
    count=$(($count+1))
    if [[ $count -ge $LEN ]]; then
	say -v "Mei-Jia" "完成 $count 個項目"
	echo "finish $count items."
	break
    fi
    sleep 2
done < datafiles/watchlist.txt
TIMESTAMP1=`date '+%Y/%m/%d %H:%M:%S'`
echo "time: " $TIMESTAMP0 " looping start"
echo "time: " $TIMESTAMP1 " looping end"

exit 0
