#!/bin/bash

echo "compare last 4 quarterly GPM..."
i=0;
ticker=$1
for competitor in "$@"
do
    i=$((i + 1));
    python3 gpm.py $competitor
done
exit 0
