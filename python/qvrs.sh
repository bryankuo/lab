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
DIR0r="./datafiles/taiex/rs"
DIR0="./datafiles/taiex/after.market"

python3 after_market.py $DATE 0
python3 after_market.py $DATE 1

currenttime=$(date +%H:%M)
TIME=${currenttime:0:2}${currenttime:3:2}
cp -v "$DIR0/$DATE.all.columns.csv" "$DIR0/$DATE.$TIME.all.columns.csv"

python3 qvrs.py $DATE

# echo "sorting by ticker ascending..."
# sort -t: -n -k1 -o "$DIR0r/qvrs.$DATE.ticker.asc.csv" \
#    "$DIR0r/qvrs.$DATE.price.desc.csv"
# done by qvrs.py

sort -k1 -n -t: -o "$DIR0/$DATE.csv" \
    "$DIR0/$DATE.price.desc.csv"

cp -v "$DIR0/$DATE.csv" "$DIR0/$DATE.$TIME.csv"

cp -v "$DIR0r/qvrs.$DATE.ticker.asc.csv" \
    "$DIR0r/qvrs.$DATE.$TIME.ticker.asc.csv"

cp -v "$DIR0r/qvrs.$DATE.ticker.asc.csv" \
    "$DIR0r/qvrs.$DATE.$TIME.ticker.asc.csv"

RIGHT_NOW=$( ls -lt $DIR0/$DATE.????.csv | head -n 2 \
    | cut -d '/' -f 5 | cut -c 1-13 | xargs | cut -d ' ' -f 1 )

LAST_TRADE_DAY=$( ls -lt $DIR0/????????.csv | head -n 2 \
    | cut -d '/' -f 5 | cut -c 1-8 | xargs | cut -d ' ' -f 2 )

python3 compare_volume.py $RIGHT_NOW $LAST_TRADE_DAY

tput bel
read -p "Press enter open calc ..."
./uno_launch.sh "./datafiles/activity_watchlist.ods"

tput bel
read -p "Press enter update vt1, vt0 ..."
/Applications/LibreOffice.app/Contents/Resources/python \
    uno_vratio.py $RIGHT_NOW $LAST_TRADE_DAY

tput bel
read -p "Press enter update q,vt1,rs ..."
/Applications/LibreOffice.app/Contents/Resources/python \
    uno_qvrs.py $RIGHT_NOW

# ls -lt ./datafiles/taiex/rs/*$DATE*
ls -lt ./datafiles/taiex/after.market/*$DATE*
tput bel

exit 0
