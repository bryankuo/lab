#!/usr/bin/python3

# python3 get_twse_mark.py
# get twse mark from net
# \param out
# return 0

import sys, requests, time, os, random
import urllib.request
from datetime import timedelta,datetime
from bs4 import BeautifulSoup
sys.path.append(os.getcwd())
import useragents as ua

url = "https://histock.tw/tw"
DIR0="./datafiles/taiex"
fname = "mark." + datetime.today().strftime('%Y%m%d') + ".csv"
path = os.path.join(DIR0, fname)

# response = requests.get(url)
headers = {'User-Agent': random.choice(ua.list)}
response = requests.get(url, headers=headers)
# response.encoding = 'cp950'
soup = BeautifulSoup(response.text, 'html.parser')
# print(soup.prettify())

deal = soup.find_all("li", {"class": "deal"})[0] \
        .find_all("span", {"class": "fwbig"})[0].text.strip().replace(',', '')
change = soup.find_all("li", {"class": "change"})[0] \
        .find_all("span", {"class": "fwbig price-up"})[0].text.strip().replace(',', '')
rise = soup.find_all("li", {"class": "rise"})[0] \
        .find_all("span", {"class": "fwbig"})[0].text.strip().replace(',', '')
volume = soup.find_all("li", {"class": "volume"})[0] \
        .find_all("span", {"class": "fwbig"})[0].text.strip().replace(',', '')
olist = [ float(deal), change, rise, float(volume) ]

# // TODO: grep later
with open(path, "w") as outf:
    outf.write(deal + ":" + change + ":" + rise + ":" + volume + "\n")
outf.close()

print(olist)
sys.exit(0)
