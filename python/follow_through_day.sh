#!/bin/bash

if [ "$#" -lt 1 ]; then
    echo "./follow_through_day.sh [ticker]"
    exit 64
fi

echo "check if $1 follow through day ..."

DIR0="./datafiles/taiex/after.market"
FILES="[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9].csv"
# grep -rp --color="auto" -e "^$1" $DIR0 \
#    | sort | cut -d ":" -f 1,2,3
OUTF0="$1.txt"
OUTF1="a.txt"

find $DIR0 -type f -iname $FILES \
    | sort | xargs grep -rp --color="auto" -e "^$1" \
    | cut -d':' -f 1,3 > $OUTF1

cut -c 32-39 -c 44- $OUTF1 > $OUTF0

trash $OUTF1

echo $OUTF0

exit 0
