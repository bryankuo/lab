#!/bin/bash
./briefing.sh $1 2>&1 | tee ./datafiles/$1.txt
exit 0
