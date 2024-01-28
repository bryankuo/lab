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

DIR0="./datafiles/usa/institutional.holdings"

if not os.path.exists(DIR0):
    os.mkdir(DIR0)

ofname1 = ticker + ".html"
html_path = os.path.join(DIR0, ofname1)

url = "https://fintel.io/so/us/"+ticker
print("fetch {}".format(url))
# response = requests.get(url)
# headers = {'User-Agent': random.choice(ua.list)}
# response = requests.get(url, headers=headers)
response = requests.get(url)
soup = BeautifulSoup(response.text, 'html.parser')
# print(soup.prettify())
outfile2 = open(html_path, "w", encoding='UTF-8')
outfile2.write(soup.prettify())
outfile2.close()
print("write to {}".format(html_path))
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
