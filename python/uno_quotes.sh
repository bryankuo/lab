#!/bin/bash
# make sure running uno.sh
# echo "$#"
if [ "$#" -lt 1 ]; then
    echo "./uno_quotes.sh 0 for bounty list"
    exit 64 # @see https://stackoverflow.com/a/1535733
fi

cp datafiles/activity_watchlist.ods datafiles/activity_watchlist.0.ods
index=1 # calc start index, while txt/calc not sync
count=0
LIST="datafiles/watchlist.txt"
BOUNTY="datafiles/bountylist.txt"
# NLINES=( $(wc -l datafiles/watchlist.txt | cut -d " " -f5) )
NLINES=$(wc -l $LIST | xargs | cut -d " " -f1)
if [[ $# -gt 1 ]]; then
    START=$1
    LEN=$2
    index=$1
else
    if [[ $1 -eq 0 ]]; then
	LIST=$BOUNTY
	NLINES=$(wc -l $LIST | xargs | cut -d " " -f1)
	LEN=$NLINES
    else
	START=$index
	LEN=$NLINES
    fi
fi
TIMESTAMP0=`date '+%Y/%m/%d %H:%M:%S'`
echo "time: "$TIMESTAMP0
echo "start "$START " len "$LEN " #line "$NLINES" list "$LIST

while true; do
    TICKER=( $(sed "$index""q;d" $LIST) )
    LIST_TYPE=($(grep -rnp --color="auto" -e "$TICKER" datafiles/listed_[245].txt \
	| cut -d "." -f 1 | cut -d "_" -f 2 ))
    if [ "$LIST_TYPE" != "2" ] && [ "$LIST_TYPE" != "4" ] \
	&& [ "$LIST_TYPE" != "5" ]; then
	    MSG=$(printf "%04d %04d is not listed" $index $TICKER)
	    echo $MSG
	    say -v "Mei-Jia" \
		${TICKER:0:1} ${TICKER:1:1} ${TICKER:2:1} ${TICKER:3:1} \
		"[[slnc 200]]" " is not listed."
    else
	OUTPUT=($(python3 quote.py $TICKER $LIST_TYPE | tr -d '[],'))
	# OUTPUT=($(python3 quote.py $TICKER | tr -d '[],'))
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
	    read -p "Press enter to continue..."
	elif [ $((O_SPEC/(2**1))) -eq 1 ] && [ $((O_SPEC%(2**1))) -eq 0 ]; then
	    CONDITION="突破壓力"
	    say -v "Mei-Jia" \
		${TICKER:0:1} ${TICKER:1:1} ${TICKER:2:1} ${TICKER:3:1} \
		"[[slnc 400]]" $DEAL \
		"[[slnc 300]]條件" $O_SPEC "[[slnc 200]]" $CONDITION
	    read -p "Press enter to continue..."
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
	    # read -p "Press enter to continue..."
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
    fi

    index=$(($index+1))
    count=$(($count+1))
    if [ $count -ge $LEN ] || [ $index -gt $NLINES ] ; then
	say -v "Mei-Jia" "完成 $count 個項目"
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

# done < datafiles/watchlist.txt
done

TIMESTAMP1=`date '+%Y/%m/%d %H:%M:%S'`
echo "time: " $TIMESTAMP0 " looping start"
echo "time: " $TIMESTAMP1 " looping end"

exit 0
