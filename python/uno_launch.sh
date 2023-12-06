#!/bin/bash
# echo "$#"
if [ "$#" -lt 1 ]; then
    echo "usage: uno_lanuch.sh [files...]"
    exit 22 # @see https://stackoverflow.com/a/50405954
fi
# echo $1
# echo $2
# @see https://stackoverflow.com/a/255913
# @see https://unix.stackexchange.com/a/216475
#
for ods in "$@"
do
    # echo "$ods"
    /Applications/LibreOffice.app/Contents/MacOS/soffice --calc "$ods" \
    --accept="socket,host=localhost,port=2002;urp;StarOffice.ServiceManager" &
    sleep 1
done
exit 0
