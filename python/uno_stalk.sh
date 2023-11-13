#!/bin/bash

# idea 1: import module in LO (WIP)
# PYTHONPATH=$PYTHONPATH:/Library/Frameworks/Python.framework/Versions/3.9/lib/python3.9/site-packages
# PATH=$PATH:/Library/Frameworks/Python.framework/Versions/3.9/lib/python3.9/site-packages
# (WIP) make sure python3-uno installed ( in LO maybe? )
# /Library/Frameworks/Python.framework/Versions/3.9/bin/python3.9 -m pip install --upgrade pip
# python3 -m pip install uno

# cp datafiles/activity_watchlist.ods datafiles/activity_watchlist.0.ods
LIST="datafiles/bountylist.txt"
index=1 # calc start index, while txt/calc not sync
count=0
NLINES=$(wc -l $LIST | xargs | cut -d " " -f1)
echo $NLINES
if [[ $# -gt 1 ]]; then
    START=$1
    LEN=$2
else
    START=$index
    LEN=$NLINES
fi
TIMESTAMP0=`date '+%Y/%m/%d %H:%M:%S'`
echo "time: "$TIMESTAMP0 " stalk " $LIST " #line " $NLINES

while true; do
    # // TODO: uno_activity.sh
    # @see https://stackoverflow.com/a/6022441
    # awk 'NR==1071' datafiles/watchlist.txt
    TICKER=( $(sed "$index""q;d" $LIST) )
    echo $TICKER

    # PER update, it is more meaningful updating peers.
    if true; then
	OUTPUT=($(python3 quote.py $TICKER | tr -d '[],'))
	# DEAL=${OUTPUT[0]%\'}
	# DEAL=${DEAL#\'}
	DEAL=${OUTPUT[0]}
	OUTPUT=($(python3 pe.py $TICKER 1 | tr -d '[],'))
	PER=${OUTPUT[0]%\'}
	PER=${PER#\'}
	PER_H52=${OUTPUT[1]%\'}
	PER_H52=${PER_H52#\'}
	PER_L52=${OUTPUT[2]%\'}
	PER_L52=${PER_L52#\'}
	PER_PEER=${OUTPUT[3]%\'}
	PER_PEER=${PER_PEER#\'}
	# MSG=$(printf "ticker: %04d %04.2f \
	#    PER: %04.2f %04.2f %04.2f %04.2f\n" \
	#    $TICKER $DEAL $PER $PER_H52 $PER_L52 $PER_PEER )
	#echo $MSG
	RETURN=( $(/Applications/LibreOffice.app/Contents/Resources/python \
	    uno_per.py $TICKER $DEAL $PER $PER_H52 $PER_L52 $PER_PEER | \
	    tr -d '[],' ) )
	O_SPEC=${RETURN[0]%\'}
	O_SPEC=${O_SPEC#\'}
	# echo $OPUT # test return from calc
	if [ "$O_SPEC" == "1" ]; then
	    echo -ne '\007'
	fi
    fi

    # quotes update
    if false; then
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
    fi

    index=$(($index+1))
    count=$(($count+1))
    if [ $count -ge $NLINES ] ; then
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
    sleep 3
done
TIMESTAMP=`date '+%Y/%m/%d %H:%M:%S'`
echo "time: " $TIMESTAMP " looping end"
exit 0
