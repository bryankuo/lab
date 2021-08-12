#!/usr/bin/python3

# python3 annual_report.py 2330
# return 0: success

import sys, requests, time, webbrowser
import urllib.request
from datetime import timedelta,datetime
from dateutil.relativedelta import relativedelta
from bs4 import BeautifulSoup

ticker = sys.argv[1]
# https://mops.twse.com.tw/mops/web/stapap1_all
# board holdings, got valid data, 2 months earlier
the_day = datetime.today() + relativedelta(months=-2)
yr = str(int(the_day.strftime("%Y")) - 1911)
month = the_day.strftime("%m")

url = "https://doc.twse.com.tw/server-java/t57sb01?" + \
    "step=1&colorchg=1&co_id="+ticker+"&year="+yr+"&mtype=F&"
webbrowser.open(url)
sys.exit(0)

# quarterly report:
# https://doc.twse.com.tw/server-java/t57sb01?step=1&colorchg=1&co_id=6189&year=109&seamon=2&mtype=A&
