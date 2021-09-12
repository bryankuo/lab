#!/bin/bash
if [ "$#" -ne 2 ]; then
    echo "per.sh [type] [task]"
    exit 0
fi
# only 2 and 4 applies, 5 TBD
TIMESTAMP=`date '+%Y/%m/%d %H:%M:%S'`
DATE=`date '+%Y%m%d'`
OUTF=datafiles/range52w_$1_$DATE.txt
echo "time: " $TIMESTAMP
echo "scrap " $1 $2
python3 looping.py $1 $2 2>&1 | tee > $OUTF
TIMESTAMP=`date '+%Y/%m/%d %H:%M:%S'`
echo "time: " $TIMESTAMP
echo "open..."
python3 launch.py $OUTF
echo "done..."
exit 0
