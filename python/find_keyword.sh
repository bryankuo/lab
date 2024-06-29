#!/bin/bash

find . -type f -iname '*.py' \
    | xargs grep -rnp --color="auto" -e "$1" \
    | cut -d ":" -f 1 | uniq | xargs ls -lt

exit 0
