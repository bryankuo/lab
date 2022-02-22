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
cat datafiles/listed_2.txt >  datafiles/listed_taiex.txt
cat datafiles/listed_4.txt >> datafiles/listed_taiex.txt
cat datafiles/listed_5.txt >> datafiles/listed_taiex.txt
DATE=`date '+%Y%m%d'`
mv datafiles/listed_taiex.txt datafiles/listed_taiex.$DATE.txt
rm -f datafiles/listed_taiex.txt
ln -s datafiles/listed_taiex.$DATE.txt datafiles/listed_taiex.txt
ls -lt datafiles/listed_*.txt
exit 0
