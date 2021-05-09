#!/bin/bash
python3 basic.py $1
CO_TYPE=$?

python3 capital.py $1
if [[ $? -ne 0 ]]
then
    exit 0
fi
python3 beta.py $1
python3 range52week.py $1
python3 margin_ratio.py $1

# python3 cb.py $1
python3 board.py $1
# display technical as well

python3 vprice.py $1

if [[ $CO_TYPE -eq 0 ]]
then
    python3 volume.py $1
fi

if [[ $CO_TYPE -eq 1 ]]
then
    python3 volume_otc.py $1
fi
exit 0
