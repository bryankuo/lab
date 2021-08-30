#!/bin/bash
if [ "$#" -ne 2 ]; then
    echo "activities.sh [type] [task]"
fi
# only 2 and 4 applies, 5 TBD
TIMESTAMP=`date '+%Y/%m/%d %H:%M:%S'`
echo "time: " $TIMESTAMP
echo "scrap " $1 $2
python3 looping.py $1 $2 2>&1 | tee > datafiles/activities_$1.txt
TIMESTAMP=`date '+%Y/%m/%d %H:%M:%S'`
echo "time: " $TIMESTAMP
echo "open..."
python3 launch.py datafiles/activities_$1.txt
echo "done..."
exit 0
