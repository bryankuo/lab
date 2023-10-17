#!/bin/bash

# ./ticker_ror.sh [ticker] [#weeks ago]
# call price.sh, figure out ror since X weeks ago.
# \param in ticker
# \param in X weeks
# \param out ror in percentage
#
# price.sh [ticker] [yyyymmdd] [net|file]
#
# return ror in percentage
if [ "$#" -lt 2 ]; then
    echo "usage: ./ticker_ror.sh [ticker] [#weeks ago]"
    exit 22 # @see https://stackoverflow.com/a/50405954
fi

#TIMESTAMP0=`date '+%Y/%m/%d %H:%M:%S'`

YESTERDAY=$(date -v -1d +%Y%m%d)
XWEEKSAGO=$(date -v -$2w +%Y%m%d)

echo "figure out $1 ror($2 weeks) from $XWEEKSAGO to $YESTERDAY..."

PRICE_0=$(./price.sh $1 $XWEEKSAGO 0)
PRICE_1=$(./price.sh $1 $YESTERDAY 0)

# value="12.37%"
value="$PRICE_0 $PRICE_1"
echo "$value"

# TIMESTAMP=`date '+%Y/%m/%d %H:%M:%S'`
# echo "time: " $TIMESTAMP0 " start"
# echo "time: " $TIMESTAMP  " end"

exit 0
