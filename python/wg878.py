#!/usr/bin/python3

# python3 wg878.py
# test on fetching wantgoo via selenium
# \param out ror.YYYYMMDD.csv
# return 0

import sys, requests, time, os, numpy
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

url = "https://www.wantgoo.com/stock/etf/00878/constituent"
DIR0="."
fname = "wg878.html"
path = os.path.join(DIR0, fname)

browser = webdriver.Safari(executable_path = '/usr/bin/safaridriver')
browser.implicitly_wait(20)
browser.maximize_window()
browser.switch_to.window(browser.current_window_handle)
browser.get(url)

# id="holdingTable" # wait fully loaded

# element = WebDriverWait(browser, 20) \
#    .until(EC.presence_of_element_located(By.ID, "holdingTable"))
# print(element)

# delay = 5 # secs
# time.sleep(delay)

# When doing web scraping, it is common to configure Selenium as a headless browser.
# @see https://shorturl.at/GOPX2
# safari headless 2020 unavailable, any solution?
# recommended WebDriver packages for Selenium => install chrome
# chrome driver example

page1 = browser.page_source
soup = BeautifulSoup(page1, 'html.parser')
browser.minimize_window()
browser.quit()

outfile2 = open(path, "w")
outfile2.write(soup.prettify())
outfile2.close()

sys.exit(0)
