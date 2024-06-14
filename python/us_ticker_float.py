#!/usr/bin/python3

# python3 us_ticker_float.py [ticker]
# scraping public float from internet file
#
# \param in     ticker symbol
# \param out    [ticker].html
# return 0

import sys, requests, time, os, numpy, random, csv
from bs4 import BeautifulSoup
from timeit import default_timer as timer
from datetime import timedelta,datetime
from pprint import pprint
import re
sys.path.append(os.getcwd())
import useragents as ua

if ( len(sys.argv) < 2 ):
    print("usage: us_ticker_float.py [ticker]")
    sys.exit(0)

ticker = sys.argv[1]

DIR0="./datafiles/usa/public.float"

if not os.path.exists(DIR0):
    os.mkdir(DIR0)

ofname1 = ticker + ".html"
html_path = os.path.join(DIR0, ofname1)

# url = "https://www.marketwatch.com/investing/stock/"+ticker
url = "https://www.marketwatch.com/investing/stock/" + ticker + "?mod=mw_quote_tab"
# // FIXME:
# fetch https://www.marketwatch.com/investing/stock/ccm?mod=mw_quote_tab
'''
b'<html><head><title>marketwatch.com</title><style>#cmsg{animation: A 1.5s;}@keyframes A{0%{opacity:0;}99%{opacity:0;}100%{opacity:1;}}</style></head><body style="margin:0"><p id="cmsg">Please enable JS and disable any ad blocker</p><script data-cfasync="false">var dd={\'rt\':\'c\',\'cid\':\'AHrlqAAAAAMA2TS8ar744H0AAatIwg==\',\'hsh\':\'D428D51E28968797BC27FB9153435D\',\'t\':\'fe\',\'s\':47891,\'e\':\'3f9d168fa96822b32c0d87716d52147e5d4ee74df1efd195dcddce6bbf57fa69\',\'host\':\'geo.captcha-delivery.com\'}</script><script data-cfasync="false" src="https://ct.captcha-delivery.com/c.js"></script></body></html>'
'''

print("fetch {}".format(url))
# response = requests.get(url)
headers = {'User-Agent': ua.list[4]}
response = requests.get(url, headers=headers)
print(response.content)

soup = BeautifulSoup(response.text, 'html.parser')
# print(soup.prettify())
outfile2 = open(html_path, "w", encoding='UTF-8')
outfile2.write(soup.prettify())
outfile2.close()
print("write to {}".format(html_path))

uls = soup.find_all("ul", {"class": "list list--kv list--col50"})
# print("# ul {}".format(len(uls)))
# pprint(uls[0])
so = uls[0].find_all("li")[4].find_all("span")[0].text
pf = uls[0].find_all("li")[5].find_all("span")[0].text
print("so {} pf {}".format(so, pf))
n_shares_so = 0; n_shares_pf = 0

if re.search('B', so, re.IGNORECASE):
    n_shares_so = float( so.replace('B','' ) ) * pow(10, 9)
elif re.search('M', so, re.IGNORECASE):
    n_shares_so = float( so.replace('M','' ) ) * pow(10, 6)
elif re.search('K', so, re.IGNORECASE):
    n_shares_so = float( so.replace('K','' ) ) * pow(10, 3)
else:
    n_shares_so = float( so ) * pow(10, 0)
print(f"share outstanding {n_shares_so:>10.0f}".format(n_shares_so))

if ( pf != "N/A" ):
    if re.search('B', pf, re.IGNORECASE):
        n_shares_pf = float( pf.replace('B','' ) ) * pow(10, 9)
    elif re.search('M', pf, re.IGNORECASE):
        n_shares_pf = float( pf.replace('M','' ) ) * pow(10, 6)
    elif re.search('K', pf, re.IGNORECASE):
        n_shares_pf = float( pf.replace('K','' ) ) * pow(10, 3)
    else:
        n_shares_pf = float( pf ) * pow(10, 0)
    print(f"public float      {n_shares_pf:>10.0f}".format(n_shares_pf))
else:
    print(f"public float      n/a")

# so=float(so.replace('B','').replace('M',''))
# pf=float(pf.replace('B','').replace('M',''))
r = float( n_shares_pf / n_shares_so )
print("publi float ratio  {:>9.3f}".format(r))

sys.exit(0)
