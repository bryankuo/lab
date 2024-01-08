#!/bin/bash

# ./qvrs.sh [yyyymmdd]
#
# a wrapper of qvrs.py
#
# \param in yyyymmdd

if [ "$#" -lt 1 ]; then
    echo "usage: ./qvrs.sh [yyyymmdd]"
    exit 22 # @see https://stackoverflow.com/a/50405954
fi

DATE=$1
DIR0="./datafiles/taiex/rs"

python3 after_market.py $DATE 0
python3 after_market.py $DATE 1
python3 qvrs.py $DATE

echo "sorting by ticker ascending..."
sort -t: -n -k1 "$DIR0/qvrs.$DATE.price.desc.csv" \
    > "$DIR0/qvrs.$DATE.ticker.asc.csv"

ls -lt ./datafiles/taiex/rs/*$DATE*
ls -lt ./datafiles/taiex/after.market/*$DATE*
tput bel

./uno_launch.sh "./datafiles/activity_watchlist.ods"
read -p "Press enter to continue ..."

/Applications/LibreOffice.app/Contents/Resources/python uno_qvrs.py $DATE
tput bel

exit 0
