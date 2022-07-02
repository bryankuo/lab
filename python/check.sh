#!/bin/bash

TKR=$1
num_line=$( grep -rnp --color="auto" datafiles/listed_[245].txt \
    datafiles/watchlist.txt -e "$TKR" | wc -l )
echo $num_line
if [[ $num_line -eq 1 ]]; then
    echo $TKR >> datafiles/watchlist.txt
    echo "add $TKR to watchlist"
fi
exit 0
