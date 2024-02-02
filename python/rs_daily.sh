#!/bin/bash

python3 rw_qvrs.py $1

./uno_launch.sh datafiles/taiex/rs/qvrs.$1.ticker.asc.ods

exit 0
