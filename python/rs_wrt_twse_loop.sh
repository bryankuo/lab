#!/bin/bash

# ./rs_wrt_twse_loop.sh
#
# a looper of rs_wrt_twse.sh
#

DIR0="./datafiles/taiex/after.market"
DIR0r="./datafiles/taiex/rs"

FILES=$( find $DIR0 -type f -iname '????????.html' | xargs )

for f in $FILES;
do
    # echo $f
    DATE=${f:31:8}
    ./rs_wrt_twse.sh $DATE
done

ls -lt ./datafiles/taiex/rs/*rs.desc*

exit 0
