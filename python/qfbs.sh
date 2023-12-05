#!/bin/bash

# @see uno_stalk_story.sh
# \param twse close mark @see uno_status.sh
#
# qfii.py yyyymmdd [net|file]
# \param timestamp: yyyymmdd
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
# ctags -R --languages=python -o ./mytags .
#
if [ "$#" -lt 2 ]; then
    echo "usage: qfbs.sh yyyymmdd [net|file]"
    echo "       and let safari allow Remote Automation"
    exit 22 # @see https://stackoverflow.com/a/50405954
fi
clear

# @see https://stackoverflow.com/a/428580
YMD=$1
YR=${1:0:4}
MN=${YMD:4:2}
DAY=${YMD:6:2}
ORIGIN=$2
DATE=$YR$MN$DAY
if [[ $(date -j -f '%Y%m%d' "$DATE" +'%u') -eq 1 ]]; then
    LAST_TRADE_DAY=$(date -v-4d +%Y%m%d)
else
    # LAST_TRADE_DAY=$(date -v-1d +%Y%m%d)
    # date calculations on an arbitrary date
    # @see https://stackoverflow.com/a/8521717
    LAST_TRADE_DAY=$( date -j -v-1d -f "%Y%m%d" "$DATE" "+%Y%m%d")
fi

# @see https://stackoverflow.com/a/46024878
if [[ $(date -j -f '%Y%m%d' "$DATE" +'%u') -gt 5 ]]; then
    echo "it is $(date -j -f '%Y%m%d' "$DATE" +'%A')"
    cal $MN $YR
    exit 22
fi

echo "date "$DATE", last trade date "$LAST_TRADE_DAY
# // TODO: @see +62 price.sh, grep file to see if found

DIR0="datafiles/taiex/qfbs"
mkdir -p $DIR0

OUTFL1="$DIR0/list1.$DATE.txt"
OUTFL1b="$DIR0/list1b.$DATE.txt"
OUTFL1s="$DIR0/list1s.$DATE.txt"
OUTFL2="$DIR0/list2.$DATE.txt"
OUTFL2b="$DIR0/list2b.$DATE.txt"
OUTFL2s="$DIR0/list2s.$DATE.txt"

NAME037="外投同買賣及異常"
NAME037_1="外投同買列表"
NAME037_2="外投同賣列表"
NAME037_3="外資操作異常"

OUTF0="$DIR0/$NAME037.$DATE.txt"
OUTF1="$DIR0/$NAME037.$DATE.ods"
OUTF2B="$DIR0/$NAME037_1.$DATE.txt"
OUTF2S="$DIR0/$NAME037_2.$DATE.txt"
OUTFQA="$DIR0/$NAME037_3.$DATE.txt"
O2B="$DIR0/$NAME037_1.$DATE.ods"
O2S="$DIR0/$NAME037_2.$DATE.ods"
OQA="$DIR0/$NAME037_3.$DATE.ods"
OUTF2B_SORTED="$DIR0/2b.$DATE.txt"
OUTF2S_SORTED="$DIR0/2s.$DATE.txt"
OUTFQA_SORTED="$DIR0/qa.$DATE.txt"
REMOTE_FOLDER="~/Dropbox/$DATE"

FROM_SROUCE=($(shuf -i 1-4 -n 1)) # @see https://shorturl.at/AOQU6
get_limit_up() {
    echo "get_limit_up()+"
    # trash "$DIR0/"limit.up.$DATE.csv
    # echo "fetch limit up type 2 from $FROM_SROUCE ..."
    OUTPUT=($(python3 fetch_limit_updown.py 1 $DATE 0 $FROM_SROUCE | tr -d '[],'))
    echo ${OUTPUT[@]}
    sleep 1
    # echo "fetch limit up type 4 from $FROM_SROUCE ..."
    OUTPUT=($(python3 fetch_limit_updown.py 1 $DATE 1 $FROM_SROUCE | tr -d '[],'))
    echo ${OUTPUT[@]}

    # echo "get $DATE type 2 limit up list..."
    OUTPUT=($(python3 get_limit_updown.py 1 $DATE 0 $FROM_SROUCE | tr -d '[],'))
    NUM_TKR2=${OUTPUT[0]%\'}
    NUM_TKR2=${NUM_TKR2#\'}
    # echo "get $DATE type 4 limit up list..."
    OUTPUT=($(python3 get_limit_updown.py 1 $DATE 1 $FROM_SROUCE | tr -d '[],'))
    NUM_TKR4=${OUTPUT[0]%\'}
    NUM_TKR4=${NUM_TKR4#\'}
    NUM_TKR=$(expr $NUM_TKR2 + $NUM_TKR4)
    echo "done, "$NUM_TKR" items."
}

get_limit_down() {
    echo "get_limit_down()+"
    # trash "$DIR0/"limit.down.$DATE.csv
    # echo "fetch limit down type 2 from $FROM_SROUCE ..."
    OUTPUT=($(python3 fetch_limit_updown.py 0 $DATE 0 $FROM_SROUCE | tr -d '[],'))
    echo ${OUTPUT[@]}
    sleep 1
    # echo "fetch limit down type 4 from $FROM_SROUCE ..."
    OUTPUT=($(python3 fetch_limit_updown.py 0 $DATE 1 $FROM_SROUCE | tr -d '[],'))
    echo ${OUTPUT[@]}

    # echo "get $DATE type 2 limit down list..."
    OUTPUT=($(python3 get_limit_updown.py 0 $DATE 0 $FROM_SROUCE | tr -d '[],'))
    NUM_TKR2=${OUTPUT[0]%\'}
    NUM_TKR2=${NUM_TKR2#\'}

    # echo "get $DATE type 4 limit down list..."
    OUTPUT=($(python3 get_limit_updown.py 0 $DATE 1 $FROM_SROUCE | tr -d '[],'))
    NUM_TKR4=${OUTPUT[0]%\'}
    NUM_TKR4=${NUM_TKR4#\'}
    NUM_TKR=$(expr $NUM_TKR2 + $NUM_TKR4)
    echo "done, "$NUM_TKR" items."
}

if true; then
    # // apply only today, history is not available
    get_limit_up
    get_limit_down
    # ls -lt "$DIR0/"*.html "$DIR0/"*.csv | head -n 10
fi

if true; then
    trash $OUTF0 $OUTF1 $OUTF2B $OUTFQA $OUTF2S $O2B $O2S $OQA
    if [ $ORIGIN -eq 0 ]; then
	trash "$DIR0/qfii.$DATE.html"
	trash "$DIR0/fund.$DATE.html"
	ls -ltr "$DIR0/"*$YR$MN$DAY*;
	# rm -f "$DIR0/"*$YR$MN$DAY* # // TODO: verify limit up down not deleted
    fi

    OUTPUT=($(python3 get_twse_mark.py | tr -d '[],'))
    echo ${OUTPUT[@]}
    DEAL=${OUTPUT[0]}
    CHANGE=${OUTPUT[1]%\'}
    CHANGE=${CHANGE#\'}
    RISE=${OUTPUT[2]%\'}
    RISE=${RISE#\'}
    VOLUME=${OUTPUT[3]}
    # printf " %8s twse: %8s %8s %7s %4s\n" $DATE $DEAL $CHANGE $RISE $VOLUME

    # python3 qfii.py $OUTF0
    # python3 qfii.py $OUTF0 0 # // TODO: lazy and less parameter
    # python3 qfii.py $OUTF0 $ORIGIN $YR $MN $DAY
    echo "python3 qfii.py $OUTF0 $ORIGIN $DATE $DEAL $CHANGE $RISE $VOLUME"
    python3 qfii.py $OUTF0 $ORIGIN $DATE $DEAL $CHANGE $RISE $VOLUME
fi

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

mkdir -p $REMOTE_FOLDER
cp -v $OUTF1 $O2B $O2S $OQA $REMOTE_FOLDER

read -p "Press enter to continue $OUTF1 ..."
/Applications/LibreOffice.app/Contents/MacOS/soffice --calc \
"$OUTF1" "$O2B" "$O2S" "$OQA" \
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

# generate 18 files // FIXME:
# ls -ltr "$DIR0/*.txt" "$DIR0/*.html" "$DIR0/*.ods" "$DIR0/*.csv"  | tail -n 18;
ls -ltr "$DIR0/*$DATE*.{html,txt,csv,ods}" | tail -n 18
echo -ne '\007'

# // TODO: https://goodinfo.tw/tw2/StockList.asp?MARKET_CAT=智慧選股&INDUSTRY_CAT=跌停股
# // TODO: https://goodinfo.tw/tw2/StockList.asp?MARKET_CAT=智慧選股&INDUSTRY_CAT=漲停股
# // TODO: mv -v datafiles/taiex/qfbs/*.20231002.* datafiles/taiex/qfbs/20231002
exit 0
