#!/usr/bin/python3

# python3 quick_qvrs.py [yyyymmdd]
# scraping from file fetched and compare with twse in rs
# \param in     dt0 date YYYYMMDD.html
#
# return 0

import sys, requests, time, os, numpy, random, csv
from bs4 import BeautifulSoup
from timeit import default_timer as timer
from datetime import timedelta, datetime
from pprint import pprint
import pandas as pd

DIR0r="./datafiles/taiex/rs"
DIR0a="./datafiles/taiex/after.market"
print("preloaded...{}".format(sys.argv[1]))

# @see wrangle_df.py
#
# df2 = df1.filter(items=['代號','名稱', '漲跌幅', '價格', '成交量', 'rs'])
# df2 = df2[df2['成交量'] > 10000]
# df2 = df2[(df2['rs'] > 90) & (df2['成交量'] > 10000)]
#
# df2['昨量比'] = df1['成交量'] / df0['成交量']
# pprint(df2[(df2['rs'] > 90) & (df2['成交量'] > 10000)])
#
# to preload some libraries and scripts in python
# python -i -c "import math"
# @see https://stackoverflow.com/a/9712156
# export PYTHONSTARTUP=./quick_qvrs.py
