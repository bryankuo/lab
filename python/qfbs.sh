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
DEFAULT_NAME1="外資投信同買"
DEFAULT_NAME2="外資投信同賣"
OUTF2B="$DIR0/$DEFAULT_NAME1.$DATE.txt"
OUTF2S="$DIR0/$DEFAULT_NAME2.$DATE.txt"
O2B="$DIR0/$DEFAULT_NAME1.$DATE.ods"
O2S="$DIR0/$DEFAULT_NAME2.$DATE.ods"

if [ $ORIGIN -eq 0 ]; then
    rm -vf "$DIR0/qfii.$DATE.html"
    rm -vf "$DIR0/fund.$DATE.html"
    ls -ltr *$YR$MN$DAY*; rm -f *$YR$MN$DAY*
fi

rm -vf $OUTF0 $OUTF1 $OUTF2B $OUTF2S

# python3 qfii.py $OUTF0
# python3 qfii.py $OUTF0 0 # // TODO: lazy and less parameter
python3 qfii.py $OUTF0 $ORIGIN $YR $MN $DAY

TIMESTAMP1=`date '+%Y/%m/%d %H:%M:%S'`

# @see https://superuser.com/a/246841
echo '代  號:名  稱:外資買超:外資賣超:投信買超:投信賣超:同步買超:同步賣超' | cat - $OUTF0 > temp && mv temp $OUTF0
echo '代  號:名  稱:外資買超:外資賣超:投信買超:投信賣超' | cat - $OUTF2B > temp && mv temp $OUTF2B
echo '代  號:名  稱:外資買超:外資賣超:投信買超:投信賣超' | cat - $OUTF2S > temp && mv temp $OUTF2S
rm -f temp

echo -ne '\007'
read -p "Press enter to continue $OUTF0 ..."
python3 launch.py $OUTF0
# manual process here...

echo -ne '\007'
read -p "Press enter to continue $OUTF2B ..."
python3 launch.py $OUTF2B
# manual process here...

echo -ne '\007'
read -p "Press enter to continue $OUTF2S ..."
python3 launch.py $OUTF2S
# manual process here...

echo -ne '\007'
read -p "Press enter to continue $OUTF1 ..."
/Applications/LibreOffice.app/Contents/MacOS/soffice --calc \
"$OUTF1" \
--accept="socket,host=localhost,port=2002;urp;StarOffice.ServiceManager"

echo -ne '\007'
read -p "Press enter to continue $O2B ..."
/Applications/LibreOffice.app/Contents/MacOS/soffice --calc \
"$O2B" \
--accept="socket,host=localhost,port=2002;urp;StarOffice.ServiceManager"

echo -ne '\007'
read -p "Press enter to continue $O2S ..."
/Applications/LibreOffice.app/Contents/MacOS/soffice --calc \
"$O2S" \
--accept="socket,host=localhost,port=2002;urp;StarOffice.ServiceManager"

# generate 14 files
ls -ltr $DIR0"/"*.txt $DIR0"/"*.html $DIR0"/"*.ods  | tail -n 14;
wc -l $OUTFL1 $OUTFL1b $OUTFL1s $OUTFL2 $OUTFL2b $OUTFL2s $OUTF0 \
    $OUTF2B $OUTF2S

# // TODO: compare with yesterday
# meld datafiles/taiex/qfbs/外資投信同賣.20230213.txt datafiles/taiex/qfbs/外資投信同賣.20230214.txt
# meld datafiles/taiex/qfbs/外資投信同賣.20230213.txt datafiles/taiex/qfbs/外資投信同賣.20230214.txt
exit 0
