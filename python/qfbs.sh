#!/bin/bash

# @see uno_stalk_story.sh
# handle 4 cvs from qfii.py

clear

DATE=`date '+%m%d'`
# OUTF1="list1.txt"
OUTF2="list2.txt"
# OUTF1b="list1b.txt"
# OUTF1s="list1s.txt"
OUTF2b="list2b.txt"
OUTF2s="list2s.txt"
NAME="外資投信同步買賣超"
#OUTF="list"
INF0="$NAME.$DATE.txt"
OUTF0="$NAME.$DATE.ods"

# rm -f qfii.html fund.html
rm -f $INF0 $OUTF0

python3 qfii.py 1 $INF0

TIMESTAMP1=`date '+%Y/%m/%d %H:%M:%S'`

# @see https://superuser.com/a/246841
echo '代  號:名  稱:外資買超:外資賣超:投信買超:投信賣超:同步買超:同步賣超' | cat - $INF0 > temp && mv temp $INF0
python3 launch.py $INF0

# manual process here...

ls -ltr *.txt | tail -n 10; wc -l $OUTF2 $OUTF2b $OUTF2s

echo -ne '\007'
read -p "Press enter to continue $OUTF0 ..."

rm -f temp

/Applications/LibreOffice.app/Contents/MacOS/soffice --calc \
"$OUTF0" \
--accept="socket,host=localhost,port=2002;urp;StarOffice.ServiceManager"

exit 0
