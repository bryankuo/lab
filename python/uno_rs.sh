#!/bin/bash

# ./uno_rs.sh []
# add formula to ods
# \param in
# return 0

DIR0="datafiles/taiex/rs"
# DIR0="."
mkdir -p $DIR0

DATE=`date '+%Y%m%d'`
# assume ror.20231001.ods, sheet name : 'ror.20231001'
INF0="$1"

RETURN=( $(/Applications/LibreOffice.app/Contents/Resources/python \
    uno_formula.py $DATE | tr -d '[],' ) )
N_ROWS=${RETURN[0]%\'}
N_ROWS=${N_ROWS#\'}
echo "#rows: "$N_ROWS

exit 0
