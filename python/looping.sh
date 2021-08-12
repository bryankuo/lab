#!/bin/bash
if [ $1 -ne 2 ] && [ $1 -ne 4 ] && [ $1 -ne 5 ]
then
    echo "illegal mode "$1
    exit -1
fi

mode=$1
echo "looping listed companies "$mode
i=0;
f=datafiles/listed_$mode.txt
lines=`wc -l $f | cut -f6 -d' '`
while read p; do
    i=$((i + 1));
    # // TODO: do something here
    # python3 gpm.py $competitor
    chips=`python3 activity.py $p`
    secs=`jot -r 1 2 7`
    printf "%04d of %d: %s %s %s\n" $i $lines $p $secs
    echo $chips
    # sleep $secs
done < "$f"
exit 0
