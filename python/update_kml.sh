#!/bin/bash

# a handy tool updating kml, focus 所在地,HQ,HR,FI location

# last N days
DIR0="$HOME/github/python/datafiles/taiex"

./uno_launch.sh ./datafiles/activity_watchlist.ods
read -p "Touch calc then press enter to continue..."
echo -ne '\007'

python3 rw_kml.py

/Applications/LibreOffice.app/Contents/Resources/python \
    ./uno/load/lnglat.py

grep -rnp -e "<Placemark>" datafiles/taiex/companies.kml | wc -l

exit 0
