#!/bin/bash

if [ "$#" -lt 1 ]; then
    echo "usage: ./rs_daily.sh [tkr]"
    exit 22
fi

python3 rw_qvrs.py $1

./uno_launch.sh datafiles/taiex/rs/qvrs.$1.ticker.asc.ods

exit 0
