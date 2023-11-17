#!/bin/bash

# price.sh [ticker] [yyyymmdd] [net|file]
# a wrapper fetching close price by ticker, date, from internet or file.
# // TODO: if today, using quote.py instead

# call is_twse_open.py to tell market open day.
# \param in ticker
# \param in yyyymmdd
# \param in 0 net 1 file
# \param out price
#
if [ "$#" -lt 3 ]; then
    echo "usage: ./price.sh [ticker] [yyyymmdd] [net|file]"
    echo "fetch the close price of last trade date"
    exit 22 # @see https://stackoverflow.com/a/50405954
fi
TICKER=$1
THE_DATE=$2
NET=$3
# if sunday saturday holiday, use last close ( in general, Friday )
if [[ $(date -j -v -0d -f "%Y%m%d" "$2" +%u) -eq 6 ]]; then   # Saturday
    # echo "today is "$(date +%A)
    THE_DATE=$(date -j -v -1d -f "%Y%m%d" "$2" '+%Y%m%d')
elif [[ $(date -j -v -0d -f "%Y%m%d" "$2" +%u) -eq 7 ]]; then # Sunday
    # echo "today is "$(date +%A)
    THE_DATE=$(date -j -v -2d -f "%Y%m%d" "$2" '+%Y%m%d')
fi

CO_TYPE1=( $(grep -rnp --color="auto" -e $1 datafiles/listed_[245].txt | \
    cut -d "_" -f 2 | cut -d "." -f 1 ))
# echo "it's type "$CO_TYPE1

PRICE0=0
PRICE1=0

fetch_price_by_date() {
    # echo "get $1 price..."
    if [ $CO_TYPE1 -eq 2 ]; then
	OUTPUT=($(python3 price.py $TICKER $1 $NET | tr -d '[],'))
	# echo ${OUTPUT[@]}
	PRICE0=${OUTPUT[0]}
    elif [ $CO_TYPE1 -eq 4 ]; then
	OUTPUT=($(python3 price_otc.py $TICKER $1 $NET | tr -d '[],'))
	PRICE0=${OUTPUT[0]}
    elif [ $CO_TYPE1 -eq 5 ]; then
	# echo "type 5" // FIXME:
	OUTPUT=($(python3 price_type5.py $TICKER $1 $NET | tr -d '[],'))
	PRICE0=${OUTPUT[0]}
	PRICE1=${OUTPUT[1]} # block trade price
    else
	echo "it is not supported for type "$CO_TYPE1
    fi
}

LAST_TRADE_DAY=0
# src: https://www.twse.com.tw/pcversion/zh/page/trading/exchange/FMTQIK.html
# python is_twse_open [yyyymmdd] return 0 success else return last open yyyymmdd

# 1. search in the preserved files
# grep --color="auto" -c -e 20230928 datafiles/taiex/trade.days.202309.txt
FOUND=$(grep --color="auto" -c -e $THE_DATE \
    datafiles/taiex/trade.days.${THE_DATE:0:6}.txt)

if [ $FOUND -eq 0 ]; then
    # cal ${THE_DATE:4:2} ${THE_DATE:0:4}
    # 2. last_trade_day.py generate preserved trade.days files
    # OUTPUT=($(python3 is_twse_open.py $THE_DATE | tr -d "[],'"))
    OUTPUT=($(python3 last_trade_day.py $THE_DATE | tr -d "[],'"))
    LAST_TRADE_DAY=${OUTPUT[0]}
    fetch_price_by_date "$LAST_TRADE_DAY"
else
    # @see https://stackoverflow.com/a/6212408
    fetch_price_by_date "$THE_DATE"
fi

echo $PRICE0

exit 0
