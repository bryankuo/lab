#!/usr/bin/python3

# python3 get_listed.py [type]

# input:
# https://isin.twse.com.tw/isin/C_public.jsp?strMode=2
# 本國上市證券國際證券辨識號碼一覽表
# https://isin.twse.com.tw/isin/C_public.jsp?strMode=4
# 本國上櫃證券國際證券辨識號碼一覽表
# https://isin.twse.com.tw/isin/C_public.jsp?strMode=5
# 本國興櫃證券國際證券辨識號碼一覽表

# return : num of line

import sys, requests, time, re, os
import urllib.request
from datetime import timedelta,datetime
from bs4 import BeautifulSoup

mode = sys.argv[1]
if mode not in ['2', '4', '5']:
    print('invlid option')
    sys.exit(-1)

url = 'https://isin.twse.com.tw/isin/C_public.jsp?strMode=' + mode
response = requests.get(url)
soup = BeautifulSoup(response.text, 'html.parser')
rows = soup.findAll('table')[1].find_all('tr')
if ( rows is None ):
    print("not found")
    sys.exit(-2)
count = 0
file_name = 'datafiles/listed_' + mode + '.txt'
with open(file_name, 'w') as the_file:
    for tr in rows:
        symbol = tr.find_all('td')[0].text.split()[0]
        if len(symbol) == 4 and symbol.isdigit():
            # print(symbol)
            the_file.write(symbol+'\n')
            count += 1
the_file.close()
n_rows = str(count)
print(n_rows)
sys.exit(0)
