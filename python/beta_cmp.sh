#!/bin/bash

echo "compare beta ..."
i=0;
for ticker in "$@"
do
    i=$((i + 1));
    python3 beta.py $ticker
done
exit 0
