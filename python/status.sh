#!/bin/bash
if [ "$#" -ne 1 ]; then
    echo "status.sh [type]"
    exit 0
fi
# only 2 and 4 applies, 5 TBD
TIMESTAMP=`date '+%Y/%m/%d %H:%M:%S'`
DATE=`date '+%Y%m%d'`
OUTF0=datafiles/activity_$1_$DATE.txt
OUTF1=datafiles/range52w_$1_$DATE.txt
OUTF2=datafiles/per_$1_$DATE.txt
echo "time: " $TIMESTAMP
echo "status of type " $1
python3 looping.py $1 activity 2>&1 | tee > $OUTF0
python3 looping.py $1 range52w 2>&1 | tee > $OUTF1
python3 looping.py $1 per 2>&1 | tee > $OUTF2
TIMESTAMP=`date '+%Y/%m/%d %H:%M:%S'`
echo "time: " $TIMESTAMP
# combine
# echo "open..."
# python3 launch.py $OUTF
# echo "done..."
exit 0
