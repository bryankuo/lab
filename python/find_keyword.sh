#!/bin/bash

find . -type f -iname '*.py' -o -iname '*.sh' \
    | xargs grep -rnp --color="auto" -e "$1" \
    | cut -d ":" -f 1 | uniq | xargs ls -lt

exit 0
