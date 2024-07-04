#!/bin/bash

# highlight N days low in a list

# last N days
DIR0="$HOME/github/python/datafiles/taiex/after.market"

LAST_N_DAYS=$( ls -lt $DIR0/????????.csv | head -n $1 \
    | cut -d '/' -f 9 | cut -d '.' -f 1 | xargs )

python3 ./load_trade_days.py $LAST_N_DAYS

exit 0
