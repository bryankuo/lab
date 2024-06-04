#!/bin/bash

echo "compare capital ..."
i=0;
for ticker in "$@"
do
    i=$((i + 1));
    python3 capital.py $ticker
done
exit 0
# // TODO: 同業股價表現
# @see https://www.moneydj.com/z/zh/zha/ZH00.djhtm?A=C012011
