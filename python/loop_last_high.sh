#!/bin/bash

# ./loop_last_high.sh
# serving count_ndays_last_high.sh, looper once
#
# loop counting # of (trade) days to get new high
#
# \param in $DIR2/????????.all.columns.csv, on daily bases

DIR0="."
DIR2="$DIR0/datafiles/taiex/after.market"
DIR1="$DIR0/uno/unload"
DIR3="$DIR0/datafiles"
DIR4="/Applications/LibreOffice.app/Contents/Resources"

# ./uno_launch.sh "$DIR3/activity_watchlist.ods"
# read -p "Touch calc then press enter to continue..."
# echo -ne '\007'

# @see https://superuser.com/a/423086
effective=$( ls -lt $DIR2/????????.all.columns.csv \
    | cut -d '/' -f 5 | cut -c 1-8 | sort | xargs )

# @see https://stackoverflow.com/a/10586169
IFS=', ' read -r -a array <<< $effective

# echo "${array[2]}"
# echo ${#array[@]}

# @see https://stackoverflow.com/a/21256739
for (( i=0; i<${#array[@]} ; i+=1 )) ; do
    if [ ${#array[i+1]} -ne 0 ]
    then
	# echo "${array[i]}" "${array[i+1]}"
	d1="${array[i+1]}"
	d0="${array[i]}"
	echo "$(date +"%T") loop_last_high.sh+ $d1 $d0"
	python3 $DIR1/slice_last_high.py $d1 $d0
	$DIR4/python "$HOME/github/python/uno/load/addsheet.py" $d1
    fi
done

exit 0
