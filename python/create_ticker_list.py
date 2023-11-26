#!/usr/bin/python3

# python3 create_ticker_list.py
# \param in watchlist
# return 0

import os, sys, csv
from pprint import pprint

DIR0="./datafiles"

ifname = "watchlist.20231023.txt"
path0  = os.path.join(DIR0, ifname)

with open(path0, newline='\n') as f:
    reader = csv.reader(f) # 1 dimension example
    data = list(reader) # 1 dimension
f.close()

# pprint(data)
# print(len(data))

sys.exit(0)
