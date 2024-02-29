#!/usr/bin/python3

# python3 top150.py
# serving rank.sh
# get top 150 market value, in the unit of hundred million
# \param out top150_market_value...
# return 0
# 138:3406玉晶光:555.55
# source 8, 5 pages, top 150, update everyday, market value, rank
# use selenium, and firefox example:
# https://stackoverflow.com/a/36027884

import sys, requests, time, re, os
import urllib.request
from datetime import timedelta,datetime
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.common.exceptions import SessionNotCreatedException

fetch_date = sys.argv[1]

DIR0="./datafiles/taiex"
fname = "top150_market_value" + "." + fetch_date + ".txt"
fname2 = "bountylist.top150_market_value" + "." + fetch_date + ".txt"
path = os.path.join(DIR0, fname)
path2 = os.path.join(DIR0, fname2)

try:
    browser = webdriver.Safari( \
        executable_path = '/usr/bin/safaridriver')

    with open(path, 'wt') as ofile, open(path2, 'wt') as ofile2:
        ofile.write("排行:代號公司:總市值(E)\n")
        for i in range(1,6):
            # https://pchome.megatime.com.tw/rank/sto2/ock31_1.html
            url = 'https://pchome.megatime.com.tw/rank/sto2/'+ \
                'ock31_'+str(i)+'.html'
            # browser.set_page_load_timeout(5) # delay before browser open?
            browser.get(url)
            time.sleep(5) # wait until page fully loaded ( or redirected )
            page = browser.page_source
            soup = BeautifulSoup(page, 'html.parser')

            name = "top150_market_value" + "." + fetch_date \
                + "." + str(i) + ".html"
            path1 = os.path.join(DIR0, name)
            with open(path1, "w") as outfile1:
                outfile1.write(soup.prettify())
                outfile1.close()
            print(path1)

            tables = soup.find_all("div", {"id": "rank_table"})
            rows = soup.find_all("div", {"id": "rank_table"})[0] \
                .find_all("tr")
            for i in range(1, len(rows)):
                rank     = rows[i].find_all('td')[0].text.strip()
                tkr_name = rows[i].find_all('td')[1].text.strip()
                ticker = tkr_name[ \
                    tkr_name.find("(")+1:tkr_name.find(")")]
                corp_name = \
                        tkr_name[0:tkr_name.find("(")].strip()
                pattern = re.compile(r'\s+')
                corp_name = re.sub(pattern, '', corp_name)
                mkt_value = rows[i].find_all('td')[2].text.strip()
                ofile.write( \
                    rank + ":" + \
                    ticker + corp_name + ":" + \
                    mkt_value + "\n" )
                ofile2.write( ticker + "\n" )
        # browser.close()
        print(path)

except SessionNotCreatedException as ex:
    print(str(ex))
    print('make sure safari automation enabled.')
    browser.close()

finally:
    browser.quit()
    sys.exit(0)
