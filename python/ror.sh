#!/bin/bash

# ./ror.sh [fetching|figuring]
# 1. scraping ror from a list,
# 2. get twse as benchmark
# 3. for each fetched html, generate rs into csv for calc.
#
# \param in  0: net, 1:file
# \param in  bountylist.txt
# \param out $DIR1/ror.[0-9][0-9][0-9][0-9].html (fetching)
# \param out $DIR1/log.txt (fetching)
# \param out OUTF0 ror.YYYYMMDD.csv
# \param out  rs.YYYYMMDD.csv
# return

if [ "$#" -lt 1 ]; then
    echo "usage: ./ror.sh [fetching|figuring]"
    echo "       and let safari allow Remote Automation"
    exit 22 # @see https://stackoverflow.com/a/50405954
fi

COMMAND=$1

DIR0="datafiles/taiex/rs"
mkdir -p $DIR0

if [ "$#" -eq 1 ]; then
    DATE=`date '+%Y%m%d'`
elif [ "$#" -eq 2 ]; then
    DATE=$2
fi
DIR1="$DIR0/$DATE" # to archive *.html, by date
mkdir -p $DIR1

OUTF0="$DIR0/ror.$DATE.csv"
OUTF1="$DIR0/rs.$DATE.csv"
OUTF2="$DIR0/rs.$DATE.ods"
TSE_ROR="$DIR1/ror.twse.html"
TICKER_ROR="$DIR1/ror.[0-9][0-9][0-9][0-9].html"

# watch -n 1 "ls -lt datafiles/taiex/rs/20240101/*.html | wc -l"
if [ "$COMMAND" = "fetching" ]; then
    # trash -v $TICKER_ROR # hard to fetch...
    echo "fetch ticker files..."
    TIMESTAMP0=`date '+%Y/%m/%d %H:%M:%S'`
    # @see https://stackoverflow.com/a/34491383
    # if you have to do just a few requests,
    # Otherwise you'll want to manage sessions yourself.
    # here comes connection pooling
    python3 fetch_ticker_ror.py
    TIMESTAMP=`date '+%Y/%m/%d %H:%M:%S'`
    echo "time: " $TIMESTAMP0 " looping start"
    echo "time: " $TIMESTAMP  " looping end" # 14 minutes
    n_fetched=$(ls -lt $DIR1/ror.[0-9][0-9][0-9][0-9].html \
	| wc -l | xargs | cut -d " " -f1)
    echo "fetched:   $n_fetched"

    n_effective=$(find $DIR1 -type f \
	-iname 'ror.[0-9][0-9][0-9][0-9].html' -mtime -1 -size +20000c \
	-print | wc -l | xargs | cut -d " " -f1)
    echo "effective: $n_effective, ror is also ready to scrap"

    ls -lt "$DIR1/log.txt"

    # yyyymmdd
    # stat -f %Sm -t %Y%m%d ./datafiles/taiex/rs/20231201/ror.[0-9][0-9][0-9][0-9].html

    # in size
    # stat -f%z ./datafiles/taiex/rs/20231201/ror.[0-9][0-9][0-9][0-9].html

    # fetched, today, size is normal, all
    # find ./datafiles/taiex/rs/20231201 -type f -iname 'ror.[0-9][0-9][0-9][0-9].html' -mtime -1 -print | wc -l | xargs | cut -d " " -f1

    # fetched, today, size is normal, bigger than 20000 bytes
    # find ./datafiles/taiex/rs/20231222 -type f -iname 'ror.[0-9][0-9][0-9][0-9].html' -mtime -1 -size +20000c -print | wc -l | xargs | cut -d " " -f1

    # find those not matching criteria
    # find ./datafiles/taiex/rs/20240101 -type f -iname 'ror.[0-9][0-9][0-9][0-9].html' -mtime -1 -size -20000c -print | wc -l | xargs | cut -d " " -f1
    # into another round, torch it...
    # find ./datafiles/taiex/rs/20240101 -type f -iname 'ror.[0-9][0-9][0-9][0-9].html' -mtime -1 -size -20000c -print | cut -d '.' -f 3 > datafiles/watchlist.txt

    #find ./datafiles/taiex/rs/20231201 -type f -iname 'ror.[0-9][0-9][0-9][0-9].html' -mtime -1 -size +20000c -exec stat -f %Sm -t %Y%m%d%H%M%S \;

    # path
    # find ./datafiles/taiex/rs/20231201 -type f -iname 'ror.[0-9][0-9][0-9][0-9].html' -mtime -1 -size +20000c

elif [ "$COMMAND" = "figuring" ]; then
    # watch -n 1 "ls -lt datafiles/taiex/rs/*.csv | head -n 2"
    echo "clean up data files..."
    trash -v $OUTF0 $OUTF1 $OUTF2 $TSE_ROR
    BENCHMARK=""
    if [ ! -f "$TSE_ROR" ]; then
	echo "get twse ror..."
	echo "ticker:name:1d:1w:1m:2m:3m:6m:1y:ytd:3y" > $OUTF0
	# generate csv header and twse ror
	BENCHMARK=($(python3 get_twse_ror.py $DATE | tr -d '[],'))
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
    effective=$(find $DIR1 -type f -iname 'ror.[0-9][0-9][0-9][0-9].html' -mtime -1 -size +20000c)
    for f in $effective; do
	TICKER=${f:32:4}
	MSG=$(printf "%04d %04d %s" $index $TICKER $f)
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

    n_fetched=$(ls -lt $DIR1/ror.[0-9][0-9][0-9][0-9].html \
	| wc -l | xargs | cut -d " " -f1)
    echo "fetched:   $n_fetched"

    n_effective=$(find $DIR1 -type f \
	-iname 'ror.[0-9][0-9][0-9][0-9].html' -mtime -1 -size +20000c \
	-print | wc -l | xargs | cut -d " " -f1)
    echo "effective: $n_effective"

    echo $count"     parsed. "
    tput bel

    read -p "Press enter to continue $OUTF1 ..."
    # open via subprocess, can not modify from outside python
    # python3 launch.py $OUTF1
    ./uno_launch.sh $OUTF1
    tput bel

    # manual process here...
    while true ; do
	if [ ! -f "$OUTF2" ]; then
	    read -p "Save $OUTF1 to ods when ready ..."
	else
	    break
	fi
    done

    # ./uno_launch.sh $OUTF2
    # assume ready and focused, uno_rs.sh adding formula
    # ./uno_rs.sh $DATE # abandon ./uno_rs.sh
    # // FIXME:     r_ytd = soup.findAll('table')[0] \
    # IndexError: list index out of range
    TIMESTAMP0=`date '+%Y/%m/%d %H:%M:%S'`
    /Applications/LibreOffice.app/Contents/Resources/python \
	uno_formula.py $DATE
    TIMESTAMP=`date '+%Y/%m/%d %H:%M:%S'`
    echo "time: " $TIMESTAMP0 " looping start"
    echo "time: " $TIMESTAMP  " looping end"
    tput bel

    echo "done, file name is $OUTF2"
    cp -v $OUTF2 ~/Dropbox

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
    # find . -type d -iname '*20231201*' -o -type f -iname '*20231201*'  -delete
    # trash -v ./20231201
fi

exit 0


# 【投資人投資股票報酬率】月報
# https://www.twse.com.tw/pcversion/zh/statistics/statisticsList?type=02&subType=207
