#!/usr/bin/python3

# python3 moneydjw.py
# exercise selenium tips
# \param in
# \param out
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

page1 = browser.page_source
soup = BeautifulSoup(page1, 'html.parser')

options = soup.find_all("select", {"class": "pageselect"})[0] \
    .find_all("option")
print("# opt {}".format(len(options)))

delay = 3
# WebDriverWait(browser, delay) \
#    .until(EC.presence_of_element_located(By.Class, "clearBoth datalist"))

# WebDriverWait(browser, delay) \
#    .until(EC.visibility_of_element_located(By.Class, "clearBoth datalist"))

time.sleep(delay)

tables = soup.find_all("table", {"class": "clearBoth datalist"})
print("# tables {}".format(len(tables)))

rows = tables[0].find_all("tr")
print("# rows {}".format(len(rows)))

lis = soup.find_all("div", {"id": "rkTab"})[0] \
    .find_all("ul")[0] \
    .find_all("li")
print("# lis {}".format(len(lis)))

# element = browser.find_element(By.LINK_TEXT, '成交金額排行') # works
# element =  lis[1].find_all("a")[0] # // FIXME: not triggering
# element = browser \
#    .find_element(By.LINK_TEXT, lis[2].find_all("a")[0].text)
# print("click {}".format(lis[2].find_all("a")[0].text)) # works
# action = webdriver.ActionChains(browser)
# action.click(element).perform() # works

# browser.implicitly_wait(20) # when .get()
# @see https://stackoverflow.com/a/26567563

# reload soup before write to file?
page1 = browser.page_source
soup = BeautifulSoup(page1, 'html.parser')

html_path = "moneydjw.html"
outfile2 = open(html_path, "w")

outfile2.write(soup.prettify())
outfile2.close()
print("write to {}".format(html_path))

browser.minimize_window()
browser.quit()

sys.exit(0)
