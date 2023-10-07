#!/usr/bin/python3

# python3 volume_otc.py 2330
# get otc daily average volume for one year
# return 0: not found, assume neither listed nor otc, semi-otc?

import sys, requests, time
import urllib.request
from datetime import timedelta,datetime
from bs4 import BeautifulSoup

print(sys.argv[1] + " daily average volume for the past year:")

# last 12 months
today = datetime.today()
last_day = ""; first_day = "";
months0 = []; months = []; avg_shares = [];

# fill in last day of past 12 months
for i in range(0,12):
    if ( i == 0 ):
        last_day = today
    else:
        first_day = today.replace(day=1)
        last_day = first_day - timedelta(days=1)
    months0.append(last_day.strftime("%Y/%m"))
    today = last_day

for i in range(0,12):
    tw_year = int(months0[i][0:4]) - 1911
    months.append( str(tw_year) + months0[i][4:7] )
# print("The Array is: ", months)

url = 'https://www.tpex.org.tw/web/stock/aftertrading/daily_trading_info/st43_print.php?l=zh-tw&d=' + months[0]+ '&stkno=' + sys.argv[1] + '&s=0,asc,0'
# print(url)
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
    url = 'https://www.tpex.org.tw/web/stock/aftertrading' \
        '/daily_trading_info/st43_print.php?l=zh-tw&d=' + months[i] + \
        '&stkno=' + sys.argv[1] + '&s=0,asc,0'
    response = requests.get(url)
    soup = BeautifulSoup(response.text, 'html.parser')
    table_body = soup.find('tbody')
    rows = table_body.find_all('tr')
    for row in rows:
        tds = row.find_all('td')
        if "," not in tds[1].text:
            shares += int(tds[1].text)
        else:
            shares += int(tds[1].text.replace(',', ''))
        n_rows += 1
    shares /= n_rows; avg_shares.append(int(shares))
    print( "     " + months[i] + "  : " \
            + "{:>6,}".format(avg_shares[i]) + " lots")
    time.sleep(2)
print("     --------")
print("     average : " \
    + "{:>6,}".format(int(sum(avg_shares)/len(avg_shares))) + " lots")
sys.exit(0)
