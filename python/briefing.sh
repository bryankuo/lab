#!/bin/bash
CO_TYPE1=( $(grep -rnp --color="auto" -e $1 datafiles/listed_[245].txt | \
    cut -d "_" -f 2 | cut -d "." -f 1 ))
if [ $CO_TYPE1 -eq 2 ] || [ $CO_TYPE1 -eq 4 ]
then
    OUTPUT=($(python3 basic.py $1 | tr -d '[],'))
    echo ${OUTPUT[@]}
    CO_TYPE=${OUTPUT[2]}

    # trim prefix and suffix ( https://bit.ly/32vLLgj )
    CO_NAME=${OUTPUT[1]%\'}
    CO_NAME=${CO_NAME#\'}

    CO_TITLE=${OUTPUT[5]%\'}
    CO_TITLE=${CO_TITLE#\'}

    CO_ADDR=${OUTPUT[6]%\'}
    CO_ADDR=${CO_ADDR#\'}

    CO_CHAIRMAN=${OUTPUT[7]%\'}
    CO_CHAIRMAN=${CO_CHAIRMAN#\'}

    CO_GM=${OUTPUT[8]%\'}
    CO_GM=${CO_GM#\'}

    OUTPUT_ID=($(python3 taxid.py $1 $CO_TITLE | tr -d '[],'))
    TID=${OUTPUT_ID[0]%\'}
    TID=${TID#\'}

    BROWSING=1
    if [[ $BROWSING -eq 1 ]]
    then
	python3 web_search.py $1 \
	    $CO_TITLE $CO_ADDR $CO_CHAIRMAN $CO_GM $CO_TYPE $TID
	python3 branch.py $1
    fi

    # python3 capital.py $1
    # if [[ $? -ne 0 ]]
    # then
    #    exit 0
    # fi

    python3 beta.py $1
    python3 range52week.py $1
    python3 margin_ratio.py $1
    python3 activity.py $1

    echo "checking volume..."
    if [[ $CO_TYPE -eq 2 ]]; then
	python3 volume.py $1
    elif [[ $CO_TYPE -eq 4 ]]; then
	python3 volume_otc.py $1

    elif [[ $CO_TYPE -eq 5 ]]; then
	echo "otcbb volume is TBD..."
	# python3 volume_otcbb.py $1
    else
	echo "not found."
    fi

    python3 chips.py $1 $CO_TYPE
    python3 hbs30.py $1
    python3 derivative.py $1
else
    echo $CO_TYPE1
fi

python3 board.py $1
python3 annual_report.py $1
python3 announcement.py $1
# python3 gtrend.py $1 // FIXME: return 429
# python3 warrant.py $1

TIMESTAMP=`date '+%Y/%m/%d %H:%M:%S'`
echo "last update:" $TIMESTAMP

exit 0
# // TODO: scrap and to official sites
