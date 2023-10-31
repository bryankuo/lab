#!/bin/bash
TIMESTAMP0=`date '+%Y/%m/%d %H:%M:%S'`
# rm -f datafiles/listed_taiex.txt
unlink datafiles/listed_taiex.txt
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
ln -sf datafiles/listed_taiex.$DATE.txt datafiles/listed_taiex.txt
ls -lt datafiles/listed_*.txt
wc -l $(readlink datafiles/listed_taiex.txt)
TIMESTAMP1=`date '+%Y/%m/%d %H:%M:%S'`
echo "time: " $TIMESTAMP0 " looping start"
echo "time: " $TIMESTAMP1 " looping end"
echo -ne '\007'
exit 0
# // FIXME: use DIR0 instead
