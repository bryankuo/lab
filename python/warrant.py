#!/usr/bin/python3

# python3 warrant.py [ticker]
# return 0: listed 2,  otc 4, otcbb 5

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

    # find selenium version
    # python3 -c "import selenium; print(selenium.__version__)"

    browser.get(url) # no tab name, 1 task is fine

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

except (SessionNotCreatedException):
    print('turn on safari remote option.')

finally:
    time.sleep(10)
    # browser.minimize_window() // OK
    browser.quit()

sys.exit(0)