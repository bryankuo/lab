#!/usr/bin/python3

# python3 get_market_capital.py
# return 0

import sys, requests, time
import urllib.request
from datetime import timedelta,datetime
from bs4 import BeautifulSoup

url = "https://stock.capital.com.tw/z/zm/zmd/zmdb.djhtm"
response = requests.get(url)
response.encoding = 'cp950'
soup = BeautifulSoup(response.text, 'html.parser')
# print(soup.prettify())
rows = soup.find_all("table", {"class": "t01"})[0] \
        .find_all("tr")
for i in range(1, len(rows)):
    ticker = rows[i].find_all('td')[0].text.strip()
    cap = rows[i].find_all('td')[1].text
    weight = rows[i].find_all('td')[2].text
    acc_weight = rows[i].find_all('td')[3].text
    beta = rows[i].find_all('td')[4].text
    e_beta = rows[i].find_all('td')[5].text
    f_beta = rows[i].find_all('td')[6].text
    print( \
        ticker + ":" + \
        cap + ":" + \
        weight + ":" + \
        acc_weight + ":" + \
        beta + ":" + \
        e_beta + ":" + \
        f_beta )

sys.exit(0)
