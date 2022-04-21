#!/bin/bash

# make sure running uno.sh
# echo "$#"
if [ "$#" -lt 1 ]; then
    echo "./uno_eps.sh [start] [len]"
    exit 64 # @see https://stackoverflow.com/a/1535733
fi

cp datafiles/activity_watchlist.ods datafiles/activity_watchlist.0.ods
index=1 # calc start index, while txt/calc not sync
count=0
NLINES=( $(wc -l datafiles/watchlist.txt | cut -d " " -f5) )
if [[ $# -gt 1 ]]; then
    START=$1
    LEN=$2
else
    START=$index
    LEN=$NLINES
fi
TIMESTAMP0=`date '+%Y/%m/%d %H:%M:%S'`
echo "start "$START " len "$LEN " #line "$NLINES

while read p; do
    TICKER=$p
    if [[ $index -lt $START ]]
    then
	index=$(($index+1))
	continue
    fi
    # // TODO: handle newly added item when process is ongoing
    # @see https://stackoverflow.com/a/6022441
    # sed '443q;d' datafiles/watchlist.txt
    # sed '1072!d' datafiles/watchlist.txt
    # awk 'NR==1071' datafiles/watchlist.txt
    # TKR=( $(sed '1070q;d' datafiles/watchlist.txt) )
    # echo $TKR
    # exit 0

    EPS=($(python3 eps.py $TICKER 1 | tr -d '[],'))
    # echo ${EPS[@]}
    EPS2021Q4=${EPS[0]%\'}
    EPS2021Q4=${EPS2021Q4#\'}
    EPS2021Q3=${EPS[1]%\'}
    EPS2021Q3=${EPS2021Q3#\'}
    EPS2021Q2=${EPS[2]%\'}
    EPS2021Q2=${EPS2021Q2#\'}
    EPS2021Q1=${EPS[3]%\'}
    EPS2021Q1=${EPS2021Q1#\'}
    EPS2020Q4=${EPS[4]%\'}
    EPS2020Q4=${EPS2020Q4#\'}
    EPS2020Q3=${EPS[5]%\'}
    EPS2020Q3=${EPS2020Q3#\'}
    EPS2020Q2=${EPS[6]%\'}
    EPS2020Q2=${EPS2020Q2#\'}
    EPS2020Q1=${EPS[7]%\'}
    EPS2020Q1=${EPS2020Q1#\'}
    EPS2019Q4=${EPS[8]%\'}
    EPS2019Q4=${EPS2019Q4#\'}
    EPS2019Q3=${EPS[9]%\'}
    EPS2019Q3=${EPS2019Q3#\'}
    printf "%04d ticker: %04d\n" $index $TICKER
    printf "2021: %.2f %.2f %.2f %.2f\n" $EPS2021Q4 $EPS2021Q3 $EPS2021Q2 $EPS2021Q1
    printf "2020: %.2f %.2f %.2f %.2f\n" $EPS2020Q4 $EPS2020Q3 $EPS2020Q2 $EPS2020Q1
    printf "2019: %.2f %.2f\n\n" $EPS2019Q4 $EPS2019Q3

    RETURN=( $(/Applications/LibreOffice.app/Contents/Resources/python \
	uno_eps.py $TICKER \
	$EPS2021Q4 $EPS2021Q3 $EPS2021Q2 $EPS2021Q1 \
	$EPS2020Q4 $EPS2020Q3 $EPS2020Q2 $EPS2020Q1 \
	$EPS2019Q4 $EPS2019Q3 \
	| tr -d '[],' ) )
    O_SPEC=${RETURN[0]%\'}
    O_SPEC=${O_SPEC#\'}
    # echo $OPUT # test return from calc
    if [ "$O_SPEC" == "1" ]; then
	echo -ne '\007'
    fi
    index=$(($index+1))
    count=$(($count+1))
    if [[ $count -ge $LEN ]]; then
	echo "finish $count items."
	break
    fi
    sleep 11
done < datafiles/watchlist.txt
TIMESTAMP=`date '+%Y/%m/%d %H:%M:%S'`
echo "time: " $TIMESTAMP0 " looping start"
echo "time: " $TIMESTAMP  " looping end"

exit 0
