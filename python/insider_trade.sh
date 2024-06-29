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

# python3 insider_trade.py 20240630 # $DATE
OUTPUT=($(python3 insider_trade.py 20240629 0 | tr -d '@'))
echo ${OUTPUT[@]}
TKRS=${OUTPUT[@]}

# confirmation purpose
# python3 browse_url.py https://tcfhcsec.moneydj.com/z/ze/zei/zei.djhtm

tput bel
read -p "Press enter open calc ..."
./uno_launch.sh "$DIR0/activity_watchlist.ods"

tput bel
read -p "Press enter pick tickers ..."
/Applications/LibreOffice.app/Contents/Resources/python \
    uno/pick_tickers.py "$TKRS"

exit 0
