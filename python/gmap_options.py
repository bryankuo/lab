from bs4 import BeautifulSoup
import requests
import time
from time import sleep
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
import re
import pandas as pd
from pandas import ExcelWriter
from shutil import which
import sys
# import chromedriver_binary  # // FIXME:

# @see https://github.com/sulasoft/Scraping-Business-in-Google/blob/main/Scraping%20Business%20in%20Google.py

try:
    # keyword = input("Name of companies (Example: Martial arts companies in the United States): ")
    keyword = "33rd Rd, Khar, Khar West, Mumbai, Maharashtra 400052, India"
    chromedriver_autoinstaller.install()

    # selenium 4.10.0 @see https://stackoverflow.com/a/76550727
    # service1 = Service(executable_path='./chromedriver.exe')
    # chromedriver.exe @see https://stackoverflow.com/a/42478941
    # @see https://sites.google.com/chromium.org/driver/?pli=1

    service1 = Service()
    options = webdriver.ChromeOptions()

    # options.add_argument('--headless') # command line switches @see https://shorturl.at/bfxX5
    # options.add_argument('--log-level=3')
    # options.add_argument('--window-size=1920,1080') # OK
    # options.add_argument('--disable-dev-shm-usage')
    # options.add_argument('--start-maximized') # roger that
    # options.add_argument('--disable-blink-features=AutomationControlled')
    # lista = ['enable-automation', 'enable-logging']
    # options.add_experimental_option('excludeSwitches', lista)
    options.add_argument('--enable-gpu')

    driver = webdriver.Chrome(service=service1, options=options)
    # driver = webdriver.Chrome(ChromeDriverManager().install()) # // FIXME:
    # driver = webdriver.Chrome() # OK

    '''
        stealth(
            driver,
            languages=["us-US", "us"],
            vendor="Google Inc.",
            platform="Win32",
            webgl_vendor="Intel Inc.",
            renderer = "Intel Iris OpenGL Engine",
            fix_hairline=True,
            )


        # Create a request interceptor
        def interceptor(request):
            del request.headers['Referer']  # Delete the header first
            request.headers['Referer'] = 'some_referer'

        driver.request_interceptor = interceptor
    '''
    url = "https://www.google.com/maps/search/" + str(keyword)
    driver.get(url)
    time.sleep(3)

except:
    # traceback.format_exception(*sys.exc_info())
    e = sys.exc_info()[0]
    print("Unexpected error:", sys.exc_info()[0])
    raise
finally:
    driver.quit()
    print("finish options test")

sys.exit(0)
