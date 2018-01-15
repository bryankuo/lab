#!/bin/bash

case "$OSTYPE" in
	linux*)
		alias pbcopy='xsel --clipboard --input' ;;
	darwin*)
		;;
	*) ;;
esac

grep -e "<TD class='odd'" curl.3.post.html \
 | head -1 \
 | grep -oE "([0-9]{1,3})?(,[0-9]{3})*"

# \
# | pbcopy

# xsel --clipboard

# rm -f curl.3.post.html
