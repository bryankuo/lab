#!/bin/bash

# // FIXME: use DIR0 instead
# wc -l $(readlink datafiles/listed_taiex.txt) datafiles/watchlist.txt
# comm -13 datafiles/watchlist.txt $(readlink datafiles/listed_taiex.txt)
# comm -13 (sort datafiles/watchlist.txt) (sort $(readlink datafiles/listed_taiex.txt))
rm -f new_shuffle_watchlist
sort datafiles/watchlist.txt > watchlist
sort $(readlink datafiles/listed_taiex.txt) > getlisted
# comm -13 watchlist getlisted > only_in_getlisted
comm -13 watchlist getlisted > only_in_getlisted
shuf only_in_getlisted > shuffle_only_in_getlisted
cat watchlist shuffle_only_in_getlisted >> new_watchlist
shuf new_watchlist > new_shuffle_watchlist

gvim +1 watchlist \
    +"tabnew +1 getlisted" \
    +"tabnew +1 only_in_getlisted" \
    +"tabnew +1 shuffle_only_in_getlisted" \
    +"tabnew +1 new_watchlist" \
    +"tabnew +1 new_shuffle_watchlist"

ls -lt watchlist getlisted only_in_getlisted shuffle_only_in_getlisted new_watchlist new_shuffle_watchlist
wc -l watchlist getlisted only_in_getlisted shuffle_only_in_getlisted new_watchlist new_shuffle_watchlist

DATE=`date '+%Y%m%d'`
cp new_shuffle_watchlist datafiles/watchlist.$DATE.txt
ln -sf datafiles/watchlist.$DATE.txt datafiles/taiex.watchlist.txt

exit 0
