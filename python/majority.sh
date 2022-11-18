#!/bin/bash

grep -rnp --color="auto" \
    -e "寶佳資產" -e "嘉源投資" \
    -e "林陳海" -e "合陽管理" -e "合佳投資" \
    -e "曾淑瓊" \
    -e "林家宏" -e "和築" -e "佳峻投資" \
    -e "鄭斯聰" -e "大捷投資" \
    ./datafiles/taiex/majority/*.txt

exit 0
