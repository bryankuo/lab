#!/bin/bash

clear

TIMESTAMP0=`date '+%Y/%m/%d %H:%M:%S'`
echo "time: "$TIMESTAMP0

echo "processing..."

grep -rnp --color="auto"        \
    -e "林翁全" -e "萬寶開發"   \
    ./datafiles/taiex/majority/*.txt \
    | tee /dev/tty | wc -l

TOTAL=$(ls -lt datafiles/taiex/majority/*.txt | wc -l)
echo "in $TOTAL companies collected."
echo "they are: (TBD) "
# // TODO: uniq

TIMESTAMP1=`date '+%Y/%m/%d %H:%M:%S'`
echo "time: " $TIMESTAMP0 " process start"
echo "time: " $TIMESTAMP1 " process end"
echo -ne '\007'

exit 0
