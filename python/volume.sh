#!/bin/bash

echo "check listed ..."
python3 volume.py $1
if [[ $? -ne 0 ]]
then
    echo "check otc ..."
    python3 volume_otc.py $1
fi
# // TODO: type 5
exit 0
