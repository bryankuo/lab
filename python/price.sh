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
    exit 22 # @see https://stackoverflow.com/a/50405954
fi

CO_TYPE1=( $(grep -rnp --color="auto" -e $1 datafiles/listed_[245].txt | \
    cut -d "_" -f 2 | cut -d "." -f 1 ))
# echo "it's type "$CO_TYPE1
PRICE0=0
PRICE1=0
if [ $CO_TYPE1 -eq 2 ]; then
    OUTPUT=($(python3 price.py $1 $2 $3 | tr -d '[],'))
    # echo ${OUTPUT[@]}
    PRICE0=${OUTPUT[0]}
elif [ $CO_TYPE1 -eq 4 ]; then
    OUTPUT=($(python3 price_otc.py $1 $2 $3 | tr -d '[],'))
    # echo ${OUTPUT[@]}
    PRICE0=${OUTPUT[0]}
elif [ $CO_TYPE1 -eq 5 ]; then
    # echo "type 5"
    OUTPUT=($(python3 price_type5.py $1 $2 $3 | tr -d '[],'))
    # echo ${OUTPUT[@]}
    PRICE0=${OUTPUT[0]}
    PRICE1=${OUTPUT[1]}
else
    echo "it is not supported for type "$CO_TYPE1
fi
echo $PRICE0

exit 0
