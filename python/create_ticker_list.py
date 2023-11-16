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
    reader = csv.reader(f)
    data = list(reader)
f.close()

# pprint(data)
# print(len(data))

sys.exit(0)
