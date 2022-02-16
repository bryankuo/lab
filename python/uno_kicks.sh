#!/bin/bash

# idea 1: import module in LO (WIP)
# PYTHONPATH=$PYTHONPATH:/Library/Frameworks/Python.framework/Versions/3.9/lib/python3.9/site-packages
# PATH=$PATH:/Library/Frameworks/Python.framework/Versions/3.9/lib/python3.9/site-packages
# (WIP) make sure python3-uno installed ( in LO maybe? )
# /Library/Frameworks/Python.framework/Versions/3.9/bin/python3.9 -m pip install --upgrade pip
# python3 -m pip install uno

# idea 2: glue 2 scripts by bash
: <<'END'
while true; do
OUTPUT=($(python3 quote.py $1 | tr -d '[],'))
DEAL=${OUTPUT[0]%\'}
DEAL=${DEAL#\'}
/Applications/LibreOffice.app/Contents/Resources/python \
    uno_kicks.py $1 $DEAL
sleep 3
done
END

while read p; do
    # echo "$p"
    OUTPUT=($(python3 quote.py $p | tr -d '[],'))
    DEAL=${OUTPUT[0]%\'}
    DEAL=${DEAL#\'}
    /Applications/LibreOffice.app/Contents/Resources/python \
	uno_kicks.py $p $DEAL
    sleep 3
done < datafiles/watchlist.txt

exit 0
