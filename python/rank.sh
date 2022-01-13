#!/bin/bash
DATE=`date '+%Y%m%d'`
OUTF0=datafiles/top100_market_value.$DATE.txt
OUTF1=datafiles/msci.$DATE.txt
OUTF2=datafiles/t50.$DATE.txt
OUTF3=datafiles/rank.$DATE.txt

echo "scrap market value..."
python3 get_mrkt_value.py > $OUTF0

echo "scrap msci components..."
python3 msci_components.py > $OUTF1

echo "scrap t50 components..."
python3 t50_component.py > $OUTF2

echo "merge..."
python3 merge.py $OUTF0 $OUTF2 $OUTF1 > $OUTF3

TIMESTAMP=`date '+%Y/%m/%d %H:%M:%S'`
echo "time: " $TIMESTAMP
echo "done."

echo "open "$OUTF3
python3 launch.py $OUTF3

exit 0
