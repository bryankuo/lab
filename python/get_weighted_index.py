#!/usr/bin/python3

# python3 get_weighted_index.py
# return 0

import sys, requests, time
import urllib.request
from datetime import timedelta,datetime
from bs4 import BeautifulSoup

url = "https://pchome.megatime.com.tw/market/sto0"
data = { \
    "is_check": 1 }
response = requests.post(url, data)
soup = BeautifulSoup(response.text, 'html.parser')
# print(soup)

rows = soup.find_all("table", {"id": "catalog_stock_list"})[0] \
        .find_all("tr")
# print(rows)
# print(rows[3].find_all('td')[0].text)
# sys.exit(0)

for i in range(3, len(rows)-2):
    sector     = rows[i].find_all('td')[0].text
    percentage = rows[i].find_all('td')[4].text
    print( \
        sector + " " + \
        percentage )
sys.exit(0)
