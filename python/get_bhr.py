#!/usr/bin/python3

# python3 get_bhr.py [ticker]
# scraping from file fetched, extract ratio, and append to another csv
# \param in      ticker
# \param in      board.holding.[ticker].html
# \param out     bhr.YYYYMMDD.csv
# return 0

import sys, requests, time, os, numpy, random, csv
from bs4 import BeautifulSoup
from timeit import default_timer as timer
from datetime import timedelta,datetime
from pprint import pprint

if ( len(sys.argv) < 2 ):
    print("usage: get_bhr.py [ticker]")
    sys.exit(0)

ticker = sys.argv[1]

DIR0="./datafiles/taiex/board.holding"
DIR1 = os.path.join(DIR0, datetime.today().strftime('%Y%m%d'))

hname = "board.holding." + ticker + ".html"
h_path = os.path.join(DIR0, hname)

fname    = "board.holding." + datetime.today().strftime('%Y%m%d') + '.csv'
path    = os.path.join(DIR0, fname)

outf = open(path, 'a'); inf = open(h_path, "r")

soup = BeautifulSoup(inf, 'html.parser')
# print("# of table: {}".format(len(soup.findAll('table'))))
tbl = soup.find_all("table", {"class": "t01"})
# print("# of t01: {}".format(len(tbl)))
r = soup.find_all("table", {"class": "t01"})[0] \
    .find_all("tr")[2] \
    .find_all("td")[3].text.strip()
print("{}".format(r))
sys.exit(0)

# print( len(soup.findAll('table')) )
if ( len(soup.findAll('table')) != 5 ):
    print(" " + ticker + " no data, bypass") # // FIXME: filtered by fetching?
    sys.exit(0)

inf.close(); outf.close()

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
    # // FIXME: division by zero on 20240101
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
