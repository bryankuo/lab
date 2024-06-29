#!/bin/bash

# trend following major players:
#
# 1. qfii, fund, retail (qfii.py, qfbs.sh, basic.py, uno_activity.py)
# 2. government banks (gbank_activities.py, gbank_histock.py)
# 3. board holdings (board.py, bholding.sh)
# 4. margin (fetch_margin_balance.py)
# 5. etfs / indexes ( wg_components.py, scrap_wg_components.py)
# 6. 國發基金 ( update frequency? )
# 7. insider ( insider_trade.py )
#
clear

TIMESTAMP0=`date '+%Y/%m/%d %H:%M:%S'`
echo "time: "$TIMESTAMP0

echo "processing..."

grep -rnp --color="auto" \
    -e "林陳海" \
    -e "寶佳資產" -e "嘉源投資" \
    -e "合陽管理" -e "合佳投資" \
    -e "曾淑瓊"   -e "合毅國際投資" \
    -e "緣璞建設" -e "澄緣投資" \
    -e "林家宏" \
    -e "和築"     -e "佳峻投資"     -e "和發國際投資" \
    -e "寶福能源" \
    -e "鄭斯聰" \
    -e "大捷投資" -e "源通投資" \
    -e "白淑貞"   -e "寶壽能源"     -e "合欣投資股份有限公司" \
    -e "寶順能源" -e "合遠國際投資" -e "寶佳建築經理" \
    -e "陳秀靖" \
    -e "吳素秋"   -e "嘉源投資" \
    -e "吳佩娟" \
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
