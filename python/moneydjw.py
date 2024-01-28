#!/usr/bin/python3

# python3 moneydjw.py
# scraping from file fetched and compare with twse in rs
# \param in     YYYYMMDD.html
# \param out    quote, volume, RS wrt. TWSE
# return 0

import sys, requests, time, os, numpy, random, csv
from bs4 import BeautifulSoup
from timeit import default_timer as timer
from datetime import timedelta,datetime
from pprint import pprint

# url = "https://www.moneydj.com/warrant/xdjhtm/default.xdjhtm"

# warrant portal
# https://www.moneydj.com/warrant/xdjhtm/default.xdjhtm # not getting table
# url = "https://www.moneydj.com/warrant/xdjhtm/Quote.xdjhtm" # table n/a
# https://www.moneydj.com/warrant/xdjhtm/Rank.xdjhtm?a=01
url = "https://www.moneydj.com/warrant/xdjhtm/Rank.xdjhtm?a=04"

print("fetch {}".format(url))
# response = requests.get(url)
# headers = {'User-Agent': random.choice(ua.list)}
# response = requests.get(url, headers=headers)
response = requests.get(url)
response.encoding = 'utf-8'
soup = BeautifulSoup(response.text, 'html.parser')
# print(soup.prettify())
html_path = "moneydjw.html"
# outfile2 = open(html_path, "w", encoding='UTF-8')
outfile2 = open(html_path, "w")
outfile2.write(soup.prettify())
outfile2.close()
print("write to {}".format(html_path))

sys.exit(0)

