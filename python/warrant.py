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
# // TODO: from selenium.webdriver.common.keys import Keys

ticker = sys.argv[1]
data = { \
    "stockNo": ticker, "duration1": 0, "duration2": 730, \
    "Period": 14 }

try:
    browser = webdriver.Safari( \
        executable_path = '/usr/bin/safaridriver')
    # url = "http://warrants.sfi.org.tw/Query.aspx"
    url = "http://warrants.sfi.org.tw/Default.aspx"
    # url = "https://stackoverflow.com/questions/20986631/how-can-i-scroll-a-web-page-using-selenium-webdriver-in-python"

    browser.get(url)
    browser.switch_to.window(browser.current_window_handle)
    browser.maximize_window() # OK
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
    time.sleep(3) # wait page load complete
    # print('after :' + webdriver.current_url) // FIXME:
    element3 = browser.find_element_by_id('stockNo')
    element3.send_keys(ticker) # OK

except (SessionNotCreatedException):
    print('turn on safari remote option.')

finally:
    time.sleep(4)
    # browser.minimize_window() // OK
    browser.quit()

sys.exit(0)
