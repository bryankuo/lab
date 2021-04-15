#!/bin/bash

echo "check price range ..."
python3 range52week.py $1
echo " "

echo "check margin ratio ..."
python3 margin_ratio.py $1
echo " "

echo "check average volume ..."
echo "check listed ..."
python3 volume.py $1
if [[ $? -ne 0 ]]
then
    echo "check otc ..."
    python3 volume_otc.py $1
fi
exit 0
