#!/bin/bash

grep -e "<TD class='odd'" curl.3.post.html \
 | head -1 \
 | grep -oE "([0-9]{1,3})?(,[0-9]{3})*" \
 | xsel --clipboard

rm -f curl.3.post.html
