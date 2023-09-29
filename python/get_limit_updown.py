#!/usr/bin/python3

# python3 get_limit_updown.py [up or down] [date] [type] [from_src]
# \param  in  html file
# \param  in  up or down, 0:down 1:up
# \param  in  date in YYYYMMDD
# \param  in  from_src
# \param  out csv file
# \return number of rows

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
from array import *

if ( len(sys.argv) < 5 ):
    print("usage: get_limit_updown.py [0|1] [YYYYMMDD] [type] [from_src]")
    sys.exit(0)
is_limit_up = True
direction = "up"
if ( int(sys.argv[1]) == 0 ):
    is_limit_up = False
    direction = "down"
fetch_date  = sys.argv[2]
ticker_type = sys.argv[3]
from_src = sys.argv[4]

# DIR0="./datafiles/taiex"
DIR0="."
i_fname = "limit." + direction + "." + fetch_date + "." + \
    ticker_type + "." + from_src + '.html'
i_path = os.path.join(DIR0, i_fname)
o_fname = "limit." + direction + "." + fetch_date + '.csv'
o_path = os.path.join(DIR0, o_fname)

# if ( os.path.exists(o_path) ):
#    os.remove(o_path) # clean up

n_rows = 0
try:
    with open(i_path) as q:
        soup = BeautifulSoup(q, 'html.parser')
    rows = soup.find("table", {"id": "oMainTable"}) \
        .find_all('tr')
    # fname = "a.1.html"
    # path = os.path.join(DIR0, fname)
    #with open(path, "w") as outfile2:
    #    outfile2.write(rows[2].prettify())
    #    outfile2.close()
    with open(o_path, 'a') as ofile:
        for i in range(2, len(rows)):
            tkr = rows[i].findAll('td')[1].text.strip().replace(' ', '')[0:4]
            ofile.write(tkr+"\n")
            n_rows += 1
        ofile.close()
except:
    traceback.format_exception(*sys.exc_info())
    e = sys.exc_info()[0]
    print("Unexpected error:", sys.exc_info()[0])
    raise
    # @see https://shorturl.at/elmo7
finally:
    time.sleep(1)
olist = [ str(n_rows) ]
print(olist)
sys.exit(0)
