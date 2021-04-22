#!/bin/bash
python3 capital.py $1
if [[ $? -ne 0 ]]
then
    exit 0
fi
python3 beta.py $1
python3 range52week.py $1
python3 margin_ratio.py $1
python3 volume.py $1
if [[ $? -ne 0 ]]
then
    echo "check otc ..."
    python3 volume_otc.py $1
fi
python3 cb.py $1
exit 0
