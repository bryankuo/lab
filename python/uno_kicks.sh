#!/bin/bash

# idea 1: import module in LO (WIP)
# PYTHONPATH=$PYTHONPATH:/Library/Frameworks/Python.framework/Versions/3.9/lib/python3.9/site-packages
# PATH=$PATH:/Library/Frameworks/Python.framework/Versions/3.9/lib/python3.9/site-packages
# (WIP) make sure python3-uno installed ( in LO maybe? )
# /Library/Frameworks/Python.framework/Versions/3.9/bin/python3.9 -m pip install --upgrade pip
# python3 -m pip install uno

# idea 2: glue 2 scripts by bash
# make sure running uno.sh

LOOPING=0
TIMESTAMP=`date '+%Y/%m/%d %H:%M:%S'`
echo "time: " $TIMESTAMP " looping " $LOOPING
if [[ $LOOPING -eq 1 ]]
then
    TIMESTAMP=`date '+%Y/%m/%d %H:%M:%S'`
    index=0
    # @see https://stackoverflow.com/a/6022441
    # sed '443q;d' datafiles/watchlist.txt
    # wc -l datafiles/watchlist.txt | cut -d " " -f6
    while read p; do
	# echo "$p"
	index=$(($index+1))
	OUTPUT=($(python3 quote.py $p | tr -d '[],'))
	echo ${OUTPUT[@]}
	DEAL=${OUTPUT[0]%\'}
	DEAL=${DEAL#\'}
	MSG=$(printf "%04d %04d %04.2f" $index $p $DEAL)
	echo $MSG
	/Applications/LibreOffice.app/Contents/Resources/python \
	    uno_kicks.py $p $DEAL
	sleep 2
    done < datafiles/watchlist.txt
else
    # update a single ticker
    OUTPUT=($(python3 quote.py $1 | tr -d '[],'))
    DEAL=${OUTPUT[0]%\'}
    DEAL=${DEAL#\'}
    MSG=$(printf "%04d %04.2f" $1 $DEAL)
    OUTPUT=($(python3 basic.py $1 | tr -d '[],'))
    CO_NAME=${OUTPUT[1]%\'}
    CO_NAME=${CO_NAME#\'}
    echo $MSG $OUTPUT
    /Applications/LibreOffice.app/Contents/Resources/python \
	uno_kicks.py $1 $DEAL $CO_NAME
fi

echo "done."
TIMESTAMP=`date '+%Y/%m/%d %H:%M:%S'`
echo "time: " $TIMESTAMP " looping " $LOOPING
exit 0
