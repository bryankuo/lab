#!/bin/bash

# $1 id
# $2 year
# $3 month

WORKINGDIR="$(dirname "$0")"
#echo $WORKINGDIR
"$WORKINGDIR"/curl.3.post.sh $1 $2 $3
"$WORKINGDIR"/curl.5.grep.sh
exit 0;
