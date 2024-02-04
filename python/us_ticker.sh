#!/bin/bash

if [ "$#" -lt 1 ]; then
    echo "usage: ./us_ticker.sh [tkr]"
    exit 22
fi

python3 us_ticker_institutional_holding.py $1

python3 us_ticker_float.py $1

exit 0
