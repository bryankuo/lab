#!/usr/bin/python3

# python3 get_twse_mark.py
# return 0

import sys, requests, time, os
import urllib.request
from datetime import timedelta,datetime
from bs4 import BeautifulSoup

url = "https://histock.tw/tw"
DIR0="."
fname = "a.html"
path = os.path.join(DIR0, fname)
is_from_net = True #False # True
# // TODO: date input

if ( is_from_net ):
    response = requests.get(url)
    # response.encoding = 'cp950'
    soup = BeautifulSoup(response.text, 'html.parser')
    with open(path, "w") as outfile2:
        outfile2.write(soup.prettify())
        outfile2.close()
else:
    with open(path) as q:
        soup = BeautifulSoup(q, 'html.parser')

# print(soup.prettify())
deal = soup.find_all("li", {"class": "deal"})[0] \
        .find_all("span", {"class": "fwbig"})[0].text.strip().replace(',', '')
#print(deal)
change = soup.find_all("li", {"class": "change"})[0] \
        .find_all("span", {"class": "fwbig price-up"})[0].text.strip().replace(',', '')
#print(change)
rise = soup.find_all("li", {"class": "rise"})[0] \
        .find_all("span", {"class": "fwbig"})[0].text.strip().replace(',', '')
#print(rise)
volume = soup.find_all("li", {"class": "volume"})[0] \
        .find_all("span", {"class": "fwbig"})[0].text.strip().replace(',', '')
#print(volume)
olist = [ deal, change, rise, volume ]
print(olist)

os.remove(path)
sys.exit(0)
