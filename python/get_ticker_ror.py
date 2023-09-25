#!/usr/bin/python3

# python3 get_ticker_ror.py [ticker]
# scraping from file fetched.
# return 0

'''
import sys, requests, time, os
import urllib.request
from datetime import timedelta,datetime
from bs4 import BeautifulSoup
'''

import sys, requests, time, os, numpy, random, csv
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.common.exceptions import SessionNotCreatedException
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import Select
from timeit import default_timer as timer
from datetime import timedelta,datetime
from pprint import pprint

# twse history
# https://www.twse.com.tw/rwd/zh/TAIEX/MI_5MINS_HIST?date=20230701&response=html
# https://goodinfo.tw/tw/StockIdxDetail.asp?STOCK_ID=%E5%8A%A0%E6%AC%8A%E6%8C%87%E6%95%B8
# https://www.macromicro.me/charts/36436/tai-wan-gu-shi-da-pan-zhi-shu-bao-chou-lyu
# 臺灣加權指數與相關指數
# https://www.moneydj.com/iquote/iQuoteChart.djhtm?a=AI001059 ( works )

if ( len(sys.argv) < 2 ):
    print("usage: get_ticker_ror.py [ticker]")
    sys.exit(0)
ticker = sys.argv[1]
print(ticker)

# DIR0="./datafiles/taiex"
DIR0="."
fname = "ror." + ticker + ".html"
path = os.path.join(DIR0, fname)
# // FIXME: date may be not today, but input from ror.sh
ifname = "ror." + datetime.today().strftime('%Y%m%d') + '.csv'
i_path = os.path.join(DIR0, ifname)
rs_fname = "rs." + datetime.today().strftime('%Y%m%d') + '.csv'
rs_path = os.path.join(DIR0, rs_fname)

def fetch_twse_ror():
    # print("fetch_twse_ror+")
    f = open(i_path, newline='')
    csv_reader = csv.reader(f)
    next(csv_reader)
    s_figures=next(csv_reader) # the second line
    figures = s_figures[0].split(':')
    # print(figures[3])
    return figures

twse_ror_figures = fetch_twse_ror()
# print("{:>.02f}".format(float(twse_ror_figures[2])))
t_1d  = float(twse_ror_figures[2])
t_1w  = float(twse_ror_figures[3])
t_1m  = float(twse_ror_figures[4])
# t_2m  = float(twse_ror_figures[5]) # yet available
t_3m  = float(twse_ror_figures[6])
t_6m  = float(twse_ror_figures[7])
t_1y  = float(twse_ror_figures[8])
t_ytd = float(twse_ror_figures[9])
t_3y  = float(twse_ror_figures[10])

with open(fname) as q:
    soup = BeautifulSoup(q, 'html.parser')

# // FIXME: fetch name
# title = soup.find("meta",  {"name":"description"})
name = "n/a" #title["content"].split(' ')[0].split(')')[1].strip()

# apply to src 1,2,3,4
r_ytd = soup.findAll('table')[0] \
    .find_all('table')[0] \
    .find_all('tr')[8] \
    .find_all('td')[1].text.strip().replace('%', '')

r_1w  = soup.findAll('table')[0] \
    .find_all('table')[0] \
    .find_all('tr')[9] \
    .find_all('td')[1].text.strip().replace('%', '')

r_1m  = soup.findAll('table')[0] \
    .find_all('table')[0] \
    .find_all('tr')[10] \
    .find_all('td')[1].text.strip().replace('%', '')

r_2m  = soup.findAll('table')[0] \
    .find_all('table')[0] \
    .find_all('tr')[11] \
    .find_all('td')[1].text.strip().replace('%', '')

r_3m  = soup.findAll('table')[0] \
    .find_all('table')[0] \
    .find_all('tr')[12] \
    .find_all('td')[1].text.strip().replace('%', '')

# olist =   [ f_1d,  f_1w, f_1m, "n/a", f_3m, f_6m,  f_1y,  f_ytd, f_3y  ]
olist   =   [ "n/a", r_1w, r_1m, r_2m,  r_3m, "n/a", "n/a", r_ytd, "n/a" ]

# assume get_twse_ror.py is running at first
with open(rs_path, 'a') as ofile:
    # ofile.write("ticker:name:1d:1w:1m:2m:3m:6m:1y:ytd:3y\n")
    ofile.write(ticker+":"+name+":n/a:"+r_1w+":"+r_1m+":"+r_2m+":"+r_3m \
        +":n/a:n/a:"+r_ytd+":n/a"+"\n")
    ofile.close()

rs_1w  = ( (float(r_1w) -float(t_1w) ) * 100 ) / abs(float(t_1w) )
rs_1m  = ( (float(r_1m) -float(t_1m) ) * 100 ) / abs(float(t_1m) )
rs_3m  = ( (float(r_3m) -float(t_3m) ) * 100 ) / abs(float(t_3m) )
rs_ytd = ( (float(r_ytd)-float(t_ytd)) * 100 ) / abs(float(t_ytd))

'''
print("{:>.02f}".format(rs_1w ))
print("{:>.02f}".format(rs_1m ))
print("{:>.02f}".format(rs_3m ))
print("{:>.02f}".format(rs_ytd))
'''

sys.exit(0)
