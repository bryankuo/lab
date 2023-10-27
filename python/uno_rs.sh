#!/bin/bash

# ./uno_rs.sh [yyyymmdd]
# add formula to ods
# \param in yyyymmdd as sheet identification
# return 0

DIR0="datafiles/taiex/rs"
# DIR0="."
mkdir -p $DIR0

# DATE=`date '+%Y%m%d'`
DATE=$1
# assume ror.20231001.ods, sheet name : 'ror.20231001'
INF0="$2"

TIMESTAMP0=`date '+%Y/%m/%d %H:%M:%S'`

RETURN=( $(/Applications/LibreOffice.app/Contents/Resources/python \
    uno_formula.py $DATE | tr -d '[],' ) )
N_ROWS=${RETURN[0]%\'}
N_ROWS=${N_ROWS#\'}
echo "#rows: "$N_ROWS

TIMESTAMP=`date '+%Y/%m/%d %H:%M:%S'`
echo "time: " $TIMESTAMP0 " looping start"
echo "time: " $TIMESTAMP  " looping end"

exit 0
