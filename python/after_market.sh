#!/bin/bash

# ./after_market.sh [yyyymmdd]
#
# a wrapper of after_market.py
#
# \param in yyyymmdd

if [ "$#" -lt 1 ]; then
#    echo "usage: ./after_market.sh [yyyymmdd]"
#    exit 22 # @see https://stackoverflow.com/a/50405954
    DATE=$(date +%Y%m%d)
else
    DATE=$1
fi

DIR0="$HOME/github/python/datafiles/taiex/after.market"
# instead of xcode command line
PATH="/Library/Frameworks/Python.framework/Versions/3.9/bin:${PATH}"
export PATH

python3 $HOME/github/python/after_market.py $DATE 0
python3 $HOME/github/python/after_market.py $DATE 1
# count how many trade days for this month
#ls -lt datafiles/taiex/after.market/202403??.all.columns.csv | wc -l

currenttime=$(date +%H:%M)
TIME=${currenttime:0:2}${currenttime:3:2}
/bin/cp "$DIR0/$DATE.all.columns.csv" "$DIR0/$DATE.$TIME.all.columns.csv"

# echo "sorting..."
# html sort by price descending
# @see https://stackoverflow.com/a/26249359
/usr/bin/sort -k1 -n -t: -o "$DIR0/$DATE.csv" "$DIR0/$DATE.price.desc.csv"
# grep -rnp --color="auto" -e "6669" ./datafiles/taiex/after.market/????????.csv
# wc -l  "$DIR0/$DATE.csv"

# twse market is closed, including type 5
if [[ "$currenttime" > "13:30" ]]; then
    # 1.
    ls -lt $DIR0/????????.csv | head -n 3
    N_DAYS=$( ls -lt $DIR0/????????.csv | wc -l | xargs | cut -d " " -f1 )
    echo "there are $N_DAYS trade days recorded."

    # 2. count # of up, down, ratio
    N_TICKERS=$( cat "$DIR0/$DATE.all.columns.csv" | cut -d ":" -f 5 \
	| wc -l | xargs )
    N_TICKERS=$((N_TICKERS-1))
    N_UP=$( cat "$DIR0/$DATE.all.columns.csv" | cut -d ":" -f 5 \
	| grep -e "+" | wc -l | xargs )
    N_DOWN=$((N_TICKERS-N_UP))
    UD_RATIO=$( echo $N_UP / $N_DOWN | bc -l )
    MSG=$( printf "%s # ticker %d, up %d, down %d, ratio %0.3f" \
	$DATE $N_TICKERS $N_UP $N_DOWN $UD_RATIO )
    echo $MSG
    # cat "$DIR0/$DATE.all.columns.csv" | cut -d ":" -f 5 | head -n 10

    # 3. for each ticker, count # of days before its previous high

    # 4. list 10 day low

    # 5. list # of limit up, and # of limit down
    # cat "$DIR0/$DATE.all.columns.csv" | cut -d ":" -f 3,5,9,10
    python3 count_n_luld.py $DATE
fi

exit 0
