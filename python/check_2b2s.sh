#!/bin/bash


if [ "$#" -lt 2 ]; then
    echo "usage: ./check_2b2s.sh [yyyymmdd] [last trade day]"
    exit 22
fi

DATE=$1
LAST_TRADE_DAY=$2

DIR0="datafiles/taiex/qfbs"

NAME037_1="外投同買列表"
NAME037_2="外投同賣列表"

NAME037_7="外投同賣連2"
NAME037_8="外投同賣新增"
NAME037_9="外投同買新增"
NAME037_10="外投同買連2"

# @see https://stackoverflow.com/a/26619069
N_CON2SEL=$(comm -12 \
    "$DIR0/$NAME037_2.$LAST_TRADE_DAY.txt" \
    "$DIR0/$NAME037_2.$DATE.txt" \
    | tee "$DIR0/$NAME037_7.$DATE.txt" | wc -l | cut -f7 -d' ' )
echo "$NAME037_7..... $N_CON2SEL"

N_NEW_SEL=$(comm -13 \
    "$DIR0/$NAME037_2.$LAST_TRADE_DAY.txt" \
    "$DIR0/$NAME037_2.$DATE.txt" \
    | tee "$DIR0/$NAME037_8.$DATE.txt" | wc -l | cut -f7 -d' ' )
echo "$NAME037_8.... $N_NEW_SEL"

N_NEW_BUY=$(comm -13 \
    "$DIR0/$NAME037_1.$LAST_TRADE_DAY.txt" \
    "$DIR0/$NAME037_1.$DATE.txt" \
    | tee "$DIR0/$NAME037_9.$DATE.txt" | wc -l | cut -f7 -d' ' )
echo "$NAME037_9.... $N_NEW_BUY"

N_CON2BUY=$(comm -12 \
    "$DIR0/$NAME037_1.$LAST_TRADE_DAY.txt" \
    "$DIR0/$NAME037_1.$DATE.txt" \
    | tee "$DIR0/$NAME037_10.$DATE.txt" | wc -l | cut -f7 -d' ' )
echo "$NAME037_10.... $N_CON2BUY"

# @see https://superuser.com/a/637330
gvim +1 "$DIR0/$NAME037_7.$DATE.txt" \
    +"tabnew +1 $DIR0/$NAME037_8.$DATE.txt" \
    +"tabnew +1 $DIR0/$NAME037_9.$DATE.txt" \
    +"tabnew +1 $DIR0/$NAME037_10.$DATE.txt"

# cp -v "$DIR0/$NAME037_7.$DATE.txt" \
#    "$DIR0/$NAME037_8.$DATE.txt" \
#    "$DIR0/$NAME037_9.$DATE.txt" \
#    "$DIR0/$NAME037_10.$DATE.txt" ~/Dropbox

exit 0
