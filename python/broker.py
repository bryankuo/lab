#!/usr/bin/python3

# python3 broker.py 2330
# return 0: success

import sys, requests, time, re, os, webbrowser
import urllib.request
from datetime import timedelta,datetime
from bs4 import BeautifulSoup

ticker = sys.argv[1]
url = "https://histock.tw/stock/broker.aspx?no="+ticker
response = requests.get(url)
soup = BeautifulSoup(response.text, 'html.parser')
webbrowser.open(url)
sys.exit(0)
