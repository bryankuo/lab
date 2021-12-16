#!/bin/bash
TIMESTAMP=`date '+%Y/%m/%d %H:%M:%S'`
DATE=`date '+%Y%m%d'`
INFILE=watchlist.txt
INPATH=datafiles/$INFILE
OUTF0=datafiles/activity_$INFILE.$DATE
OUTF1=datafiles/range52w_$INFILE.$DATE
OUTF2=datafiles/per_$INFILE.$DATE
OUTF3=datafiles/eps_$INFILE.$DATE

echo "time: " $TIMESTAMP

DAILY=1
if [[ $DAILY -eq 1 ]]
then
    python3 looping.py $INPATH "activity" $OUTF0
    python3 looping.py $INPATH "range52w" $OUTF1
    python3 looping.py $INPATH per $OUTF2
    cd datafiles
    ln -sf activity_$INFILE.$DATE activity_$INFILE
    ln -sf range52w_$INFILE.$DATE range52w_$INFILE
    ln -sf per_$INFILE.$DATE per_$INFILE
    cd ..
    # combine
    echo "open..."
    python3 launch.py $OUTF0
    python3 launch.py $OUTF1
    python3 launch.py $OUTF2
fi

EPS=0
if [[ $EPS -eq 1 ]]
then
    echo "make sure safari dev. remote automation is on..."
    python3 looping.py $INPATH eps $OUTF3
    python3 launch.py $OUTF3
    ln -sf eps_$INFILE.$DATE eps_$INFILE
fi

TIMESTAMP=`date '+%Y/%m/%d %H:%M:%S'`
echo "time: " $TIMESTAMP
echo "done."
exit 0
