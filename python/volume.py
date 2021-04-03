#!/usr/bin/python3

# python3 volume.py 2330
# get listed daily average volume for one year
# return 0: not found, assume otc

import sys, requests, time
import urllib.request
from datetime import timedelta,datetime
from bs4 import BeautifulSoup

# last 12 months
today = datetime.today()
last_day = ""; first_day = ""; months = []; avg_shares = [];

for i in range(0,12):
    if ( i == 0 ):
        last_day = today
    else:
        first_day = today.replace(day=1)
        last_day = first_day - timedelta(days=1)
    months.append(last_day.strftime("%Y%m%d"))
    today = last_day

url = 'https://www.twse.com.tw/exchangeReport/STOCK_DAY?response=html&date=' + months[0] + '&stockNo=' + sys.argv[1]
response = requests.get(url)
soup = BeautifulSoup(response.text, 'html.parser')
table_body = soup.find('tbody')
if ( table_body is None ):
    sys.exit(1)
rows = table_body.findAll('tr')
if ( len(rows) <= 0 ):
    sys.exit(2)

for i in range(0,12):
    n_rows = 0; shares = 0
    url = 'https://www.twse.com.tw/exchangeReport/STOCK_DAY?response=html&date=' + months[i] + '&stockNo=' + sys.argv[1]
    response = requests.get(url)
    soup = BeautifulSoup(response.text, 'html.parser')
    table_body = soup.find('tbody')
    for tr in soup.findAll('tr')[2:]:
        tds = tr.findAll('td')
        shares += int(tds[1].text.replace(',', ''))
        n_rows += 1
    shares /= n_rows; avg_shares.append(int(shares))
    print( "daily avg# shares for " + months[i] + " is: " + "{:>10,}".format(avg_shares[i]))
    time.sleep(2)

print("----- for the past year :")
print( "daily avg# shares of " + sys.argv[1] + " is: "
    + "{:>10,}".format(int(sum(avg_shares)/len(avg_shares))))

sys.exit(0)
