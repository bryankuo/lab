#!/bin/bash

# // FIXME fetch ticker volume by specific date
# // named - volume.sh [ticker] [date] [transaction file]
# \param in ticker
# \param in date in yyyymmdd
# \param in transaction file down load from daily transaction (manual)
# \param out formatted file sorted by sequence, broker, price, buy, sell

DATE=`date '+%Y%m%d'`
TKR=$1
STAMP=$2
INF0=$3

# filename=$(basename -- "$INF0")
# extension="${filename##*.}"
# filename="${filename%.*}"
# echo $filename

OUTF0=datafiles/$TKR/$STAMP.txt

found2=$(grep -c -e $TICKER datafiles/listed_2.txt)
if [[ $found2 -eq 1 ]]; then
    echo "parsing type 2 transactions..."
    # ./transaction.sh 3008 20220505 datafiles/3008/bsContent_20220505.html
    python3 transaction.py $TKR $STAMP $INF0
    # echo "launch calc..."
    # python3 launch.py $OUTF0
    echo "done."
    exit 0
fi

found4=$(grep -c -e $TICKER datafiles/listed_4.txt)
if [[ $found4 -eq 1 ]]; then
    echo "parsing type 4 transactions..."
    # ./transaction.sh 6182 20220506 datafiles/6182/6182_1110506.CSV
    python3 transotc.py $TKR $STAMP $INF0
    # echo "launch calc..."
    # python3 launch.py $OUTF0
    echo "done."
    exit 0
fi

echo "type not support"

exit 0
