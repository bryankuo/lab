#!/bin/bash

echo "compare capital ..."
i=0;
for ticker in "$@"
do
    i=$((i + 1));
    python3 capital.py $ticker
done
exit 0
