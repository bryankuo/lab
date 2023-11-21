#!/bin/bash

# ./uno_bquote.sh [yyyymmdd]
<<<<<<< HEAD
# a wrapper
# \param in yyyymmdd
#

if [ "$#" -lt 1 ]; then
    echo "usage: ./uno_bquote.py [yyyymmdd]"
    exit 22 # @see https://stackoverflow.com/a/50405954
fi

/Applications/LibreOffice.app/Contents/Resources/python uno_bquote.py $1
=======

RETURN=( $(/Applications/LibreOffice.app/Contents/Resources/python \
    uno_bquote.py $1 | tr -d '[],' ) )
>>>>>>> 1f92f29 (revise)

exit 0
