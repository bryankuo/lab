#!/bin/bash

# ./uno_bquote.sh [yyyymmdd]
# a wrapper
# \param in yyyymmdd
#

if [ "$#" -lt 1 ]; then
    echo "usage: ./uno_bquote.py [yyyymmdd]"
    exit 22 # @see https://stackoverflow.com/a/50405954
fi

if false; then
    # no output
    RETURN=( $(/Applications/LibreOffice.app/Contents/Resources/python \
	uno_bquote.py $1 | tr -d '[],' ) )
fi

/Applications/LibreOffice.app/Contents/Resources/python uno_bquote.py $1

# echo $RETURN

exit 0
