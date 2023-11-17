#!/bin/bash

# ./ror.sh
# 1. scraping ror from a list,
# 2. get twse as benchmark
# 3. for each fetched html, generate rs into csv for calc.
#
# \param in 0: net, 1:file
# \param in bountylist.txt
# \param out OUTF0 ror.YYYYMMDD.csv
# \param out  rs.YYYYMMDD.csv
# return

clear

# echo "$#"
# incase repeated: uniq -i datafiles/bountylist.txt
# BOUNTY="datafiles/bountylist.txt"
# BOUNTY="datafiles/taiex.watchlist.txt" # // FIXME: symbolic link
BOUNTY="datafiles/watchlist.txt"
NLINES=$(wc -l $BOUNTY | xargs | cut -d " " -f1)
START=$index
LEN=$NLINES
echo "start "$START" len "$NLINES

DIR0="datafiles/taiex/rs"
mkdir -p $DIR0

DATE=`date '+%Y%m%d'`
DIR1="$DIR0/$DATE" # to archive *.html
mkdir -p $DIR1

OUTF0="$DIR0/ror.$DATE.csv"
OUTF1="$DIR0/rs.$DATE.csv"
OUTF2="$DIR0/rs.$DATE.ods"
TSE_ROR="$DIR1/ror.twse.html"
TICKER_ROR="$DIR1/ror.[0-9][0-9][0-9][0-9].html"

# watch -n 1 "ls -lt datafiles/taiex/rs/*.html | wc -l"
if false; then
    trash -v $TICKER_ROR
    echo "fetch ticker files..."
    TIMESTAMP0=`date '+%Y/%m/%d %H:%M:%S'`
    # @see https://stackoverflow.com/a/34491383
    # if you have to do just a few requests,
    # Otherwise you'll want to manage sessions yourself.
    # here comes connection pooling
    python3 fetch_ticker_ror.py
    TIMESTAMP=`date '+%Y/%m/%d %H:%M:%S'`
    echo "time: " $TIMESTAMP0 " looping start"
    echo "time: " $TIMESTAMP  " looping end"
    n_fetched=$(ls -lt datafiles/taiex/rs/ror.[0-9][0-9][0-9][0-9].html \
	| wc -l | xargs | cut -d " " -f1)
    echo "fetched:   $n_fetched"

    effective=$(find ./datafiles/taiex/rs/ -type f \
	-iname 'ror.[0-9][0-9][0-9][0-9].html' -mtime -1 -size +20000c \
	-print | wc -l | xargs | cut -d " " -f1)
    echo "effective: $n_effective"

# yyyymmdd
# stat -f %Sm -t %Y%m%d ./datafiles/taiex/rs/ror.[0-9][0-9][0-9][0-9].html

# in size
# stat -f%z ./datafiles/taiex/rs/ror.[0-9][0-9][0-9][0-9].html

# fetched, today, size is normal, bigger than 20000 bytes
# find ./datafiles/taiex/rs/ -type f -iname 'ror.[0-9][0-9][0-9][0-9].html' -mtime -1 -size +20000c -print | wc -l | xargs | cut -d " " -f1
# smaller
# find ./datafiles/taiex/rs/ -type f -iname 'ror.[0-9][0-9][0-9][0-9].html' -mtime -1 -size -20000c -print | wc -l | xargs | cut -d " " -f1

#find ./datafiles/taiex/rs/ -type f -iname 'ror.[0-9][0-9][0-9][0-9].html' -mtime -1 -size +20000c -exec stat -f %Sm -t %Y%m%d%H%M%S \;

# path
# find ./datafiles/taiex/rs/ -type f -iname 'ror.[0-9][0-9][0-9][0-9].html' -mtime -1 -size +20000c
    exit 0
fi

# watch -n 1 "ls -lt datafiles/taiex/rs/*.csv | head -n 2"
if false; then
    echo "clean up data files..."
    trash -v $OUTF0 $OUTF1 $OUTF2 $TSE_ROR
    BENCHMARK=""
    if [ ! -f "$TSE_ROR" ]; then
	echo "get twse ror..."
	echo "ticker:name:1d:1w:1m:2m:3m:6m:1y:ytd:3y" > $OUTF0
	# generate csv header and twse ror
	BENCHMARK=($(python3 get_twse_ror.py | tr -d '[],'))
    else
	# // TODO: by reading from OUTF0
	BENCHMARK=""
    fi
    echo "twse: " ${BENCHMARK[@]}

    echo "generate the rs against twse..."
    TIMESTAMP0=`date '+%Y/%m/%d %H:%M:%S'`
    index=1
    count=0
    echo "ticker:name:1d:1w:1m:2m:3m:6m:1y:ytd:3y" > $OUTF1
    # @see https://superuser.com/a/423086
    effective=$(find ./datafiles/taiex/rs/ -type f -iname 'ror.[0-9][0-9][0-9][0-9].html' -mtime -1 -size +20000c)
    for f in $effective; do
	TICKER=${f:26:4}
	# echo -n $TICKER
	MSG=$(printf "figuring %04d " $index)
	echo -n $MSG
	python3 get_ticker_ror.py $TICKER ${BENCHMARK[@]}
	count=$(($count+1))
	index=$(($index+1))
    done
    TIMESTAMP=`date '+%Y/%m/%d %H:%M:%S'`
    echo "time: " $TIMESTAMP0 " looping start"
    echo "time: " $TIMESTAMP  " looping end"

    # notify user it's done
    echo -ne '\007'
    ls -lt "$DIR0/"*.csv | head -n 5

    echo "watchlist: $NLINES"

    n_fetched=$(ls -lt datafiles/taiex/rs/ror.[0-9][0-9][0-9][0-9].html \
	| wc -l | xargs | cut -d " " -f1)
    echo "fetched:   $n_fetched"

    n_effective=$(find ./datafiles/taiex/rs/ -type f \
	-iname 'ror.[0-9][0-9][0-9][0-9].html' -mtime -1 -size +20000c \
	-print | wc -l | xargs | cut -d " " -f1)
    echo "effective: $n_effective"

    echo $count"     parsed. "
fi

read -p "Press enter to continue $OUTF1 ..."
# open via subprocess, can not modify from outside python
python3 launch.py $OUTF1

# manual process here...
while true ; do
    if [ ! -f "$OUTF2" ]; then
        read -p "Save $OUTF1 to ods when ready ..."
    else
	break
    fi
done

./uno_launch.sh $OUTF2
# so as to let uno_rs.sh adding formula

# ./uno_rs.sh $OUTF2
# // FIXME:     r_ytd = soup.findAll('table')[0] \
# IndexError: list index out of range
#

# // TODO: seperate fetch and get
echo "done, file name is "$OUTF2

# // TODO: housekeeping
# if moving old files, create yyyymmdd folder then move it
# stat -f %Sm -t %Y%m%d ./datafiles/taiex/rs/rs.*.csv | sort | tail -n 1
# FETCH_DATE=$(stat -f %Sm -t %Y%m%d ./datafiles/taiex/rs/rs.*.csv | sort | tail -n 1)
# mkdir -p datafiles/taiex/rs/20231105
# mkdir -p datafiles/taiex/rs/$FETCH_DATE
# mv ./datafiles/taiex/rs/ror.????.html ./datafiles/taiex/rs/$FETCH_DATE/
#
# python$ ./uno_launch.sh datafiles/taiex/rs/rs.20231112.ods
# python$ ./uno_rs.sh 20231112

exit 0
