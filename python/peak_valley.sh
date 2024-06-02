#!/bin/bash

# ./peak_valley.sh [ticker]

echo "gathering..."
# ./ndays_2new_high.sh $1 2>&1 | tee ./$1.csv
./ndays_2new_high.sh $1 > ./$1.csv

echo "find peaks and valleys from ..."
python3 peak_valley.py $1 2>&1 | tee ./pv.$1.txt
echo "done."

exit 0
