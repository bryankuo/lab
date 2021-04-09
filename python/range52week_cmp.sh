#!/bin/bash

echo "compare price ..."
i=0;
for ticker in "$@"
do
    i=$((i + 1));
    python3 range52week.py $ticker
done
exit 0
