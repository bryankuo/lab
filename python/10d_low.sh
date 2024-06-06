#!/bin/bash

# highlight 10 days low in a list

# last 10 days
DIR0="$HOME/github/python/datafiles/taiex/after.market"

LAST_10DAYS=$( ls -lt $DIR0/????????.csv | head -n 10 | cut -d '/' -f 9 | cut -d '.' -f 1 | xargs )

python3 ./load_trade_days.py $LAST_10DAYS
# echo $LAST_10DAYS

# output 10 days low

exit 0
