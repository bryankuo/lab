#!/usr/bin/python3

# python3 volume.py [ticker]
# get listed daily average volume for one year
# return 0: not found, assume otc

import sys, requests, time
import urllib.request
from datetime import timedelta,datetime
from bs4 import BeautifulSoup

print(sys.argv[1] + " daily average volume for the past year:")

# last 12 months
today = datetime.today()
last_day = ""; first_day = "";
n_rows = [None] * 12; months = []; avg_shares = [];

for i in range(0,12):
    if ( i == 0 ):
        last_day = today
        print(last_day)
    else:
        first_day = today.replace(day=1)
        last_day = first_day - timedelta(days=1)
    months.append(last_day.strftime("%Y%m%d"))
    today = last_day

for i in range(0,12):
    n_rows[i] = 0; shares = 0
    url = 'https://www.twse.com.tw/exchangeReport/STOCK_DAY?' + \
        'response=html&date=' + months[i] + '&stockNo=' + sys.argv[1]
    # print(url)
    response = requests.get(url)
    soup = BeautifulSoup(response.text, 'html.parser')
    table_body = soup.find('tbody')
    if ( table_body is not None ):
        for tr in soup.findAll('tr')[2:]:
            tds = tr.findAll('td')
            shares += int(tds[1].text.replace(',', ''))
            n_rows[i] += 1
        if ( 0 < n_rows[i] ):
            shares /= n_rows[i];
            avg_shares.append(int(shares))
            # the_shares = i"{avg_shares[i]:>10}"
            print( "     " + months[i] + ": " \
                + "{:>10,}".format(avg_shares[i]))
                # + the_shares )
        else:
            print("no data for " + months[i])
    else:
        avg_shares.append(0)
        print("no data for " + months[i])
    time.sleep(1)

print("     --------")
print("     average : " \
    + "{:>10,}".format(int(sum(avg_shares)/len(avg_shares))))
sys.exit(0)
