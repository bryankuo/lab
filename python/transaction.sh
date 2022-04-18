#!/bin/bash


DATE=`date '+%Y%m%d'`
INF0=$1

filename=$(basename -- "$INF0")
extension="${filename##*.}"
filename="${filename%.*}"
echo $filename

OUTF0=datafiles/$filename.txt

echo "parsing transactions..."
python3 transaction.py $INF0 > $OUTF0

echo "launch calc..."
python3 launch.py $OUTF0

exit 0
