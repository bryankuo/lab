#!/bin/bash

LAST_TRADE_DAY=$1
DATE=$2

DIR0="datafiles/taiex/qfbs"

# @see https://stackoverflow.com/a/26619069
N_NEW_BUY=$(comm -13 $DIR0"/"2b.$LAST_TRADE_DAY.txt $DIR0"/"2b.$DATE.txt \
    | tee $DIR0"/"newb.$DATE.txt | wc -l | cut -f7 -d' ' )
echo "new buy........ "$N_NEW_BUY

N_CON2BUY=$(comm -12 $DIR0"/"2b.$LAST_TRADE_DAY.txt $DIR0"/"2b.$DATE.txt \
    | tee $DIR0"/"cn2b.$DATE.txt | wc -l | cut -f7 -d' ' )
echo "buy 2 days..... "$N_CON2BUY

N_NEW_SEL=$(comm -13 $DIR0"/"2s.$LAST_TRADE_DAY.txt $DIR0"/"2s.$DATE.txt \
    | tee $DIR0"/"news.$DATE.txt | wc -l | cut -f7 -d' ' )
echo "new sell....... "$N_NEW_SEL

N_CON2SEL=$(comm -12 $DIR0"/"2s.$LAST_TRADE_DAY.txt $DIR0"/"2s.$DATE.txt \
    | tee $DIR0"/"cn2s.$DATE.txt | wc -l | cut -f7 -d' ' )
echo "sell 2 days.... "$N_CON2BUY

# @see https://superuser.com/a/637330

gvim +1 $DIR0"/"newb.$DATE.txt \
    +"tabnew +1 $DIR0"/"cn2b.$DATE.txt" \
    +"tabnew +1 $DIR0"/"news.$DATE.txt" \
    +"tabnew +1 $DIR0"/"cn2s.$DATE.txt"

cp -v $N_CON2BUY $N_NEW_BUY $N_NEW_SEL $N_CON2SEL ~/Dropbox

exit 0
