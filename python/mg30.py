#!/usr/bin/python3

# python3 mg30.py [ticker]
# to tell consequtive buy or sell
# \param in manual buy and sell record
# return 0: success

import sys, requests, time, re, os, webbrowser
import urllib.request
from datetime import timedelta, datetime
from dateutil.relativedelta import relativedelta
from bs4 import BeautifulSoup
from pprint import pprint

tbl = []
title = []
net_m   = [ 0, 0, 0, 0, 0 ]
net_d   = [ 0, 0, 0, 0, 0 ]
latch   = [ 0, 0, 0, 0, 0 ]
sample = 0
MAX_SAMPLE = 7
def latch_consequtive_bs(amount, index):
    if not latch[index]:
        # amount = int( tds[index].text.strip() )
        if ( 0 < amount and 0 <= net_m[index] and net_d[index] <= 0 ):
            net_m[index] += 1
        elif ( amount < 0 and 0 <= net_d[index] and net_m[index] <= 0 ):
            net_d[index] += 1
        else:
            latch[index] = 1

# @see https://stackoverflow.com/a/66187139
def say(msg = "Finish", voice = "Victoria"):
    os.system(f'say -v {voice} {msg}')

ticker = sys.argv[1]

mg30 = "datafiles/mg30.txt" # download html
with open(mg30) as fp:
    soup = BeautifulSoup(fp, 'html.parser')

'''
url = "https://histock.tw/stock/chips.aspx?no="+ticker+"&m=mg"
# print(url)
response = requests.get(url)
soup = BeautifulSoup(response.text, 'html.parser')
'''

if ( soup is None ):
    print("n\a")
# print(soup.prettify()) # be aware, less frequent access

tr1 = soup \
    .findAll("table", class_="tb-stock tbChip nofade")[0] \
    .find_all('tr')

tr2 = soup \
    .findAll("table", class_="tb-stock tbChip fade")[0] \
    .find_all('tr')

tr3 = soup \
    .findAll("table", class_="tb-stock tbChip fade")[1] \
    .find_all('tr')

if ( len(tr1) <=0 or len(tr2) <=0 or len(tr3) <=0 ):
    print("tables not found")

ths = tr1[0].find_all('th')
title.append( ths[0].text.replace('\n','').strip().center(6," ") )
title.append( ths[1].text.replace('\n','').strip().center(6," ") )
title.append( ths[2].text.replace('\n','').strip().center(6," ") )

ths2 = tr2[0].find_all('th')
title.append( ths2[2].text.replace('\n','').strip().center(6," ") )

ths3 = tr3[0].find_all('th')
title.append( ths3[1].text.replace('\n','').strip().center(6," ") )
tbl.append(title)
tbl.append(net_m)
tbl.append(net_d)
tbl.append(latch)

for i in range(2, 2+MAX_SAMPLE):
    tds1 = tr1[i].find_all('td')
    tds2 = tr2[i].find_all('td')

    row = []
    row.append(tds1[0].text.strip())
    row.append(tds1[1].text.strip().rjust(6," "))
    row.append(tds1[4].text.strip().rjust(6," "))
    row.append(tds2[11].text.strip().rjust(6," "))
    tbl.append(row)

for i in range(1, 1+MAX_SAMPLE):
    tds3 = tr3[i].find_all('td')
    tbl[3+i].append(tds3[1].text.strip().rjust(6," "))

for i in range(4, 4+MAX_SAMPLE):
    for j in range(1, len(tbl[4])):
        latch_consequtive_bs( \
            int( tbl[i][j].replace(',','').strip() ), j)

pprint(tbl)

for i in range(0, len(tbl[0])):
    if ( 3 <= tbl[1][i] ):
        msg = title[i] + "連" + str(net_m[i]) + "增"
        say(msg, "Mei-Jia")
    if ( 3 <= tbl[2][i] ):
        msg = title[i] + "連" + str(net_d[i]) + "減"
        say(msg, "Mei-Jia")

# // TODO: check if in the list
# https://www.wantgoo.com/stock/public-bank/buy-sell?market=-1&orderBy=count&during=5&industry=
#

sys.exit(0)
