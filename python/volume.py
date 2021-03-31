#!/usr/bin/python3

# python3 volume.py 2330
# get daily average volume for one year

import sys, requests, time
import urllib.request
from datetime import timedelta,datetime
from bs4 import BeautifulSoup

# last 12 months
today = datetime.today()
last_day = ""; first_day = ""; months = [];
months.append(today.strftime("%Y%m%d"))
for i in range(0,12):
    first_day = today.replace(day=1)
    last_day = first_day - timedelta(days=1)
    months.append(last_day.strftime("%Y%m%d"))
    today = last_day
# print("The Array is: ", months)
avg_shares = []
for i in range(0,12):
    url = 'https://www.twse.com.tw/exchangeReport/STOCK_DAY?response=html&date=' + months[i] + '&stockNo=' + sys.argv[1]
    # or
    # 'https://www.tpex.org.tw/web/stock/aftertrading/daily_trading_info/st43_print.php?l=zh-tw&d=110/02&stkno=1264&s=0,asc,0'
    response = requests.get(url)
    time.sleep(3)
    soup = BeautifulSoup(response.text, 'html.parser')
    n_row = 0; shares = 0;
    for tr in soup.findAll('tr')[2:]:
        tds = tr.findAll('td')
        shares += int(tds[1].text.replace(',', ''))
        n_row += 1
    shares /= n_row; avg_shares.append(int(shares))
    print( "daily avg# shares for " + months[i] + " is: " + "{:>10,}".format(avg_shares[i]))
print( "-----\ndaily avg# shares of " + sys.argv[1] + " for a year is: "
    + "{:>10,}".format(int(sum(avg_shares)/len(avg_shares))))
