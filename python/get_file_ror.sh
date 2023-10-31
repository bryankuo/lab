#!/bin/bash

# ./get_file_ror.sh
# loop specific file in directory and scraping ror,
# then generate rs into csv for calc.
# \param out OUTF0 ror.YYYYMMDD.csv
# \param out  rs.YYYYMMDD.csv
# return

clear

DIR0="datafiles/taiex/rs" # including twse
# TKRS="$DIR0/ror.????.html"
TKRS="$DIR0/ror.[0-9][0-9][0-9][0-9].html" # https://stackoverflow.com/a/19864389
TWSE="$DIR0/ror.twse.html"
index=1
count=0
TIMESTAMP0=`date '+%Y/%m/%d %H:%M:%S'`

DATE=`date '+%Y%m%d'`
OUTF0="$DIR0/ror.$DATE.csv"
OUTF1="$DIR0/rs.$DATE.csv"

echo "ticker:name:1d:1w:1m:2m:3m:6m:1y:ytd:3y" > $OUTF1
OUTPUT=($(python3 get_twse_ror.py | tr -d '[],'))
# OUTPUT=''
# echo ${#BENCHMARK[@]}
# echo ${#OUTPUT}
# echo ${OUTPUT[@]}
if [ ${#OUTPUT} -le 0 ]; then
    echo "error get benchmark"
    exit 0
fi

# @see https://stackoverflow.com/a/20796617
# ls -tUr datafiles/taiex/rs/ror.[0-9][0-9][0-9][0-9].html
for filename in `ls -tUr $TKRS`; do
    MSG=$(printf "%04d %s" $index $filename)
    echo $MSG
    arrIN=(${filename//./ }) # https://stackoverflow.com/a/5257398
    TICKER=${arrIN[1]}
    python3 get_ticker_ror.py $TICKER ${OUTPUT[@]}
    index=$(($index+1))
    count=$(($count+1))
done
echo "done, $count"
TIMESTAMP=`date '+%Y/%m/%d %H:%M:%S'`
echo "time: " $TIMESTAMP0 " looping start"
echo "time: " $TIMESTAMP  " looping end"

ls -lt $OUTF1; wc -l $OUTF1;
exit 0
