#!/usr/bin/python3

# python3 wg878.py
# selenium tips on chrome driver, cookie features, cloudfare undetection

# safari headless 2020 unavailable, any solution?
# recommended WebDriver packages for Selenium => install chrome
# chrome driver example
# run on windows > same output >
#
# install chrome version: Version 124.0.6367.93 (Official Build) (x86_64)
# driver compatibility:
# https://googlechromelabs.github.io/chrome-for-testing/
# stable: 124.0.6367.91
#
# This happens because macOS Gatekeeper sets an extended attribute that marks the ZIP file
# @see https://stackoverflow.com/a/77889058
# /Applications sudo xattr -cr 'Google Chrome for Testing.app'
#
# 安裝 Chrome Driver
# https://shorturl.at/vAEX0
# use beta instead reinstall browser
# use later version 125.0.6422.14
# Exception: No such driver version 124.0.6367.93 for mac-x64
# driver download 91 as well
# sudo xattr -cr /usr/local/bin/chromedriver

# pickle
#
# \param out ror.YYYYMMDD.csv
# return 0

import sys, requests, time, os
from datetime import timedelta, datetime
from pprint import pprint
from bs4 import BeautifulSoup

import pickle
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.chrome.service import Service as ChromeService
from webdriver_manager.chrome import ChromeDriverManager
from selenium_stealth import stealth

try:
    # chromedriver_autoinstaller.install()
    # selenium 4.10.0 @see https://stackoverflow.com/a/76550727
    # service1 = Service(executable_path='./chromedriver.exe')
    # service1 = Service() # missing 1 required positional argument at macos
    # service1 = Service(executable_path=\
            #    "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome")
    # When doing web scraping, it is common to configure Selenium as a headless browser.
    # @see https://shorturl.at/GOPX2
    chrome_options = webdriver.ChromeOptions()

    # @see https://stackoverflow.com/a/63047876
    chrome_options.binary_location = \
        "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"

    chrome_options.add_argument('--headless')
    chrome_options.add_experimental_option("excludeSwitches", ["enable-automation"])
    chrome_options.add_experimental_option('useAutomationExtension', False)

    driver = webdriver.Chrome( \
        executable_path = os.path.abspath("/usr/local/bin/chromedriver"), \
        options = chrome_options) # @see https://stackoverflow.com/a/69157541
    driver.implicitly_wait(20)
    driver.maximize_window()
    driver.switch_to.window(driver.current_window_handle)

    # @see https://stackoverflow.com/a/73787668
    stealth(driver,
            languages=["en-US", "en"],
            vendor="Google Inc.",
            platform="Win32",
            webgl_vendor="Intel Inc.",
            renderer="Intel Iris OpenGL Engine",
            fix_hairline=True,
    )

    url = "https://www.wantgoo.com/stock/etf/00878/constituent"
    # url = "https://zh-tw.facebook.com/peko.nurse"

    driver.get(url)

    print("get cookies")
    all_cookies = driver.get_cookies()
    # @see https://stackoverflow.com/a/15058521
    # pickle.dump(driver.get_cookies(), open("cookies.pkl", "wb"))
    pickle.dump(all_cookies, open("cookies.pkl", "wb"))

    # pretty print cookies @see https://stackoverflow.com/a/67690675
    cookies_dict = {}
    for cookie in all_cookies:
        cookies_dict[cookie['name']] = cookie['value']
    pprint(cookies_dict)

    # working with cookies
    # https://www.selenium.dev/documentation/webdriver/interactions/cookies/
    # pagination? @see https://stackoverflow.com/q/76114701
    # secure cookies?
    # why cookies?
    # LAX? sameSite attribute?

    # driver.get(url)
    # cookies = pickle.load(open("cookies.pkl", "rb"))
    # for cookie in cookies:
    #     driver.add_cookie(cookie)
    # print("add cookies")

    # time.sleep(10) # seconds
    id="holdingTable" # wait fully loaded

    print("wait until located")
    # element = WebDriverWait(driver, 20) \
    #   .until(EC.presence_of_element_located(By.ID, "holdingTable"))
    element = WebDriverWait(driver, 20) \
        .until(EC.element_to_be_clickable((By.XPATH, "//*[@id='holdingTable']/tr[1]")))
    print(element)
    # // FIXME: TimeoutException cf_clearance cloudfare CDN bypass detection
    # undetected selenium
    # @see selenium stealth https://stackoverflow.com/a/73787668

    page = driver.page_source
    soup = BeautifulSoup(page, 'html.parser')
    DIR0="."
    fname = "wg878.html"

    # content can be generated in frames? readyState execute_script
    # @see https://t.ly/unrde
    # There is no universal mechanism, of course. Practically every site
    # uses a different mechanism for doing their cookie popup.

    path = os.path.join(DIR0, fname)
    outfile2 = open(path, "w", encoding='UTF-8')
    outfile2.write(soup.prettify())
    outfile2.close()
    print("output {}".format(path))

except:
    # traceback.format_exception(*sys.exc_info())
    e = sys.exc_info()[0]
    print("Unexpected error:", sys.exc_info()[0])
    raise

finally:
    driver.delete_all_cookies() # best practice?
    driver.minimize_window()
    driver.quit()
    os.remove("cookies.pkl")
    print("finally")

'''

browser = webdriver.Safari(executable_path = '/usr/bin/safaridriver')
browser.implicitly_wait(20)
browser.maximize_window()
browser.switch_to.window(browser.current_window_handle)
browser.get(url)

'''

sys.exit(0)
