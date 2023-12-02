#!/bin/bash

LAST_TRADE_DAY=$1
DATE=$2

DIR0="datafiles/taiex/qfbs"

NAME037_4="外投同賣連2"
NAME037_5="外投同賣新增"
NAME037_6="外投同買新增"
NAME037_7="外投同買連2"

# @see https://stackoverflow.com/a/26619069
N_CON2SEL=$(comm -12 \
    "$DIR0/2s.$LAST_TRADE_DAY.txt" \
    "$DIR0/2s.$DATE.txt" \
    | tee "$DIR0/$NAME037_4.$DATE.txt" | wc -l | cut -f7 -d' ' )
echo "sell 2 days.... "$N_CON2BUY

N_NEW_SEL=$(comm -13 \
    "$DIR0/2s.$LAST_TRADE_DAY.txt" \
    "$DIR0/2s.$DATE.txt" \
    | tee "$DIR0/$NAME037_5.$DATE.txt" | wc -l | cut -f7 -d' ' )
echo "new sell....... "$N_NEW_SEL

N_NEW_BUY=$(comm -13 \
    "$DIR0/2b.$LAST_TRADE_DAY.txt" \
    "$DIR0/2b.$DATE.txt" \
    | tee "$DIR0/$NAME037_6.$DATE.txt" | wc -l | cut -f7 -d' ' )
echo "new buy........ "$N_NEW_BUY

N_CON2BUY=$(comm -12 \
    "$DIR0/2b.$LAST_TRADE_DAY.txt" \
    "$DIR0/2b.$DATE.txt" \
    | tee "$DIR0/$NAME037_7.$DATE.txt" | wc -l | cut -f7 -d' ' )
echo "buy 2 days..... "$N_CON2BUY

# @see https://superuser.com/a/637330
gvim +1 "$DIR0/$NAME037_4.$DATE.txt" \
    +"tabnew +1 $DIR0/$NAME037_5.$DATE.txt" \
    +"tabnew +1 $DIR0/$NAME037_6.$DATE.txt" \
    +"tabnew +1 $DIR0/$NAME037_7.$DATE.txt"

cp -v "$DIR0/$NAME037_4.$DATE.txt" \
    "$DIR0/$NAME037_5.$DATE.txt" \
    "$DIR0/$NAME037_6.$DATE.txt" \
    "$DIR0/$NAME037_7.$DATE.txt" ~/Dropbox

# trash -v "$DIR0/$NAME037_4.$DATE.txt"
# trash -v "$DIR0/$NAME037_5.$DATE.txt"
# trash -v "$DIR0/$NAME037_6.$DATE.txt"
# trash -v "$DIR0/$NAME037_7.$DATE.txt"

exit 0
