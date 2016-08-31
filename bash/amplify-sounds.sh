#!/bin/bash
# ./amplify-sounds.sh 2.0 from
if [ "$#" -ne 2 ]; then
    echo "Illegal number of parameters"
fi

SRC_FOLDER=$2
TARGET_FOLDER=$SRC_FOLDER"-"$1
echo "start converting..."

rm -rf $TARGET_FOLDER
mkdir -p $TARGET_FOLDER

find $SRC_FOLDER -type f -iname '*.wav' | while read line; do
	DIR=`dirname $line`
	BASE=`basename $line`
	mkdir -p $TARGET_FOLDER"/"${DIR#*/}
	OUT=$TARGET_FOLDER"/"${DIR#*/}"/"$BASE
	/usr/bin/sox -v $1 $line $OUT
done

echo "done."

exit 0
