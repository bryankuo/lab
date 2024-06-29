#!/bin/bash

# ./qvrs.sh
#
# a wrapper of qvrs.py to determine q,v,rs quickly
#
# \param in

# if [ "$#" -lt 1 ]; then
#    echo "usage: ./qvrs.sh [yyyymmdd]"
#    exit 22 # @see https://stackoverflow.com/a/50405954
# fi

DATE=$(date +%Y%m%d)
DIR0="./datafiles"

# python3 insider_trade.py $DATE

tput bel
read -p "Press enter open calc ..."
./uno_launch.sh "$DIR0/activity_watchlist.ods"

tput bel
read -p "Press enter update vt1, vt0 ..."
/Applications/LibreOffice.app/Contents/Resources/python \
    uno/pick_tickers.py "1101,1102"

exit 0
