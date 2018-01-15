#!/bin/bash
# handy script moving one tracking folder to the other
for file in $(git ls-files ./FreeSWITCH_run/); do
    git add ./i386/$file;
done
