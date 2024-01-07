#!/bin/bash

# ./rs_wrt_twse.sh [yyyymmdd]
#
# a wrapper of rs_wrt_twse.py
#
# \param in yyyymmdd

if [ "$#" -lt 1 ]; then
    echo "usage: ./rs_wrt_twse.sh [yyyymmdd]"
    exit 22 # @see https://stackoverflow.com/a/50405954
fi

DATE=$1
DIR0="./datafiles/taiex/rs"

python3 after_market.py $DATE 1
python3 rs_wrt_twse.py $DATE

echo "sorting by RS..."
sort -t: -nr -k2 "$DIR0/rs.wrt.twse.$DATE.price.desc.csv" \
    > "$DIR0/rs.wrt.twse.$DATE.rs.desc.csv"

ls -lt ./datafiles/taiex/rs/*$DATE*
ls -lt ./datafiles/taiex/after.market/*$DATE*

exit 0
