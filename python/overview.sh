#!/bin/bash
python3 capital.py $1
python3 beta.py $1
python3 range52week.py $1
python3 margin_ratio.py $1

echo $1 " daily average volume for the past year:"
python3 volume.py $1
if [[ $? -ne 0 ]]
then
    echo "check otc ..."
    python3 volume_otc.py $1
fi
exit 0
