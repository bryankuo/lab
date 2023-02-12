#!/bin/bash

# @see uno_stalk_story.sh
# handle 4 cvs from qfii.py

if [ "$#" -lt 4 ]; then
    echo "usage: qfbs.sh yyyy mm dd [net|file]"
    exit 22 # @see https://stackoverflow.com/a/50405954
fi

YR=$1
MN=$2
DAY=$3
ORIGIN=$4

DATE=$YR$MN$DAY
# @see https://stackoverflow.com/a/46024878
if [[ $(date -j -f '%Y%m%d' "$DATE" +'%u') -gt 5 ]]; then
    echo "it is $(date -j -f '%Y%m%d' "$DATE" +'%A')"
    cal $MN $YR
    exit 22
fi

clear

DIR0="datafiles/taiex/qfbs"
mkdir -p $DIR0

OUTFL1="$DIR0/list1.$DATE.txt"
OUTFL1b="$DIR0/list1b.$DATE.txt"
OUTFL1s="$DIR0/list1s.$DATE.txt"
OUTFL2="$DIR0/list2.$DATE.txt"
OUTFL2b="$DIR0/list2b.$DATE.txt"
OUTFL2s="$DIR0/list2s.$DATE.txt"
NAME="外資投信同步買賣超"
OUTF0="$DIR0/$NAME.$DATE.txt"
OUTF1="$DIR0/$NAME.$DATE.ods"

if [ $ORIGIN -eq 0 ]; then
    rm -vf "$DIR0/qfii.$DATE.html"
    rm -vf "$DIR0/fund.$DATE.html"
fi

rm -vf $OUTF0 $OUTF1

# python3 qfii.py $OUTF0
# python3 qfii.py $OUTF0 0 # // TODO: lazy and less parameter
python3 qfii.py $OUTF0 $ORIGIN $YR $MN $DAY

TIMESTAMP1=`date '+%Y/%m/%d %H:%M:%S'`

# @see https://superuser.com/a/246841
echo '代  號:名  稱:外資買超:外資賣超:投信買超:投信賣超:同步買超:同步賣超' | cat - $OUTF0 > temp && mv temp $OUTF0
python3 launch.py $OUTF0

# manual process here...

# generate 9 files
ls -ltr $DIR0"/"*.txt $DIR0"/"*.html | tail -n 9; wc -l $OUTFL1 $OUTFL1b $OUTFL1s $OUTFL2 $OUTFL2b $OUTFL2s $OUTF0

echo -ne '\007'
read -p "Press enter to continue $OUTF1 ..."

rm -f temp

/Applications/LibreOffice.app/Contents/MacOS/soffice --calc \
"$OUTF1" \
--accept="socket,host=localhost,port=2002;urp;StarOffice.ServiceManager"

exit 0
