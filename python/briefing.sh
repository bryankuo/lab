#!/bin/bash
OUTPUT=($(python3 basic.py $1 | tr -d '[],'))
echo ${OUTPUT[@]}
CO_TYPE=${OUTPUT[2]}
# trim prefix and suffix ( https://bit.ly/32vLLgj )
CO_NAME=${OUTPUT[1]%\'}
CO_NAME=${CO_NAME#\'}
# // TODO: CO_NAME for keyword search

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
elif [[ $CO_TYPE -eq 1 ]]
then
    python3 volume_otc.py $1

elif [[ $CO_TYPE -eq 2 ]]
then
    echo "otcbb volume is TBD..."
    # python3 volume_otcbb.py $1
else
    echo "not found."
fi

TIMESTAMP=`date '+%Y/%m/%d %H:%M:%S'`
echo "last update:" $TIMESTAMP

BROWSING=1
if [[ $BROWSING -eq 1 ]]
then
    python3 web_search.py $1
    python3 annual_report.py $1
    python3 board.py $1
    python3 branch.py $1
    python3 broker.py $1
    python3 profile.py $1
    python3 gossip_search.py $1
    python3 104_search.py $1
    python3 announcement.py $1
    python3 revenue_yoy.py $1
fi
exit 0
