#!/bin/bash

# ./uno_rs.sh [yyyymmdd]
# add formula to ods
# \param in yyyymmdd as sheet identification
# return 0

if [ "$#" -lt 1 ]; then
    echo "usage: uno_rs.sh [yyyymmdd]"
    echo "       and let safari allow Remote Automation"
    exit 22 # @see https://stackoverflow.com/a/50405954
fi

DIR0="datafiles/taiex/rs"
mkdir -p $DIR0

# DATE=`date '+%Y%m%d'`
DATE=$1
# assume ror.20231001.ods, sheet name : 'ror.20231001'
INF0="$2"

OUTF0="$DIR0/rs.$DATE.ods"
OUTF1="$DIR0/leading75.$DATE.csv"
OUTF2="$DIR0/pr34above75.$DATE.csv"

TIMESTAMP0=`date '+%Y/%m/%d %H:%M:%S'`

# RETURN=( $(/Applications/LibreOffice.app/Contents/Resources/python \
#    uno_formula.py $DATE | tr -d '[],' ) )
# echo "return: $RETURN"
# N_ROWS=${RETURN[0]}
# echo "#rows: "$N_ROWS

/Applications/LibreOffice.app/Contents/Resources/python \
    uno_formula.py $DATE

TIMESTAMP=`date '+%Y/%m/%d %H:%M:%S'`
echo "time: " $TIMESTAMP0 " looping start"
echo "time: " $TIMESTAMP  " looping end"

tput bel
read -p "Press enter to continue copying ..."
ls -lt datafiles/taiex/rs/*.$DATE.???

cp -v $OUTF0 $OUTF1 $OUTF2 ~/Dropbox/

exit 0
