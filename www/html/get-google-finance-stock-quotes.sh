#!/bin/bash
# usage: ./get-google-finance-stock-quotes.sh "https://www.google.com/finance?q=NYSE%3ABABA&ei=POEBWLHRM9iL0gS3xJ7IDg", url with quote (prevent bg)
#URL="https://www.google.com/finance?q=NYSE%3AJPM&ei=D03-V9CvH5GH0gTl3pCYAw"
URL=$1
YELLOW='\e[93m'
OUTPUT_F="latest_quotes.html"
printf "<div id=\"css_table\">\n" > $OUTPUT_F
printf "\t<div class=\"css_tr\">\n" >> $OUTPUT_F
printf "\t\t<div class=\"css_td\" style=\"width: 150px;\">symbol</div>\n" >> $OUTPUT_F
printf "\t\t<div class=\"css_td\">price</div>\n" >> $OUTPUT_F
printf "\t\t<div class=\"css_td\">target</div>\n" >> $OUTPUT_F
printf "\t\t<div class=\"css_td\" style=\"width: 150px;\">52 week</div>\n" >> $OUTPUT_F
printf "\t</div>\n" >> $OUTPUT_F

#echo -e "$(curl -s "$URL" | grep -Eo '<span id=".*">.*</span>' | head -n 1 | awk -F "[><]" '/span/{print $3}' )" | tee latest_quotes.html;

printf "</div>\n" >> $OUTPUT_F
exit 0;
