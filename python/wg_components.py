#!/usr/bin/python3

# python3 wg_components.py [id]
#
# selenium tips on chrome driver, cookie features, cloudfare undetection
# NOT serving ./scrap_wg_components.py
#
# \param  in id
# \param out datafiles/taiex/etf_components/[id].csv
#
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

if ( len(sys.argv) < 2 ):
    print("python3 wg_components.py [id]")
    sys.exit(0)

eid = sys.argv[1]
fname = eid + ".csv"
DIR0="datafiles/taiex/etf_components"
o_path = os.path.join(DIR0, fname)

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

    url = "https://www.wantgoo.com/stock/etf/" + eid + "/constituent"
    print("from {}".format(url))
    driver.get(url)

    all_cookies = driver.get_cookies()
    pickle.dump(all_cookies, open("cookies.pkl", "wb"))
    # cookies_dict = {}
    # for cookie in all_cookies:
    #    cookies_dict[cookie['name']] = cookie['value']
    id="holdingTable" # wait fully loaded

    element = WebDriverWait(driver, 20) \
        .until(EC.element_to_be_clickable((By.XPATH, "//*[@id='holdingTable']/tr[1]")))

    page = driver.page_source
    soup = BeautifulSoup(page, 'html.parser')

    fname = eid + ".html"
    path = os.path.join(DIR0, fname)
    outfile2 = open(path, "w", encoding='UTF-8')
    outfile2.write(soup.prettify())
    outfile2.close()

    print("output {}".format(path))
    tables = soup.find_all("tbody", {"id": "holdingTable"})
    rows = tables[0].find_all("tr")
    print("# tables {}, # rows {}".format(len(tables), len(rows)))

    clist = []
    outfile = open(o_path, "w")
    for i in range(0, len(rows)-1 ):
        tkr = rows[i].find_all("td")[0].text.strip()
        # print("{}".format(tkr))
        clist.append(tkr)
        outfile.write(tkr+"\n" )
    outfile.close()
    print("to {}".format(o_path))
    pprint("# {} \n{}".format(len(clist), clist))

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
    # print("finally")

print("done.")

sys.exit(0)
