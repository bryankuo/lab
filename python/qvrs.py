#!/usr/bin/python3

# python3 qvrs.py [yyyymmdd]
# scraping from file fetched and compare with twse in rs
# \param in     YYYYMMDD.html
# \param in     YYYYMMDD.all.columns.csv
# \param out    "qvrs.yyyymmdd.[hhnn].price.desc.csv, plus RS wrt. TWSE
# return 0

import sys, requests, time, os, numpy, random, csv
from bs4 import BeautifulSoup
from timeit import default_timer as timer
from datetime import timedelta, datetime
from pprint import pprint
import pandas as pd
pd.options.mode.chained_assignment = None  # default='warn'
# @see https://stackoverflow.com/a/20627316

if ( len(sys.argv) < 2 ):
    print("usage: qvrs.py [yyyymmdd]")
    sys.exit(0)

yyyymmdd = sys.argv[1]

DIR0r="./datafiles/taiex/rs"
DIR0a="./datafiles/taiex/after.market"

fname = yyyymmdd + ".html"
h_path = os.path.join(DIR0a, fname)

cname = yyyymmdd + ".all.columns.csv"
c_path = os.path.join(DIR0a, cname)

rs_path   = os.path.join(DIR0r, "qvrs."+yyyymmdd+".ticker.asc.csv")

print("read {}".format(c_path))
df = pd.read_csv(c_path, sep=':', header=0)
print(df.shape)
df['rs']=0
# @see https://shorturl.at/uwDEM
df['rs'] = df['rs'].astype(float)
# print(df.dtypes)

print("parse {}".format(h_path))
in_html = open(h_path, 'r')
soup = BeautifulSoup(in_html, 'html.parser')
pinfo = soup.find_all("div", {"class": "info-right ftR"})[0] \
    .find_all("div")[0] \
    .find_all('ul')[0]
# twse_mark = float( pinfo.find_all('li')[0] \
#     .find_all('span')[1].text.strip() )
twse_chg = float( pinfo.find_all('li')[2] \
    .find_all('span')[1].text.strip().replace('%','') )

print("twse {}".format(twse_chg)) # works
in_html.close()

pd.options.display.float_format = '{:.3f}'.format
for ind in df.index:
    # print(df['代號'][ind], df['漲跌幅'][ind], df['rs'][ind])
    if ( df['漲跌幅'][ind] != "--" ):
        ticker_chg = float( df['漲跌幅'][ind].replace('%','') )
    else:
        # @see https://stackoverflow.com/a/34794112
        ticker_chg = 0
    # if ( twse_chg != 0 ):
        # df['rs'][ind] = (ticker_chg - twse_chg) / abs(twse_chg)
    df['rs'][ind] = (ticker_chg - twse_chg)
    # else:
    #    df['rs'][ind] = ticker_chg # benchmark neutrual

# print(df.loc[[ind]])
df['rs'] = df['rs'].rank(ascending=True, pct=True)
df.loc[:,'rs'] *= 100

df.sort_values(['代號'], ascending=[True], inplace=True)
df.reset_index()
# pprint(df)

df.to_csv(rs_path, sep = ':', header=True, index=False)
print("{} write to {}".format(df.shape, rs_path))
sys.exit(0)


in_csv = open(c_path, 'r')
data  = list(csv.reader(in_csv, delimiter=':'))

tkrs  = [ x[0] for x in data ]
quote = [ x[2] for x in data ]
vols  = [ x[11] for x in data ]
chgs  = [ x[4] for x in data ]
rs    = [ 0 ] * len(tkrs) # normalized // TODO:

outf_rs = open(rs_path, 'w')
outf_rs.write("{}:{}:{}:{}\n".format("ticker","quote","volume","rs"))
for i in range(1, len(tkrs)):
    if ( chgs[i] != "--" ): # -4.67
        ticker_chg = float( chgs[i].replace('%','') )
        if ( twse_chg != 0 ):
            # workaround of ZeroDivisionError
            ticker_rs = (ticker_chg - twse_chg) / abs(twse_chg)
        else:
            ticker_rs = ticker_chg # benchmark neutrual
    else:
        ticker_rs = "n/a"
    outf_rs.write("{}:{}:{}:{}\n" \
        .format(tkrs[i], quote[i], vols[i], ticker_rs))

in_csv.close()
outf_rs.close()
print("write to {}".format(rs_path))
sys.exit(0)
