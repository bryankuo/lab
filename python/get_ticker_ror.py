#!/usr/bin/python3

# python3 get_ticker_ror.py [ticker] [benchmark]
# scraping from file fetched and compare with twse in rs
# \param in out  ror.YYYYMMDD.csv
# \param in      ror.yyyymmdd.csv 2nd line for twse ror
# \param in      ror.[ticker].html
# \param in      benchmark output from get_twse_ror.py
# \param out     rs.YYYYMMDD.csv
# return 0

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

if ( len(sys.argv) < 3 ):
    print("usage: get_ticker_ror.py [ticker] [benchmark]")
    sys.exit(0)
ticker = sys.argv[1]

# t_1d  = float(twse_ror_figures[2])
t_1w  = float(sys.argv[3].replace('\'',''))
t_1m  = float(sys.argv[4].replace('\'',''))
# t_2m  = float(twse_ror_figures[5]) # yet available
t_3m  = float(sys.argv[6].replace('\'',''))
#t_6m  = float(twse_ror_figures[7])
# t_1y  = float(twse_ror_figures[8])
t_ytd = float(sys.argv[9].replace('\'',''))
# t_3y  = float(twse_ror_figures[10])

DIR0="./datafiles/taiex/rs"
DIR1 = os.path.join(DIR0, datetime.today().strftime('%Y%m%d'))

fname = "ror." + ticker + ".html"
h_path = os.path.join(DIR1, fname)

# // FIXME: date may be not today, but input from ror.sh
ifname    = "ror." + datetime.today().strftime('%Y%m%d') + '.csv'
i_path    = os.path.join(DIR0, ifname)

ror_fname = "ror." + datetime.today().strftime('%Y%m%d') + '.csv'
ror_path  = os.path.join(DIR0, ror_fname)

rs_fname  = "rs."  + datetime.today().strftime('%Y%m%d') + '.csv'
rs_path   = os.path.join(DIR0, rs_fname)

# twse_ror_figures = fetch_twse_ror()
# print("{:>.02f}".format(float(twse_ror_figures[2])))

with open(h_path) as q:
    soup = BeautifulSoup(q, 'html.parser')

    # print( len(soup.findAll('table')) )
    if ( len(soup.findAll('table')) != 5 ):
        print(" " + ticker + " no data, bypass") # // FIXME: filtered by fetching?
        sys.exit(0)
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
# olist   =   [ "n/a", r_1w, r_1m, r_2m,  r_3m, "n/a", "n/a", r_ytd, "n/a" ]

# assume get_twse_ror.py is running at first
with open(ror_path, 'a') as ofile:
    # ofile.write("ticker:name:1d:1w:1m:2m:3m:6m:1y:ytd:3y\n")
    ofile.write(ticker+":"+name+":n/a:"+r_1w+":"+r_1m+":"+r_2m+":"+r_3m \
        +":n/a:n/a:"+r_ytd+":n/a"+"\n")
    ofile.close()

# // TODO: verify output
# if ( r_1w.isnumeric() and rs_1m.isnumeric() \
#     and rs_3m.isnumeric() and rs_ytd.isnumeric() ):
if ( r_1w.lower() != "N/A".lower() \
    and r_1m.lower() != "N/A".lower() \
    and r_3m.lower() != "N/A".lower() \
    and r_ytd.lower() != "N/A".lower() ):
    rs_1w  = ( (float(r_1w) -float(t_1w) ) ) / abs(float(t_1w) )
    rs_1m  = ( (float(r_1m) -float(t_1m) ) ) / abs(float(t_1m) )
    rs_3m  = ( (float(r_3m) -float(t_3m) ) ) / abs(float(t_3m) )
    rs_ytd = ( (float(r_ytd)-float(t_ytd)) ) / abs(float(t_ytd))
    with open(rs_path, 'a') as ofile:
        # ofile.write("ticker:name:1d:1w:1m:2m:3m:6m:1y:ytd:3y\n")
        ofile.write(ticker+":n/a:n/a:"+"{:>.02f}".format(rs_1w )+ \
            ":"+"{:>.02f}".format(rs_1m )+":n/a:"+"{:>.02f}".format(rs_3m ) \
            +":n/a:n/a:"+"{:>.02f}".format(rs_ytd)+":n/a"+"\n")
        ofile.close()
    print(" " +ticker+":n/a:n/a:"+"{:>.02f}".format(rs_1w )+ \
            ":"+"{:>.02f}".format(rs_1m )+":n/a:"+"{:>.02f}".format(rs_3m ) \
            +":n/a:n/a:"+"{:>.02f}".format(rs_ytd)+":n/a")
else:
    print(" " + ticker + " NG " + r_1w + " " + r_1m + " " + r_3m + " " + r_ytd)

sys.exit(0)
