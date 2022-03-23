#!/bin/bash

# idea 1: import module in LO (WIP)
# PYTHONPATH=$PYTHONPATH:/Library/Frameworks/Python.framework/Versions/3.9/lib/python3.9/site-packages
# PATH=$PATH:/Library/Frameworks/Python.framework/Versions/3.9/lib/python3.9/site-packages
# (WIP) make sure python3-uno installed ( in LO maybe? )
# /Library/Frameworks/Python.framework/Versions/3.9/bin/python3.9 -m pip install --upgrade pip
# python3 -m pip install uno

cp datafiles/activity_watchlist.ods datafiles/activity_watchlist.0.ods
NLINES=( $(wc -l datafiles/bountylist.txt | cut -d " " -f5) )
TIMESTAMP=`date '+%Y/%m/%d %H:%M:%S'`
echo "time: "$TIMESTAMP " stalk #line " $NLINES

while true; do
    index=1
    while read p; do
	TICKER=$p
	# // TODO: handle newly added item when process is ongoing
	# @see https://stackoverflow.com/a/6022441
	# sed '443q;d' datafiles/bountylist.txt
	# sed '1072!d' datafiles/bountylist.txt
	# awk 'NR==1071' datafiles/bountylist.txt
	# TKR=( $(sed '1070q;d' datafiles/bountylist.txt) )
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
	sleep 1
    done < datafiles/bountylist.txt
    TIMESTAMP=`date '+%Y/%m/%d %H:%M:%S'`
    echo "time: " $TIMESTAMP " looping end"

    # In the following line -t for timeout, -N for just 1 character
    read -t 1 input
    if [[ $input = "q" ]] || [[ $input = "Q" ]]; then
	# The following line is for the prompt to appear on a new line.
        echo
        break
    fi
    sleep 10
done

exit 0
