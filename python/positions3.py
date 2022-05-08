#!/usr/bin/env python3

# python3 position3.py [ticker]
# return 0: success

import requests, sys, time
from selenium import webdriver
from bs4 import BeautifulSoup

ticker   = sys.argv[1]
url = "https://www.wantgoo.com/stock/" + ticker + \
    "/institutional-investors/trend"

# response = requests.get(url)
# soup = BeautifulSoup(response.text, 'html.parser')

browser = webdriver.Safari(executable_path = '/usr/bin/safaridriver')
if ( browser is None ):
    print("make sure safari automation enabled")
    sys.exit(3)
browser.get(url)
time.sleep(10) # wait until page fully loaded
page = browser.page_source
soup = BeautifulSoup(page, 'html.parser')
print(soup.prettify())

browser.close()

'''
download_pg = "a.txt"
with open(download_pg) as inf_download:
    soup = BeautifulSoup(inf_download, 'html.parser')
'''

'''
tbl = soup.find("table")

th0 = soup.find("table") \
    .find_all('thead')[0]

th1 = soup.find("table") \
    .find_all('thead')[1]

# tr0 = soup.find("table") \
#     .find_all('tbody', {"class": "rt"})[0]

# print(tbl)
# print('\n')
'''

sys.exit(0)
