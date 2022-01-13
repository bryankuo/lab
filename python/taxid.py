#!/usr/bin/python3

# python3 taxid.py
# return 0

import sys, requests, time
import urllib.request
from datetime import timedelta,datetime
from bs4 import BeautifulSoup

ticker = sys.argv[1]
title = sys.argv[2]
url = "https://www.findcompany.com.tw/"+title

try:
    response = requests.get(url)
    soup = BeautifulSoup(response.text, 'html.parser')
    taxid = soup.find_all("table", id='basic-data')[0] \
        .find_all("tr")[0] \
        .find_all("td")[1].text.strip()
    if ( taxid is not None ):
        # print(taxid)
        olist = [ taxid ]
        print(olist)
    else:
        print("")
# except (IndexError):
    # print('not listed.')

finally:
    sys.exit(0)
