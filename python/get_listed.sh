#!/bin/bash
TIMESTAMP0=`date '+%Y/%m/%d %H:%M:%S'`
DATE=`date '+%Y%m%d'`
DIR0="./datafiles"
# rm -f datafiles/listed_taiex.txt
unlink $DIR0/listed_taiex.txt
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
cat $DIR0/listed_2.txt >  $DIR0/listed_taiex.$DATE.txt
cat $DIR0/listed_4.txt >> $DIR0/listed_taiex.$DATE.txt
cat $DIR0/listed_5.txt >> $DIR0/listed_taiex.$DATE.txt
ln -sf $DIR0/listed_taiex.$DATE.txt $DIR0/listed_taiex.txt
ls -lt $DIR0/listed_*.txt
wc -l $(readlink "$DIR0/listed_taiex.txt")
TIMESTAMP1=`date '+%Y/%m/%d %H:%M:%S'`
echo "time: " $TIMESTAMP0 " looping start"
echo "time: " $TIMESTAMP1 " looping end"
echo -ne '\007'
exit 0
# to shuffle call update_watchlist.sh
