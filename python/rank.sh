#!/bin/bash
DATE=`date '+%Y%m%d'`
DIR0="./datafiles/taiex"
mkdir -p $DIR0

OUTF0=$DIR0"/top100_market_value.$DATE.txt"
OUTF1=datafiles/msci.$DATE.txt
OUTF2=$DIR0"/t50.$DATE.csv"
OUTF3=datafiles/rank.$DATE.txt
OUTF4=datafiles/top150_market_value.$DATE.txt
OUTF5=$DIR0"/m100.$DATE.csv"
OUTF6=$DIR0"/bountylist.t50.$DATE.txt"
OUTF7=$DIR0"/bountylist.m100.$DATE.txt"
OUTF8=$DIR0"/top100_market_value.$DATE.txt"

if true; then
    echo "scrap top 100 market value and weight..."
    python3 get_mrkt_value.py  $DATE
    num_file=$(ls -lt $OUTF0 | wc -l | xargs | cut -d " " -f1)
    num_lines=$(wc -l $OUTF8 | xargs | cut -d " " -f1)
    if [[ $num_file -eq 1 ]] ; then
	echo "done, there are "$num_lines
    else
	echo "something wrong,"
    fi
fi
exit 0

# // TODO: change directory
if false; then
    echo "scrap top 150 market value and weight..."
    python3 top150.py > $OUTF4
    echo "wait 1m to complete..."
    sleep 1m
    num_file=$(ls -lt $OUTF4 | wc -l | xargs | cut -d " " -f1)
    num_lines=$(wc -l $OUTF4 | xargs | cut -d " " -f1)
    echo $num_file
    echo $num_lines
    if [[ $num_file -eq 1 ]] && [[ $num_lines -eq 151 ]]; then
	echo "done."
    else
	echo "something wroing,"
    fi
fi

if false; then
    echo "scrap msci components..."
    python3 msci_components.py > $OUTF1
    echo "wait 1m to complete..."
    sleep 1m
    num_file=$(ls -lt $OUTF1 | wc -l | xargs | cut -d " " -f1)
    file_size=$(ls -lt $OUTF1  | cut -d " " -f8)
    # echo $num_file
    # echo $file_size
    if [[ $num_file -eq 1 ]] && [[ $file_size -gt 1000 ]]; then
	echo "done."
    else
	echo "something wroing,"
    fi
fi

# ready to serve rank.sh
if true; then
    echo "scrap t50 components..."
    python3 t50_component.py $DATE
    num_file=$(ls -lt $OUTF2 | wc -l | xargs | cut -d " " -f1)
    num_lines=$(wc -l $OUTF6 | xargs | cut -d " " -f1)
    if [[ $num_file -eq 1 ]] ; then
	echo "done, there are "$num_lines
    else
	echo "something wrong,"
    fi
fi

# ready to serve rank.sh, but // FIXME: output has changed
if true; then
    echo "scrap m100 components..."
    python3 m100_components.py $DATE
    num_file=$(ls -lt $OUTF5 | wc -l | xargs | cut -d " " -f1)
    num_lines=$(wc -l $OUTF7 | xargs | cut -d " " -f1)
    if [[ $num_file -eq 1 ]] ; then
	echo "done, there are "$num_lines
    else
	echo "something wrong,"
    fi
fi
exit 0

echo "merge..."
python3 merge.py $OUTF0 $OUTF2 $OUTF1 $OUTF4 $OUTF5 > $OUTF3

TIMESTAMP=`date '+%Y/%m/%d %H:%M:%S'`
echo "time: " $TIMESTAMP
echo "done, open "$OUTF3
python3 launch.py $OUTF3

exit 0
