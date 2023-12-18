#!/bin/bash

# ./gini_tkrbranch.sh [tkr]
#
# a wrapper of fetch_tkrbranch.py
#
# \param in tkr

if [ "$#" -lt 1 ]; then
    echo "usage: ./gini_tkrbranch.sh [tkr]"
    exit 22
fi

TKR=$1
DIR0="./datafiles/taiex/branch"

python3 fetch_tkrbranch.py $TKR 0

python3 fetch_tkrbranch.py $TKR 1

exit 0

# grep -rnp --color="auto" -e "3073" gini.*.csv
