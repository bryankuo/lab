#!/usr/bin/python3

# python3 announcement_today.py
# not serving anyone
# output (unique) mentioned tickers
# return 0: success

import sys, requests, os, time, webbrowser
import urllib.request
from datetime import timedelta,datetime
from dateutil.relativedelta import relativedelta
from bs4 import BeautifulSoup
from pprint import pprint

# ticker = sys.argv[1]
# https://mops.twse.com.tw/mops/web/stapap1_all
# board holdings, got valid data, 2 months earlier
the_day = datetime.today() # + relativedelta(months=-2)
yr      = str(int(the_day.strftime("%Y")) - 1911)
yr_c    = str(int(the_day.strftime("%Y")))
month   = the_day.strftime("%m")
day     = the_day.strftime("%d")
url = "https://mops.twse.com.tw/mops/web/t05st02"
data = {                                            \
    "step": 1, "step00": 0, "firstin": 1, "off": 1, \
    "year": yr, "month": month, "day": day }
# // TODO: "co_id": ticker, "TYPEK": "all", "SDAY": , "EDAY": , "DATE1":
# "SKEY": , "step": "2b"

DIR0="./datafiles/taiex/announcements"
if not os.path.exists(DIR0):
    os.mkdir(DIR0)
fname = yr_c + month + day + ".html"
path = os.path.join(DIR0, fname)

'''
response = requests.post(url, data)
soup = BeautifulSoup(response.text, 'html.parser')
outfile = open(path, "w")
outfile.write(soup.prettify())
outfile.close()
print("post req to {}".format(path))
'''

print("open {}".format(path))
fp = open(path, 'r')
soup = BeautifulSoup(fp, 'html.parser')
'''
    .find_all("table")[0] \
'''

div = soup.find_all("div", {"id": "table01"})
# print("# div {}".format(len(div)))

tables = soup.find_all("div", {"id": "table01"})[0] \
    .find_all("table")
# print("# tables {}".format(len(tables)))

trs = soup.find_all("div", {"id": "table01"})[0] \
    .find_all("table")[2] \
    .find_all("tr")
# print("# tbody {}".format(len(trs)))

tkrs = []
n_rows = len(trs)
for i in range(1, n_rows):
    tds = trs[i].find_all("td")
    dt  = tds[0].text.strip()
    tm  = tds[1].text.strip()
    tkr = int(tds[2].text.strip())
    # nm  =
    # topic =
    # print("{} {} {}".format(dt, tm, tkr))
    tkrs.append(tkr)

tkrs = set(tkrs)
print("{}{}{} announcment mentioned:".format(yr_c, month, day))
pprint("{}".format(tkrs))
# ready to scrap
# webbrowser.open("a.txt")
sys.exit(0)

# https://mops.twse.com.tw/mops/web/t51sb10_q1?co_id=1260&step=1&firstin=true&id&key&TYPEK&Stp=4&go=false&keyWord&kewWord2&year=112&month1=0&begin_day=1&end_day=1

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

# https://mops.twse.com.tw/mops/web/t05sr01_1
