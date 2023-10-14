#!/usr/bin/python3

# python3 gbank_histock.py [ticker]
# get government bank activities
# return 0: success

import sys, requests, time
import urllib.request
from datetime import timedelta,datetime
from bs4 import BeautifulSoup
from pprint import pprint
from selenium import webdriver


ticker = sys.argv[1]
# fname = DIR0 + "/" + "fund."+yyyy+mm+dd+".html"
fname = ticker+".html"

# source 1, term "上市官股券商動向", sorted by type 2, type 4, and total
# http://www.money-link.com.tw/stxba/imwcontent0.asp?page=hott3&ID=HOTT3&menusub=2&app=
# url = "http://www.money-link.com.tw/stxba/imwcontent0.asp?page=hott3&ID=HOTT3&menusub=2&app="
#
# src 2: by ticker, date
# https://histock.tw/stock/broker.aspx?no=1402

'''
url = "https://histock.tw/stock/broker.aspx?no="+ticker
browser = webdriver.Safari( \
    executable_path = '/usr/bin/safaridriver')
browser.get(url)
time.sleep(1)

page = browser.page_source
soup = BeautifulSoup(page, 'html.parser')
with open(fname, "w") as outfile2:
    outfile2.write(soup.prettify())
    outfile2.close()
browser.quit()
'''
with open(fname) as f:
    soup = BeautifulSoup(f, 'html.parser')

lst = soup.find_all("div", {"id": "chartInfo_Broker8"})[0]
# pprint(lst)
date     = lst.find_all('li')[0].text.strip()

# cols     = lst.find_all('li')[1].text.replace(' ','').replace('\n','').strip()
bk_name  = lst.find_all('li')[1] \
            .find_all('div')[0].text.replace(' ','').replace('\n','').strip()
vol      = lst.find_all('li')[1] \
            .find_all('div')[1].text.replace(' ','').replace('\n','').strip()
amount   = lst.find_all('li')[1] \
            .find_all('div')[2].text.replace(' ','').replace('\n','').strip()


# summ    = lst.find_all('li')[10].text.replace(' ','').replace('\n','').strip()
summ     = lst.find_all('li')[10] \
            .find_all('div')[0].text.replace(' ','').replace('\n','').strip()
s_vol    = lst.find_all('li')[10] \
            .find_all('div')[1].text.replace(' ','').replace('\n','').strip()
s_amount = lst.find_all('li')[10] \
            .find_all('div')[2].text.replace(' ','').replace('\n','').strip()

print(date)
print(bk_name+" "+vol+" "+amount)
print(summ+" "+s_vol+" "+s_amount)

sys.exit(0)
