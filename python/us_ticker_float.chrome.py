#!/usr/bin/python3

# python3 us_ticker_float.py [ticker]
# scraping public float from internet file
#
# \param in     ticker symbol
# \param out    [ticker].html
# return 0

# // TODO: capchta delivery service @see \
# https://stackoverflow.com/a/70784415
# save page as > compare
# <ul class="list list--kv list--col50">
# selenium remote driver get_page_source()

import sys, requests, time, os, re
from datetime import datetime
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

if ( len(sys.argv) < 2 ):
    print("usage: us_ticker_float.py [ticker]")
    sys.exit(0)

ticker = sys.argv[1]

DIR0="./datafiles/usa/public.float"

if not os.path.exists(DIR0):
    os.mkdir(DIR0)

ofname1 = ticker + ".html"
html_path = os.path.join(DIR0, ofname1)

url = "https://www.marketwatch.com/investing/stock/ccm?mod=mw_quote_tab"

print("fetch {}".format(url))

try:
    chrome_options = webdriver.ChromeOptions()
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

    stealth(driver,
            languages=["en-US", "en"],
            vendor="Google Inc.",
            platform="Win32",
            webgl_vendor="Intel Inc.",
            renderer="Intel Iris OpenGL Engine",
            fix_hairline=True,
    )

    print("from {}".format(url))
    driver.get(url)

    # all_cookies = driver.get_cookies()
    # pickle.dump(all_cookies, open("cookies.pkl", "wb"))
    # cookies_dict = {}
    # for cookie in all_cookies:
    #    cookies_dict[cookie['name']] = cookie['value']
    # id="holdingTable" # wait fully loaded

    # element = WebDriverWait(driver, 20) \
    #     .until(EC.element_to_be_clickable( \
    #    (By.XPATH, "//*[@id='holdingTable']/tr[1]")))

    page = driver.page_source
    soup = BeautifulSoup(page, 'html.parser')

    outfile2 = open(html_path, "w") # , encoding='UTF-8')
    outfile2.write(soup.prettify())
    outfile2.close()

    print("output {}".format(html_path))

except:
    # traceback.format_exception(*sys.exc_info())
    e = sys.exc_info()[0]
    print("Unexpected error:", sys.exc_info()[0])
    raise

finally:
    # driver.delete_all_cookies() # best practice?
    driver.minimize_window()
    driver.quit()
    # os.remove("cookies.pkl")
    # print("finally")

print("done.")
sys.exit(0)

print("write to {}".format(html_path))

uls = soup.find_all("ul", {"class": "list list--kv list--col50"})
# print("# ul {}".format(len(uls)))
# pprint(uls[0])
so = uls[0].find_all("li")[4].find_all("span")[0].text
pf = uls[0].find_all("li")[5].find_all("span")[0].text
print("so {} pf {}".format(so, pf))
n_shares_so = 0; n_shares_pf = 0

if re.search('B', so, re.IGNORECASE):
    n_shares_so = float( so.replace('B','' ) ) * pow(10, 9)
elif re.search('M', so, re.IGNORECASE):
    n_shares_so = float( so.replace('M','' ) ) * pow(10, 6)
elif re.search('K', so, re.IGNORECASE):
    n_shares_so = float( so.replace('K','' ) ) * pow(10, 3)
else:
    n_shares_so = float( so ) * pow(10, 0)
print(f"share outstanding {n_shares_so:>10.0f}".format(n_shares_so))

if ( pf != "N/A" ):
    if re.search('B', pf, re.IGNORECASE):
        n_shares_pf = float( pf.replace('B','' ) ) * pow(10, 9)
    elif re.search('M', pf, re.IGNORECASE):
        n_shares_pf = float( pf.replace('M','' ) ) * pow(10, 6)
    elif re.search('K', pf, re.IGNORECASE):
        n_shares_pf = float( pf.replace('K','' ) ) * pow(10, 3)
    else:
        n_shares_pf = float( pf ) * pow(10, 0)
    print(f"public float      {n_shares_pf:>10.0f}".format(n_shares_pf))
else:
    print(f"public float      n/a")

# so=float(so.replace('B','').replace('M',''))
# pf=float(pf.replace('B','').replace('M',''))
r = float( n_shares_pf / n_shares_so )
print("publi float ratio  {:>9.3f}".format(r))

sys.exit(0)
