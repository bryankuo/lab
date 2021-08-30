#!/bin/bash
if [ "$#" -ne 2 ]; then
    echo "activities.sh [type] [task]"
fi
echo "scrap " $1 $2
python3 looping.py $1 $2 2>&1 | tee > datafiles/activities_$1.txt
echo "open..."
python3 launch.py datafiles/activities_$1.txt
echo "done..."
exit 0
