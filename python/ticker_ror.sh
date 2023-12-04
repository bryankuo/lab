#!/bin/bash

# ./ticker_ror.sh [ticker] [#weeks ago]
# call price.sh, figure out ror since X weeks ago.
# \param in ticker
# \param in X weeks
# \param out ror in percentage
# return ror in percentage
#

if [ "$#" -lt 2 ]; then
    echo "usage: ./ticker_ror.sh [ticker] [#weeks ago]"
    exit 22 # @see https://stackoverflow.com/a/50405954
fi
# TIMESTAMP0=`date '+%Y/%m/%d %H:%M:%S'`

YESTERDAY=$(date -v -1d +%Y%m%d)
XWEEKSAGO=$(date -v -$2w +%Y%m%d)

# echo "figure out $1 ror($2 weeks) from $XWEEKSAGO to $YESTERDAY..."

PRICE_0=$(./price.sh $1 $XWEEKSAGO 0)
# ./price.sh $1 $XWEEKSAGO 0
PRICE_1=$(./price.sh $1 $YESTERDAY 0)
# ./price.sh $1 $YESTERDAY 0

# @see https://stackoverflow.com/a/8402553
echo $( bc <<< "scale=4; ( ( $PRICE_1 - $PRICE_0 ) * 100 / $PRICE_0 )" )"%"

# TIMESTAMP=`date '+%Y/%m/%d %H:%M:%S'`
# echo "time: " $TIMESTAMP0 " start"
# echo "time: " $TIMESTAMP  " end"

exit 0
