#!/bin/bash

# ./uno_vratio.sh [today] [last day]
#
# a wrapper of compare_volume.py
#
# \param in dt1 today, yyyymmdd
# \param in dt2 last day, yyyymmdd

if [ "$#" -lt 2 ]; then
    echo "usage: ./uno_vratio.sh [today] [last day], date in yyyymmdd"
    exit 22 # @see https://stackoverflow.com/a/50405954
fi

DIR0="./datafiles/taiex/after.market"

# /Applications/LibreOffice.app/Contents/Resources/python --version
# 3.8.10
# ModuleNotFoundError: No module named 'pandas'

/Applications/LibreOffice.app/Contents/Resources/python \
    uno_vratio.py $1 $2

# /Applications/LibreOffice.app/Contents/MacOS/soffice --version

# @see https://tinyurl.com/2v8m5e33
# Use the Python interpreter that is shipped with the Office suite.

# @see https://tinyurl.com/3e5j999v
# Interface-oriented programming in OpenOffice / LibreOffice

# pyoo
# @see https://pypi.org/project/pyoo/

# unoconv?
# https://docs.moodle.org/403/en/Universal_Office_Converter_(unoconv)

exit 0
