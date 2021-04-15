#!/bin/bash

echo "compare margin ratio ..."
i=0;
for ticker in "$@"
do
    i=$((i + 1));
    python3 margin_ratio.py $ticker
done
exit 0
