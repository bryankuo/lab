#!/usr/bin/python3

# python3 us_ticker_institutional_holding.py [ticker]
# scraping from file fetched and compare with twse in rs
# \param in     YYYYMMDD.html
# \param in     YYYYMMDD.full.csv
# \param out    quote, volume, RS wrt. TWSE
# return 0

import sys, requests, time, os, numpy, random, csv
from bs4 import BeautifulSoup
from timeit import default_timer as timer
from datetime import timedelta,datetime
from pprint import pprint

if ( len(sys.argv) < 2 ):
    print("usage: us_ticker_institutional_holding.py [ticker]")
    sys.exit(0)

ticker = sys.argv[1]

DIR0r="./datafiles/taiex/rs"
DIR0a="./datafiles/taiex/after.market"

url = "https://fintel.io/so/us/"+ticker
print(url)
# response = requests.get(url)
# headers = {'User-Agent': random.choice(ua.list)}
# response = requests.get(url, headers=headers)
response = requests.get(url)
soup = BeautifulSoup(response.text, 'html.parser')
html_path = ticker + ".iholding.html"
# print(soup.prettify())
outfile2 = open(html_path, "w", encoding='UTF-8')
outfile2.write(soup.prettify())
outfile2.close()
print(html_path)
tbs = soup.find_all("table", {"class": "table table-sm"})
print("# tb {}".format(len(tbs)))

if ( 3 <= len(tbs) ):
    ih = tbs[1] \
        .find_all("tbody")[0] \
        .find_all("tr")[0] \
        .find_all("td")[1].text
    print(ih)
else:
    print("n/a")

sys.exit(0)
