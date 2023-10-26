#!/bin/bash

# @see uno_stalk_story.sh
# \param twse close mark @see uno_status.sh
#
# qfii.py yyyy mm dd [net|file]
# \param timestamp: yyyy mm dd
# \param origin: net 0, file 1
# \param out in limit up down file
# handle 4 cvs from qfii.py
# \return OUTF0  txt file, a summary describe what qfii/fund buy and sell
# \return OUTF2B txt file, summary describing both buy
# \return OUTF2S txt file, summary describing both sell
# \return OUTFQA txt file, summary describing when:
#   1.buy  when twse dip
#   2.sell when twse rip
# \return OUTF1 ods file, manual saved by calc
# // TODO: consider public bank activities
# https://www.wantgoo.com/stock/public-bank/buy-sell
# https://histock.tw/stock/broker8.aspx
# https://chart.capital.com.tw/Chart/TWII/TAIEX11.aspx
#
if [ "$#" -lt 4 ]; then
    echo "usage: qfbs.sh yyyy mm dd [net|file]"
    echo "       and let safari allow Remote Automation"
    exit 22 # @see https://stackoverflow.com/a/50405954
fi
clear

YR=$1
MN=$2
DAY=$3
ORIGIN=$4

DATE=$YR$MN$DAY
if [[ $(date -j -f '%Y%m%d' "$DATE" +'%u') -eq 1 ]]; then
    LAST_TRADE_DAY=$(date -v-4d +%Y%m%d)
else
    LAST_TRADE_DAY=$(date -v-1d +%Y%m%d)
fi

# @see https://stackoverflow.com/a/46024878
if [[ $(date -j -f '%Y%m%d' "$DATE" +'%u') -gt 5 ]]; then
    echo "it is $(date -j -f '%Y%m%d' "$DATE" +'%A')"
    cal $MN $YR
    exit 22
fi

echo "date "$DATE", last trade date "$LAST_TRADE_DAY
# // TODO: @see price.sh

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
DEFAULT_NAME3="外資操作異常"
OUTF2B="$DIR0/$DEFAULT_NAME1.$DATE.txt"
OUTF2S="$DIR0/$DEFAULT_NAME2.$DATE.txt"
OUTFQA="$DIR0/$DEFAULT_NAME3.$DATE.txt"
O2B="$DIR0/$DEFAULT_NAME1.$DATE.ods"
O2S="$DIR0/$DEFAULT_NAME2.$DATE.ods"
OQA="$DIR0/$DEFAULT_NAME3.$DATE.ods"
OUTF2B_SORTED="$DIR0/2b.$DATE.txt"
OUTF2S_SORTED="$DIR0/2s.$DATE.txt"
OUTFQA_SORTED="$DIR0/qa.$DATE.txt"

FROM_SROUCE=($(shuf -i 1-5 -n 1)) # @see https://shorturl.at/AOQU6
get_limit_up() {
    echo "fetch limit up type 2 from $FROM_SROUCE ..."
    OUTPUT=($(python3 fetch_limit_updown.py 1 $DATE 0 $FROM_SROUCE | tr -d '[],'))
    sleep 1
    echo "fetch limit up type 4 from $FROM_SROUCE ..."
    OUTPUT=($(python3 fetch_limit_updown.py 1 $DATE 1 $FROM_SROUCE | tr -d '[],'))
    # echo ${OUTPUT[@]}
    #trash limit.up.$DATE.csv # already done in get_limit_updown.py

    echo "get $DATE type 2 limit up list..."
    OUTPUT=($(python3 get_limit_updown.py 1 $DATE 0 $FROM_SROUCE | tr -d '[],'))
    NUM_TKR=${OUTPUT[0]%\'}
    NUM_TKR=${NUM_TKR#\'}
    echo "done, "$NUM_TKR" items."

    echo "get $DATE type 4 limit up list..."
    OUTPUT=($(python3 get_limit_updown.py 1 $DATE 1 $FROM_SROUCE | tr -d '[],'))
    NUM_TKR=${OUTPUT[0]%\'}
    NUM_TKR=${NUM_TKR#\'}
    echo "done, "$NUM_TKR" items."
}

get_limit_down() {
    echo "fetch limit down type 2 from $FROM_SROUCE ..."
    OUTPUT=($(python3 fetch_limit_updown.py 0 $DATE 0 $FROM_SROUCE | tr -d '[],'))
    sleep 1
    echo "fetch limit down type 4 from $FROM_SROUCE ..."
    OUTPUT=($(python3 fetch_limit_updown.py 0 $DATE 1 $FROM_SROUCE | tr -d '[],'))
    # trash limit.down.$DATE.csv # already done in get_limit_updown.py

    echo "get $DATE type 2 limit down list..."
    OUTPUT=($(python3 get_limit_updown.py 0 $DATE 0 $FROM_SROUCE | tr -d '[],'))
    NUM_TKR=${OUTPUT[0]%\'}
    NUM_TKR=${NUM_TKR#\'}
    echo "done, "$NUM_TKR" items."

    echo "get $DATE type 4 limit down list..."
    OUTPUT=($(python3 get_limit_updown.py 0 $DATE 1 $FROM_SROUCE | tr -d '[],'))
    NUM_TKR=${OUTPUT[0]%\'}
    NUM_TKR=${NUM_TKR#\'}
    echo "done, "$NUM_TKR" items."
}

get_limit_up
get_limit_down
# pwd
# echo "$DIR0/limit*"
# ls -lt $DIR0"/limit*" | head -n 6 # // FIXME: not displayed.

OUTPUT=($(python3 get_twse_mark.py | tr -d '[],'))
echo ${OUTPUT[@]}
DEAL=${OUTPUT[0]%\'}
DEAL=${DEAL#\'}
CHANGE=${OUTPUT[1]%\'}
CHANGE=${CHANGE#\'}
RISE=${OUTPUT[2]%\'}
RISE=${RISE#\'}
VOLUME=${OUTPUT[3]%\'}
VOLUME=${VOLUME#\'}
# printf "twse date: %8s %8s %8s %7s %4s\n" $DATE $DEAL $CHANGE $RISE $VOLUME

trash $OUTF0 $OUTF1 $OUTF2B $OUTFQA $OUTF2S $O2B $O2S $OQA

if [ $ORIGIN -eq 0 ]; then
    trash "$DIR0/qfii.$DATE.html"
    trash "$DIR0/fund.$DATE.html"
    ls -ltr "$DIR0/"*$YR$MN$DAY*;
    # rm -f "$DIR0/"*$YR$MN$DAY* # // TODO: verify limit up down not deleted
fi

# python3 qfii.py $OUTF0
# python3 qfii.py $OUTF0 0 # // TODO: lazy and less parameter
# python3 qfii.py $OUTF0 $ORIGIN $YR $MN $DAY
python3 qfii.py $OUTF0 $ORIGIN $YR $MN $DAY $DEAL $CHANGE $RISE $VOLUME

TIMESTAMP1=`date '+%Y/%m/%d %H:%M:%S'`

# @see https://superuser.com/a/246841
echo '代  號:名  稱:外資買超:外資賣超:投信買超:投信賣超:同步買超:同步賣超:外資操作異常' | cat - $OUTF0 > temp && mv temp $OUTF0
echo '代  號:名  稱:外資買超:外資賣超:投信買超:投信賣超' | cat - $OUTF2B > temp && mv temp $OUTF2B
echo '代  號:名  稱:外資買超:外資賣超:投信買超:投信賣超' | cat - $OUTF2S > temp && mv temp $OUTF2S
echo '代  號:名  稱:外資買超:外資賣超' | cat - $OUTFQA > temp && mv temp $OUTFQA
rm -f temp

echo -ne '\007'
read -p "Press enter to continue $OUTF0 ..."
python3 launch.py $OUTF0
# manual process here...
while true ; do
    if [ ! -f "$OUTF1" ]; then
        read -p "Save $OUTF0  to ods when ready ..."
    else
	break
    fi
done

echo -ne '\007'
read -p "Press enter to continue $OUTF2B ..."
python3 launch.py $OUTF2B
# manual process here...
while true ; do
    if [ ! -f "$O2B" ]; then
        read -p "Save $OUTF2B to ods when ready ..."
    else
	break
    fi
done

echo -ne '\007'
read -p "Press enter to continue $OUTF2S ..."
python3 launch.py $OUTF2S
# manual process here...
while true ; do
    if [ ! -f "$O2S" ]; then
        read -p "Save $OUTF2S to ods when ready ..."
    else
	break
    fi
done

echo -ne '\007'
read -p "Press enter to continue $OUTFQA ..."
python3 launch.py $OUTFQA
# manual process here...
while true ; do
    if [ ! -f "$OQA" ]; then
        read -p "Save $OUTFQA to ods when ready ..."
    else
	break
    fi
done

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

echo -ne '\007'
read -p "Press enter to continue $OQA ..."
/Applications/LibreOffice.app/Contents/MacOS/soffice --calc \
"$OQA" \
--accept="socket,host=localhost,port=2002;urp;StarOffice.ServiceManager"

wc -l $OUTFL1 $OUTFL1b $OUTFL1s $OUTFL2 $OUTFL2b $OUTFL2s $OUTF0 \
    $OUTF2B $OUTF2S $OUTFQA

echo "sort "$OUTF2B", "$OUTF2S" for new(b|s), 2day(b|s) ..."
tail -n +2 $OUTF2B > temp; awk -F':' '{print $1}' temp | \
    sort > $OUTF2B_SORTED; #cat $OUTF2B_SORTED
rm -f temp

tail -n +2 $OUTF2S > temp; awk -F':' '{print $1}' temp | \
    sort > $OUTF2S_SORTED; # cat $OUTF2S_SORTED
rm -f temp

./check_2b2s.sh $LAST_TRADE_DAY $DATE

# generate 18 files
ls -ltr $DIR0"/"*.txt $DIR0"/"*.html $DIR0"/"*.ods  | tail -n 18;

# // TODO: https://goodinfo.tw/tw2/StockList.asp?MARKET_CAT=智慧選股&INDUSTRY_CAT=跌停股
# // TODO: https://goodinfo.tw/tw2/StockList.asp?MARKET_CAT=智慧選股&INDUSTRY_CAT=漲停股
# // TODO: mv -v datafiles/taiex/qfbs/*.20231002.* datafiles/taiex/qfbs/20231002
exit 0
