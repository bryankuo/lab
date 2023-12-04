#!/usr/bin/python3

# python3 warrant.py [ticker]
# with selenium tips as well as playground
# return 0: listed 2,  otc 4, otcbb 5

# find selenium version
# python3 -c "import selenium; print(selenium.__version__)"
# change version @see https://stackoverflow.com/a/49215247
# pip uninstall selenium
# pip install selenium==3.9
# current working version on macos
# Successfully uninstalled selenium-3.141.0
# testing version 3.9 NG
# 4.15.2 is the latest, NG,

# install the latest version
# pip3 uninstall selenium; pip3 install -U selenium

# @see https://stackoverflow.com/a/49215247
# @see https://stackoverflow.com/a/56127898
# @see https://stackoverflow.com/a/70211769
# @see https://stackoverflow.com/a/70099102
# With selenium4 as the key executable_path is deprecated
# pip3 install webdriver-manager
# python3 -c "import webdriver_manager; print(webdriver_manager.__version__)"

# selenium.common.exceptions.NoSuchDriverException
# safaridriver --version
# Included with Safari 15.6.1 (15613.3.9.1.16)
# @see https://www.selenium.dev/selenium/docs/api/py/api.html#common

# to list all versions of a module
# @see https://stackoverflow.com/a/5422144
# pip install selenium==

# keyword: 上市認購(售)權證 11/24
# https://www.twse.com.tw/zh/stocks/inquiry.html
#
# type 2 official source:
#
# type 4 official source:
# @see https://www.tpex.org.tw/web/extend/warrant/warrant_stat.php?l=zh-tw

# type 5?

import sys, requests, time, re, os
import urllib.request
from datetime import timedelta,datetime
from dateutil.relativedelta import relativedelta
from bs4 import BeautifulSoup
from pprint import pprint
from selenium import webdriver
from selenium.common.exceptions import SessionNotCreatedException
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.common.keys import Keys

if ( len(sys.argv) < 2 ):
    print("python3 warrant.py [ticker]")
    sys.exit(0)

ticker = sys.argv[1]
data = { \
    "stockNo": ticker, "duration1": 0, "duration2": 730, \
    "Period": 14 }

try:
    browser = webdriver.Safari( \
        executable_path = '/usr/bin/safaridriver')
    url0 = "http://localhost"
    url  = "http://warrants.sfi.org.tw/Query.aspx"
    url1 = "https://www.google.com"
    url2 = "https://tw.yahoo.com"
    url3 = 'http://httpbin.org/headers'

    browser.implicitly_wait(10)
    browser.get(url) # no tab name, 1 task is fine
    browser.maximize_window()

    # scroll to bottom
    # @see https://stackoverflow.com/a/27760083
    browser.execute_script("window.scrollTo(0, document.body.scrollHeight);")
    time.sleep(1)

    # check programatically
    element = browser.find_element_by_id('agree')
    # element  = browser.find_element_by_link_text('Screener') // FIXME:
    # element  = browser.find_element_by_css_selector('checkbox#agree') // FIXME:
    # elements = browser.find_elements_by_name("passwd") // FIXME:
    # formal way @see shorturl.at/bghsD
    action = webdriver.ActionChains(browser)
    # action.move_to_element(element)
    # action.click(element)
    # action.perform()
    # shorthand
    action.move_to_element(element).click(element).perform()
    # shortcut @see https://stackoverflow.com/a/68895534
    # browser.execute_script("arguments[0].click();", element)
    browser.save_screenshot("ss0.png") # OK

    # then click 'BTNConfirm'
    action2 = webdriver.ActionChains(browser)
    element = browser.find_element_by_id('BTNConfirm')
    action2.move_to_element(element).click(element).perform() # works

    # print('before:' + webdriver.current_url) // FIXME:
    # then page redirected, input text [ticker]
    time.sleep(2) # wait page load complete
    # print('after :' + webdriver.current_url) // FIXME:
    element3 = browser.find_element_by_id('stockNo')
    element3.send_keys(ticker) # OK

    '''
    # open new tab
    # @see https://stackoverflow.com/a/68661030
    browser.execute_script("window.open('about:blank','tab1');")

    # browser.switch_to.window(browser.current_window_handle) # OK
    # browser.maximize_window() # OK
    # // set window size
    # browser.set_window_size(640, 480) # OK

    # Second tab
    browser.execute_script("window.open('about:blank','secondtab');")
    browser.switch_to.window("secondtab")
    browser.get(url1)

    browser.switch_to.window("tab1")
    browser.get(url)

    # close specific tab @see https://stackoverflow.com/a/54840685
    window_name1 = browser.window_handles[0]
    browser.switch_to.window(window_name=window_name1)
    browser.close() # one tab
    '''
    # how to find a link: shorturl.at/AIJPX
    # element = browser.find_element(By.LINK_TEXT, '列印 / HTML')
    # element = browser.find_element(By.PARTIAL_LINK_TEXT, 'HTML')
    #
    # how to select list item @see qfii.py

    browser.save_screenshot("ss1.png") # OK

except (SessionNotCreatedException):
    print('turn on safari remote option.')

finally:
    # time.sleep(10)
    browser.minimize_window() # OK
    browser.quit()

sys.exit(0)
# @see https://www.twse.com.tw/zh/products/securities/warrant/infomation/stock.html
# @see https://www.twse.com.tw/zh/announcement/punish.html
# @see https://www.twse.com.tw/zh/announcement/notice.html
# warrant news
# @see https://newjust.masterlink.com.tw/z/zx/zxf/zxf.djhtm?A=2023-12-4&B=13

