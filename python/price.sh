#!/bin/bash

# price.sh [ticker] [yyyymmdd] [net|file]
# a wrapper fetching close price by ticker, date, from internet or file.
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
    THE_DATE=$(date -j -v -1d -f "%Y%m%d" "$2" '+%Y%m%d')
elif [[ $(date -j -v -0d -f "%Y%m%d" "$2" +%u) -eq 7 ]]; then # Sunday
    THE_DATE=$(date -j -v -2d -f "%Y%m%d" "$2" '+%Y%m%d')
fi

CO_TYPE1=( $(grep -rnp --color="auto" -e $1 datafiles/listed_[245].txt | \
    cut -d "_" -f 2 | cut -d "." -f 1 ))
# echo "it's type "$CO_TYPE1

PRICE0=0
PRICE1=0

fetch_price_by_date() {
    # echo $1
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
	PRICE1=${OUTPUT[1]}
    else
	echo "it is not supported for type "$CO_TYPE1
    fi
}

fetch_price_by_date "$THE_DATE" # @see https://stackoverflow.com/a/6212408
if [ "$PRICE0" == 0 ]; then
    # echo "check if the market is open on $THE_DATE"
    # holiday? verify last trade day by query TWSE exchange data (ex. volume)
    LAST_TRADE_DAY=0
    # src: https://www.twse.com.tw/pcversion/zh/page/trading/exchange/FMTQIK.html
    # python is_twse_open [yyyymmdd] return 0 success else return last open yyyymmdd
    OUTPUT=($(python3 is_twse_open.py $THE_DATE | tr -d "[],'"))
    if [ "${OUTPUT[0]}" == 0 ]; then
	sleep 1
    else
	LAST_TRADE_DAY=${OUTPUT[0]}
	fetch_price_by_date "$LAST_TRADE_DAY"
    fi
fi

echo $PRICE0

exit 0
