#!/bin/bash

# ./compare_volume.sh [today] [last day]
#
# a wrapper of compare_volume.py
#
# \param in dt1 today, yyyymmdd
# \param in dt2 last day, yyyymmdd

# echo $#
if [ "$#" -lt 2 ]; then
    echo "usage: ./compare_volume.sh [today] [last day], date in yyyymmdd"
    exit 22 # @see https://stackoverflow.com/a/50405954
fi

DIR0="./datafiles/taiex/after.market"

# python3 --version
# 3.9.2
# ModuleNotFoundError: No module named 'uno'

python3 compare_volume.py $1 $2

ls -lt "$DIR0/$1.vr.csv"

# /Applications/LibreOffice.app/Contents/MacOS/soffice --version

# @see https://tinyurl.com/2v8m5e33
# Use the Python interpreter that is shipped with the Office suite.

# @see https://tinyurl.com/3e5j999v
# Interface-oriented programming in OpenOffice / LibreOffice

# cp -v "$DIR0/$1.vr.csv" ~/Dropbox/昨量比.$1.csv
# // TODO: 隔日沖券商檢驗

# cut -d ":" -f1 datafiles/taiex/after.market/20231129.csv > datafiles/taiex/after.market/20231129.lst.csv
# cut -d ":" -f1 datafiles/taiex/after.market/20231128.csv > datafiles/taiex/after.market/20231128.lst.csv
# ls -lt datafiles/taiex/after.market/????????.lst.csv
# left only
# comm -13 20231128.lst.csv 20231129.lst.csv
# comm -12 20231128.lst.csv 20231129.lst.csv

# rm -f datafiles/taiex/after.market/????????.lst.csv
# # rm -f 20231128.lst.csv 20231129.lst.csv
exit 0
