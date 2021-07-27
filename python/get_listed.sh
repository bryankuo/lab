#!/bin/bash

declare -a arr=(2 4 5)
echo "get all the tickers..."
n_ticker=0;
for mode in "${arr[@]}"
do
    count=$(python3 get_listed.py $mode)
    # echo $count
    n_ticker=$(( $count + $n_ticker ))
done
echo $n_ticker "in total."
exit 0
