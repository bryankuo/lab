#!/usr/bin/python3

# python3 wg878.py
# test on fetching wantgoo via selenium

# safari headless 2020 unavailable, any solution?
# recommended WebDriver packages for Selenium => install chrome
# chrome driver example
# run on windows

# \param out ror.YYYYMMDD.csv
# return 0

import sys, requests, time, os, numpy
from bs4 import BeautifulSoup
'''
from selenium import webdriver
from selenium.common.exceptions import SessionNotCreatedException
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import Select
from timeit import default_timer as timer
'''
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.chrome.service import Service as ChromeService
from webdriver_manager.chrome import ChromeDriverManager
from selenium_stealth import stealth
import chromedriver_autoinstaller
import webbrowser

from datetime import timedelta,datetime
from pprint import pprint

try:
    chromedriver_autoinstaller.install()
    # selenium 4.10.0 @see https://stackoverflow.com/a/76550727
    # service1 = Service(executable_path='./chromedriver.exe')
    service1 = Service()
    # When doing web scraping, it is common to configure Selenium as a headless browser.
    # @see https://shorturl.at/GOPX2    
    options = webdriver.ChromeOptions()
    options.add_argument('--headless')
    driver = webdriver.Chrome(service=service1, options=options)
    url = "https://www.wantgoo.com/stock/etf/00878/constituent"
    driver.get(url)
    time.sleep(5) # 10
    page = driver.page_source
    soup = BeautifulSoup(page, 'html.parser')
    DIR0="."
    fname = "wg878.html"
    path = os.path.join(DIR0, fname)    
    outfile2 = open(path, "w", encoding='UTF-8')
    outfile2.write(soup.prettify())
    outfile2.close()

except:
    # traceback.format_exception(*sys.exc_info())
    e = sys.exc_info()[0]
    print("Unexpected error:", sys.exc_info()[0])
    raise
finally:
    driver.quit()
    print("driver quit?")

'''


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


page1 = browser.page_source
soup = BeautifulSoup(page1, 'html.parser')
browser.minimize_window()
browser.quit()


'''

sys.exit(0)
