#!/bin/bash
python3 basic.py $1
CO_TYPE=$?

# python3 capital.py $1
# if [[ $? -ne 0 ]]
# then
#    exit 0
# fi

python3 beta.py $1
python3 range52week.py $1
python3 margin_ratio.py $1
python3 activity.py $1
python3 eps.py $1

echo "checking volume..."
if [[ $CO_TYPE -eq 0 ]]
then
    python3 volume.py $1
fi

if [[ $CO_TYPE -eq 1 ]]
then
    python3 volume_otc.py $1
fi

if [[ $CO_TYPE -eq 2 ]]
then
    echo "otcbb volume is TBD..."
    # python3 volume_otcbb.py $1
fi
TIMESTAMP=`date '+%Y/%m/%d %H:%M:%S'`
echo "last update:" $TIMESTAMP

BROWSING=1
if [[ $BROWSING -eq 1 ]]
then
    python3 fundamental.py $1
    python3 annual_report.py $1
    python3 board.py $1
    python3 vprice.py $1
    python3 reinvestments.py $1
    python3 revenue.py $1
    python3 realtime_technical.py $1
    python3 institution_holdings.py $1
    python3 technical.py $1
    python3 branch.py $1
    python3 news.py $1
    python3 gossip.py $1
    python3 float_trend.py $1
    python3 profile.py $1
    python3 gossip_search.py $1
    python3 104_search.py $1
    python3 announcement.py $1
    python3 revenue_yoy.py $1
fi
exit 0
