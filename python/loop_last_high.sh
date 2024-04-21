#!/bin/bash

# ./loop_last_high.sh
#
# loop counting # of (trade) days to get new high
#
# \param in $DIR2/????????.all.columns.csv, on daily bases

DIR0="."
DIR2="$DIR0/datafiles/taiex/after.market"
DIR1="$DIR0/uno/unload"
DIR3="$DIR0/datafiles"
DIR4="/Applications/LibreOffice.app/Contents/Resources"

# @see https://superuser.com/a/423086
effective=$( ls -lt $DIR2/????????.all.columns.csv \
    | cut -d '/' -f 5 | cut -c 1-8 | sort )

# @see https://stackoverflow.com/a/21256739
# for (( i=0; i<${#effective[@]} ; i+=2 )) ; do
#     echo "${effective[i]}" "${effective[i+1]}"
# done

while read -r d0 d1; do
    echo $d1 $d0
done < <(echo $effective | xargs -n2)

exit 0
