#!/bin/bash
# usage: ./get-google-finance-stock-quotes.sh "https://www.google.com/finance?q=NYSE%3ABABA&ei=POEBWLHRM9iL0gS3xJ7IDg", url with quote (prevent bg)
#URL="https://www.google.com/finance?q=NYSE%3AJPM&ei=D03-V9CvH5GH0gTl3pCYAw"
#URL=$1
YELLOW='\e[93m'
INPUT_FILE="stock_list.txt"
OUTPUT_F="latest_quotes.html"
TMP_D=.
printf "<div id=\"css_table\">\n" > $OUTPUT_F
printf "\t<div class=\"css_tr\">\n" >> $OUTPUT_F
printf "\t\t<div class=\"css_td\" style=\"width: 150px;\">symbol</div>\n" >> $OUTPUT_F
printf "\t\t<div class=\"css_td\">price</div>\n" >> $OUTPUT_F
printf "\t\t<div class=\"css_td\">target</div>\n" >> $OUTPUT_F
printf "\t\t<div class=\"css_td\" style=\"width: 150px;\">52 week</div>\n" >> $OUTPUT_F
printf "\t</div>\n" >> $OUTPUT_F

print_stock_list( ) {
	SYMBOL=$1
	TARGET=$2
	PRICE=$3
	RANGE=$4
	LOW52=$5
	HIGH52=$6
	PEAK=150 #$7
	URL1=$6
	#if [ "$PRICE" -lt 100 ]; then
	#		STYLE="style=\"color: green\""
	#fi
	VALUATION=""
	if [ $(echo "$PRICE < $TARGET" | bc) -eq 1 ]; then
		VALUATION="buy" # buy sale alert
	fi
	if [ $(echo "$PRICE < $LOW52" | bc) -eq 1 ]; then
		VALUATION="alert" # buy sale alert
	fi
	if [ $(echo "$PRICE > $HIGH52" | bc) -eq 1 ]; then
		VALUATION="alert" # buy sale alert
	fi
	# if [ $(echo "$PRICE > $PEAK" | bc) -eq 1 ]; then
	# 	VALUATION="sale" # buy sale alert
	# fi
	printf "%s\t%s\t%s\t%s%s%s\t%s\n" $SYMBOL $PRICE $LOW52 $RANGE $TARGET
	#
	printf "\t<div class=\"css_tr\">\n" >> $OUTPUT_F
	printf "\t\t<div class=\"css_td\" style=\"width: 150px;\"><a class="stock" target="_blank" href="$URL1">$SYMBOL</a></div>\n" >> $OUTPUT_F
	printf "\t\t<div class=\"css_td $VALUATION\">$PRICE</div>\n" >> $OUTPUT_F
	printf "\t\t<div class=\"css_td\">$TARGET</div>\n" >> $OUTPUT_F
	printf "\t\t<div class=\"css_td\" style=\"width: 150px;\">$RANGE</div>\n" >> $OUTPUT_F
	printf "\t</div>\n" >> $OUTPUT_F

	return
}

parse_52week_range ( ) {
	# echo $0 $1 $2 $3 $4
	SYMBOL=$1
	# $2 RNAGE OUT
	# $3 LOW52
	# $4 HIGH52
	DATA_FILE=$5
	PASS1_FILE=$TMP_D/$SYMBOL.pass1.html
	PASS2_FILE=$TMP_D/$SYMBOL.pass2.html
	PASS3_FILE=$TMP_D/$SYMBOL.pass3.html
	PASS4_FILE=$TMP_D/$SYMBOL.pass4.html
	PASS5_FILE=$TMP_D/$SYMBOL.pass5.html
	cp -a $DATA_FILE $TMP_D/$SYMBOL.0.html
	sed  ':a;N;$!ba;s/\n/,/g' $DATA_FILE > $PASS1_FILE
	# grep -Eo '<td class="key",          data-snapfield="range_52week">52 week,</td>,<td class="val">[0-9]+(\.[0-9][0-9]?)? - [0-9]+(\.[0-9][0-9]?)?,</td>' $PASS1_FILE > $PASS2_FILE
	#RNG='12 - 34.0'
	grep -Eo '52 week,</td>,<td class="val">[0-9]+(\.[0-9][0-9]?)? - [0-9]+(\.[0-9][0-9]?)?,</td>' $PASS1_FILE > $PASS2_FILE
	RNG=$(grep -Eo '[0-9]+(\.[0-9][0-9]?)? - [0-9]+(\.[0-9][0-9]?)?' $PASS2_FILE)
	eval "$2='$RNG'"
	echo $RNG > $PASS3_FILE
	grep -Eo '[0-9]+(\.[0-9][0-9]?)? -' $PASS3_FILE > $PASS4_FILE
	grep -Eo '\- [0-9]+(\.[0-9][0-9]?)?' $PASS3_FILE > $PASS5_FILE
	# eval "$1='12 - 34.0'"
	LOW52=$(grep -Eo '[0-9]+(\.[0-9][0-9]?)?' $PASS4_FILE)
	eval "$3='$LOW52'"
	HIGH52=$(grep -Eo '[0-9]+(\.[0-9][0-9]?)?' $PASS5_FILE)
	eval "$4='$HIGH52'"
	rm -f $TMP_D/$SYMBOL.0.html
	rm -f $PASS1_FILE
	rm -f $PASS2_FILE
	rm -f $PASS3_FILE
	rm -f $PASS4_FILE
	rm -f $PASS5_FILE
	return
}

fetch_stock_quotes ( ) {
	#echo "$FUNCNAME $@"
	para_in=$@
	arrIN=(${para_in//;/ })
	URL=${arrIN[0]}
	TARGET=${arrIN[1]}
#echo -e "$(curl -s "$@" | grep -Eo '<span id=".*">.*</span>' | head -n 1 | awk -F "[><]" '/span/{print $3}' )" | tee -a latest_quotes.html;
	SYMBOL=$(echo $URL | awk -F'[=&]' '{print $2}')
	#echo $SYMBOL $TARGET $URL
	DATA_FILE=$TMP_D/$SYMBOL.html
	curl -o $DATA_FILE -s $URL
	#PRICE=$(curl -s "$URL" | grep -Eo '<span id=".*">.*</span>' | head -n 1 | awk -F "[><]" '/span/{print $3}')
	PRICE=$(grep -Eo '<span id=".*">.*</span>' $DATA_FILE | head -n 1 | awk -F "[><]" '/span/{print $3}')
	RANGE=''
	LOW52=''
	HIGH52=''
	parse_52week_range $SYMBOL RANGE LOW52 HIGH52 $DATA_FILE
	#echo $RANGE
	print_stock_list $SYMBOL $TARGET $PRICE "$RANGE" "$LOW52" "$HIGH52" $URL
	rm $DATA_FILE
	return;
}

printf "%s\t\t%s\t%s\t%s\t\t%s\n" "SYMBOL" "PRICE" "LOW52" "RANGE" "TARGET"

while IFS=';' read -r line
do
    name="$line"
    #echo "Name read from file - $name"
    fetch_stock_quotes $name
done < "$INPUT_FILE"

printf "</div>\n" >> $OUTPUT_F

# sudo systemctl start apache2.service
# bash launch browser
exit 0;
