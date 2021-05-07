#!/usr/bin/python3

# python3 transaction.py filename
# return 0: success

import sys, requests, time, webbrowser, urllib.request
from datetime import timedelta,datetime
from dateutil.relativedelta import relativedelta
from bs4 import BeautifulSoup

filename = sys.argv[1]

with open(filename, 'r') as f:
    contents = f.read()
    soup = BeautifulSoup(contents, 'html.parser')
tables = soup.findAll('table')
for table in tables:
    print(table.prettify())

# ready to scrap

sys.exit(0)
