#!/bin/bash

# // FIXME: use DIR0 instead
# wc -l $(readlink datafiles/listed_taiex.txt) datafiles/watchlist.txt
# comm -13 datafiles/watchlist.txt $(readlink datafiles/listed_taiex.txt)
# comm -13 (sort datafiles/watchlist.txt) (sort $(readlink datafiles/listed_taiex.txt))

DATE=`date '+%Y%m%d'`
shuf $(readlink datafiles/listed_taiex.txt) > ./datafiles/watchlist.$DATE.txt
ln -sf datafiles/watchlist.$DATE.txt datafiles/taiex.watchlist.txt
cp -v ./datafiles/watchlist.$DATE.txt ./datafiles/watchlist.txt
ls -lt ./datafiles/listed_taiex.txt $(readlink datafiles/listed_taiex.txt) \
    ./datafiles/watchlist.$DATE.txt ./datafiles/watchlist.txt
exit 0

# sort datafiles/watchlist.txt > watchlist
#comm -13 watchlist getlisted > only_in_getlisted
#shuf only_in_getlisted > shuffle_only_in_getlisted
#cat shuffle_only_in_getlisted >> new_watchlist
# shuf new_watchlist > new_shuffle_watchlist
# shuf ./datafiles/listed_taiex.$DATE.txt > ./datafiles/watchlist.$DATE.txt
# gvim +1 watchlist \
#    +"tabnew +1 getlisted" \
#    +"tabnew +1 only_in_getlisted" \
#    +"tabnew +1 shuffle_only_in_getlisted" \
#    +"tabnew +1 new_watchlist" \
#    +"tabnew +1 new_shuffle_watchlist"

# ls -lt watchlist getlisted only_in_getlisted shuffle_only_in_getlisted new_watchlist new_shuffle_watchlist
# wc -l watchlist getlisted only_in_getlisted shuffle_only_in_getlisted new_watchlist new_shuffle_watchlist

# cp -v new_shuffle_watchlist datafiles/watchlist.$DATE.txt
# ln -sf datafiles/watchlist.$DATE.txt datafiles/taiex.watchlist.txt

# trash -v new_shuffle_watchlist getlisted only_in_getlisted \
#  shuffle_only_in_getlisted new_watchlist new_shuffle_watchlist
# ls -lt ./datafiles/listed_taiex.20240216.txt \
#    ./datafiles/watchlist.$DATE.txt datafiles/taiex.watchlist.txt \
#    ./datafiles/watchlist.txt

exit 0
