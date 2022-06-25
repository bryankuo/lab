#!/usr/bin/python3

# python3 derivative.py [ticker]
# return 0: success

import sys, requests, time, re, os, webbrowser
import urllib.request
from datetime import timedelta, datetime
from dateutil.relativedelta import relativedelta
from bs4 import BeautifulSoup
from pprint import pprint

# @see https://stackoverflow.com/a/66187139
def say(msg = "Finish", voice = "Victoria"):
    os.system(f'say -v {voice} {msg}')

ticker = sys.argv[1]

hbs30 = "datafiles/taiex/derivatives.txt" # download html
with open(hbs30) as fp:
    soup = BeautifulSoup(fp, 'html.parser')

'''
url = "https://www.taifex.com.tw/cht/2/stockLists"
print(url)
response = requests.get(url)
soup = BeautifulSoup(response.text, 'html.parser')
'''

if ( soup is None ):
    print("n\a")
# print(soup.prettify()) # be aware, less frequent access

ths = soup \
    .findAll("table", class_="fancyTable")[0] \
    .find_all('thead')[0] \
    .find_all('tr')[0] \
    .find_all('th')

# print(len(tr0))
# pprint(ths)
# print(len(ths))
title = ""
content = ""
has_future = 0
has_option = 0
for i in range(0, len(ths)):
    title = title + \
        ths[i].text.replace('\n','').replace(' ','').strip()[0:5] + ":"
title = title[:len(title)-1]
# print( title )

trs = soup \
    .findAll("table", class_="fancyTable")[0] \
    .find_all('tbody')[0] \
    .find_all('tr')
# print(len(trs))
# pprint(trs)
for i in range(0, len(trs)-1):
    tds = trs[i].find_all('td')
    tkr = tds[2].text.replace('\n','').replace(' ','').strip()
    if ( tkr == ticker ):
        # for i in range(0, len(tds)):
        #    content = content + \
        #        tds[i].text.replace('\n','').replace(' ','').strip() + ":"
        # content = content[:len(content)-1]
        # print(content)
        say(ticker)
        future = tds[4].text.replace('\n','').replace(' ','').strip()
        if ( 0 < len(future) ):
            has_future = 1
            say(future, "Mei-Jia")
        option = tds[5].text.replace('\n','').replace(' ','').strip()
        if ( 0 < len(option) ):
            has_future = 1
            say(option, "Mei-Jia")

sys.exit(0)
