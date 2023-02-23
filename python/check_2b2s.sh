#!/bin/bash

LAST_TRADE_DAY=$1
DATE=$2

DIR0="datafiles/taiex/qfbs"

# @see https://stackoverflow.com/a/26619069
echo "new buy...";
comm -13 $DIR0"/"2b.$LAST_TRADE_DAY.txt $DIR0"/"2b.$DATE.txt
echo

echo "buy 2 days...";
comm -12 $DIR0"/"2b.$LAST_TRADE_DAY.txt $DIR0"/"2b.$DATE.txt
echo

echo "new sell...";
comm -13 $DIR0"/"2s.$LAST_TRADE_DAY.txt $DIR0"/"2s.$DATE.txt
echo

echo "sell 2 days...";
comm -12 $DIR0"/"2s.$LAST_TRADE_DAY.txt $DIR0"/"2s.$DATE.txt

exit 0
