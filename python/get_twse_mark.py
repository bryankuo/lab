#!/usr/bin/python3

# python3 get_twse_mark.py
# return 0

import sys, requests, time
import urllib.request
from datetime import timedelta,datetime
from bs4 import BeautifulSoup

DIR0="."
url = "https://histock.tw/tw"
fname = DIR0 + "/" + "a.html"
is_from_net = False # True

if ( is_from_net ):
    response = requests.get(url)
    # response.encoding = 'cp950'
    soup = BeautifulSoup(response.text, 'html.parser')
    with open(fname, "w") as outfile2:
        outfile2.write(soup.prettify())
        outfile2.close()
else:
    with open(fname) as q:
        soup = BeautifulSoup(q, 'html.parser')
# print(soup.prettify())
deal = soup.find_all("li", {"class": "deal"})[0] \
        .find_all("span", {"class": "fwbig"})[0].text.strip().replace(',', '')
print(deal)
change = soup.find_all("li", {"class": "change"})[0] \
        .find_all("span", {"class": "fwbig price-up"})[0].text.strip().replace(',', '')
print(change)
rise = soup.find_all("li", {"class": "rise"})[0] \
        .find_all("span", {"class": "fwbig"})[0].text.strip().replace(',', '')
print(rise)
volume = soup.find_all("li", {"class": "volume"})[0] \
        .find_all("span", {"class": "fwbig"})[0].text.strip().replace(',', '')
print(volume)

sys.exit(0)

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
