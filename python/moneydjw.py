#!/usr/bin/python3

# python3 moneydjw.py
# scraping from file fetched and compare with twse in rs
# \param in     YYYYMMDD.html
# \param out    quote, volume, RS wrt. TWSE
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

# url = "https://www.moneydj.com/warrant/xdjhtm/default.xdjhtm"

# portal
# url = "https://www.moneydj.com/warrant/xdjhtm/default.xdjhtm"

# rank
url = "https://www.moneydj.com/warrant/xdjhtm/Rank.xdjhtm?a=01"
# url = "https://www.moneydj.com/warrant/xdjhtm/Rank.xdjhtm?a=02"
# url = "https://www.moneydj.com/warrant/xdjhtm/Rank.xdjhtm?a=03"
# url = "https://www.moneydj.com/warrant/xdjhtm/Rank.xdjhtm?a=04"

# url = "https://www.moneydj.com/warrant/xdjhtm/Quote.xdjhtm"


print("fetch {}".format(url))

browser = webdriver.Safari(executable_path = '/usr/bin/safaridriver')
browser.implicitly_wait(20)
browser.maximize_window()
browser.switch_to.window(browser.current_window_handle)
browser.get(url)
# time.sleep(1)
page1 = browser.page_source
soup = BeautifulSoup(page1, 'html.parser')
browser.minimize_window()
browser.quit()
html_path = "moneydjw.html"
outfile2 = open(html_path, "w")
outfile2.write(soup.prettify())
outfile2.close()
print("write to {}".format(html_path))

tables = soup.find_all("table", {"class": "clearBoth datalist"})
print(len(tables))
rows = tables[0].find_all("tr")
print("# rows {}".format(len(rows)))

sys.exit(0)

