#!/usr/bin/python3

# python3 announcement.py 2330
# serving briefing.sh
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

# url = "https://mops.twse.com.tw/mops/web/ajax_stapap1"
# data = {
#    "firstin": "true", "year": "110", "month": "03", \
#    "co_id": ticker, "TYPEK": "sii", "step": 0}
# response = requests.post(url, data)
# soup = BeautifulSoup(response.text, 'html.parser')
# print(soup.prettify())
# ready to scrap

#
# https://mops.twse.com.tw/mops/web/t146sb10
# https://mops.twse.com.tw/mops/web/t05st01
# https://mops.twse.com.tw/mops/web/t51sb10_q1
# https://mops.twse.com.tw/mops/web/t51sb10_q1?co_id=1101&step=1&firstin=false&id&key&TYPEK&Stp=4&go=false&keyWord&kewWord2&year=110&month1=0&begin_day=1&end_day=1;
# https://mops.twse.com.tw/mops/web/t51sb10_q1?co_id=8478&step=1&firstin=true&id&key&TYPEK&Stp=4&go=false&keyWord&kewWord2&year=110&month1=0&begin_day=1&end_day=1
url = 'https://mops.twse.com.tw/mops/web/t51sb10_q1?co_id='+ticker+'&step=1&firstin=true&id&key&TYPEK&Stp=4&go=false&keyWord&kewWord2&year='+yr+'&month1=0&begin_day=1&end_day=1';
# print(url)
# form1.action='/mops/web/ajax_t51sb10';ajax1(this.form,'table01');
# // TODO: passing ticker and year as arguments
webbrowser.open(url)
sys.exit(0)
