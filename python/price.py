#!/usr/bin/python3

# python3 price.py [ticker] [yyyymmdd]
# get ticker close price by date
# \param in
# \param in
# \param out downloaded html
# return 0: success

import sys, requests, time, os
import urllib.request
from datetime import timedelta,datetime
from bs4 import BeautifulSoup

# source
# https://www.twse.com.tw/exchangeReport/STOCK_DAY?response=html&date=20231007&stockNo=1102

DIR0="./datafiles/taiex" # consider compatible with rank.sh
fname = "price."+sys.argv[1]+"."+sys.argv[2]+".html"
path = os.path.join(DIR0, fname)

# n_rows[i] = 0; shares = 0
url = 'https://www.twse.com.tw/exchangeReport/STOCK_DAY?' + \
    'response=html&date=' + sys.argv[2] + '&stockNo=' + sys.argv[1]
# print(url)
response = requests.get(url)
soup = BeautifulSoup(response.text, 'html.parser')

with open(path, "w") as outfile:
    outfile.write(soup.prettify())
outfile.close()
sys.exit(0) # // TODO: verify
'''
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

print("     --------")
print("     average : " \
    + "{:>10,}".format(int(sum(avg_shares)/len(avg_shares))))
'''
sys.exit(0)
