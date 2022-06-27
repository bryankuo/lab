#!/usr/bin/python3

# python3 hbs30.py [ticker]
# return 0: success

import sys, requests, time, re, os, webbrowser
import urllib.request
from datetime import timedelta, datetime
from dateutil.relativedelta import relativedelta
from bs4 import BeautifulSoup
from pprint import pprint

tbl = []
title = []
net_b   = [ 0, 0, 0, 0, 0, 0 ]
net_s   = [ 0, 0, 0, 0, 0, 0 ]
latch   = [ 0, 0, 0, 0, 0, 0 ]
sample = 0
MAX_SAMPLE = 7
def latch_consequtive_bs(amount, index):
    if not latch[index]:
        # amount = int( tds[index].text.strip() )
        if ( 0 < amount and 0 <= net_b[index] and net_s[index] <= 0 ):
            net_b[index] += 1
        elif ( amount < 0 and 0 <= net_s[index] and net_b[index] <= 0 ):
            net_s[index] += 1
        else:
            latch[index] = 1

# @see https://stackoverflow.com/a/66187139
def say(msg = "Finish", voice = "Victoria"):
    os.system(f'say -v {voice} {msg}')

ticker = sys.argv[1]

'''
hbs30 = "datafiles/hbs30.txt" # download html
with open(hbs30) as fp:
    soup = BeautifulSoup(fp, 'html.parser')
'''

url = "https://histock.tw/stock/chips.aspx?no="+ticker
# print(url)
response = requests.get(url)
soup = BeautifulSoup(response.text, 'html.parser')

if ( soup is None ):
    print("n\a")
# print(soup.prettify()) # be aware, less frequent access

# https://stackoverflow.com/a/22284921
tr0 = soup \
    .findAll("table", class_="tb-stock tbChip w50p pr0")[0] \
    .find_all('tr')
tr1 = soup \
    .find_all("table", {"class": "tb-stock tbChip w50p"})[0] \
    .find_all('tr')

if ( len(tr0) <=0 or len(tr1) <= 0 ):
    print("table not found")

ths = tr0[0].find_all('th')
title.append( ths[0].text.replace('\n','').strip() )
title.append( ths[1].text.replace('\n','').strip() )
title.append( ths[2].text.replace('\n','').strip() )
title.append( ths[3].text.replace('\n','').replace(' ','').strip() )
title.append( ths[4].text.replace('\n ','').replace(' ','').strip() )
title.append( ths[5].text.replace('\n','').strip() )
tbl.append(title)

for i in range(1, len(tr0)):
    tds = tr0[i].find_all('td')
    row = []
    row.append(tds[0].text.strip())
    row.append(tds[1].text.strip())
    row.append(tds[2].text.strip())
    row.append(tds[3].text.strip())
    row.append(tds[4].text.strip())
    row.append(tds[5].text.strip())
    if ( sample < MAX_SAMPLE ):
        '''
        fdi = int( tds[1].text.strip() )
        latch_consequtive_bs(fdi, 1)
        fund = int( tds[2].text.strip() )
        latch_consequtive_bs(fund, 2)
        retail = int( tds[3].text.strip() )
        latch_consequtive_bs(retail, 3)
        delta    = int( tds[4].text.strip() )
        latch_consequtive_bs(delta, 4)
        subtotal = int( tds[5].text.strip() )
        latch_consequtive_bs(subtotal, 5)
        '''
        for j in range(1, len(title)):
            latch_consequtive_bs( \
                int( tds[j].text.replace(',','').strip() ), j)
        sample += 1
    tbl.append(row)

for i in range(1, len(tr0)):
    tds = tr1[i].find_all('td')
    row = []
    row.append(tds[0].text.strip())
    row.append(tds[1].text.strip())
    row.append(tds[2].text.strip())
    row.append(tds[3].text.strip())
    row.append(tds[4].text.strip())
    row.append(tds[5].text.strip())
    tbl.append(row)

print(*net_b)
print(*net_s)
print(*latch)
pprint(tbl)
for i in range(0, len(net_b)):
    if ( 3 < net_b[i] ):
        msg = title[i].replace('(','').replace(')','') + \
            "連" + str(net_b[i]) + "買"
        say(msg, "Mei-Jia")
for i in range(0, len(net_s)):
    if ( 3 < net_s[i] ):
        msg = title[i].replace('(','').replace(')','') + \
            "連" + str(net_b[i]) + "賣"
        say(msg, "Mei-Jia")

# // TODO: check if in the list
# https://www.wantgoo.com/stock/public-bank/buy-sell?market=-1&orderBy=count&during=5&industry=
#
sys.exit(0)
