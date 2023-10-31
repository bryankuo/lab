#!/usr/bin/env python3

# python3 sma5.py [ticker]
# python3 sma5.py [ticker] [flag]
# get sma5 from chart data
#
# \param in ticker
# \param in flag serving uno_status.sh
# return 0: success

import sys, os
from datetime import datetime

ticker = sys.argv[1]
sources = [                                                         \
    "https://concords.moneydj.com/z/zc/zcw/zcw1_"+ticker+".djhtm",
    "https://jsjustweb.jihsun.com.tw/z/zc/zcw/zcw_"+ticker+".djhtm",
    "https://trade.ftsi.com.tw/z/zc/zcw/zcw_" + ticker + ".djhtm",
    "https://just2.entrust.com.tw/z/zc/zcw/zcw.djhtm?A=" + ticker,
    "https://fubon-ebrokerdj.fbs.com.tw/z/zc/zcw/zcw1_"+ticker+".djhtm",
    "https://stockchannelnew.sinotrade.com.tw/z/zc/zcx/zcxnew_"+ticker+".djhtm",
    "https://moneydj.emega.com.tw/z/zc/zcw/zcw1_"+ticker+".djhtm",
    "https://stock.capital.com.tw/z/zc/zcw/zcw1.djhtm?a="+ticker,
    "https://fund.hncb.com.tw/Z/ZC/ZCW/ZCW_"+ticker+"_D.djhtm",
    "https://sjmain.esunsec.com.tw/z/zc/zcx/zcxnewEsunsec_" + ticker + ".djhtm"
]

timewaiting = [
    5,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    5
]

DIR0="datafiles/taiex/"

def save_to_file(soup, seed):
    fname = "sma5." + ticker + "." + datetime.today().strftime('%Y%m%d') + "." + str(seed) + '.html'
    path = os.path.join(DIR0, fname)
    with open(path, "w") as outfile2:
        outfile2.write(soup.prettify())
        outfile2.close()

def print_header(ticker, ofile):
    if ( ofile is None ):
        print("代號:sma5:sma20:sma60:vol:vol_sma5:vol_sma10")
    else:
        ofile.write("代號:sma5:sma20:sma60:vol:vol_sma5:vol_sma10" + "\n")
        ofile.flush()

def print_body(ticker, ofile, seed):
    import requests, time
    from bs4 import BeautifulSoup
    from selenium import webdriver
    from selenium.common.exceptions import SessionNotCreatedException
    from bs4 import BeautifulSoup

    # response = requests.get(url)
    browser = webdriver.Safari( \
        executable_path = '/usr/bin/safaridriver')
    url = sources[seed]
    browser.get(url)
    browser.switch_to.window(browser.current_window_handle) # testing to top
    # browser.maximize_window() # OK
    # time.sleep(3) # wait until page fully loaded ( or redirected )
    time.sleep(timewaiting[seed]) # differs from source to source
    page = browser.page_source
    soup = BeautifulSoup(page, 'html.parser')

    save_to_file(soup, seed)

    # browser.close()
    # in turn closes all web driver session @see shorturl.at/ltGPR
    browser.quit()

    SMAs    = soup.find_all("div", {"id": "fg0"})[0]
    sma5    = SMAs.find_all('span')[0].text.strip()
    sma5    = sma5[sma5.index(u'\xa0')+1:]
    sma5_d  = SMAs.find_all('span')[1].text.strip()

    sma20   = SMAs.find_all('span')[2].text.strip()
    sma20   = sma20[sma20.index(u'\xa0')+1:]
    sma20_d = SMAs.find_all('span')[3].text.strip()

    sma60   = SMAs.find_all('span')[4].text.strip()
    sma60   = sma60[sma60.index(u'\xa0')+1:]
    sma60_d = SMAs.find_all('span')[5].text.strip()

    vols    = soup.find_all("div", {"id": "fg1"})[0]
    vol      = vols.find_all('span')[0].text.strip()
    vol      = vol[vol.index(u'\xa0')+1:]
    v_sma5   = vols.find_all('span')[3].text.strip()
    v_sma5   = v_sma5[v_sma5.index(u'\xa0')+1:]
    v_sma10  = vols.find_all('span')[6].text.strip()
    v_sma10  = v_sma10[v_sma10.index(u'\xa0')+1:]

    if ( ofile is None ):
        print(sma5+sma5_d,   end=':')
        print(sma20+sma20_d, end=':')
        print(sma60+sma60_d, end=':')
        print(vol,           end=':')
        print(v_sma5,        end=':')
        print(v_sma10,       end='\n')
    else:
        ofile.write(ticker)
        ofile.write(':' + sma5+sma5_d)
        ofile.write(':' + sma20+sma20_d)
        ofile.write(':' + sma60+sma60_d)
        ofile.write(':' + vol)
        ofile.write(':' + v_sma5)
        ofile.write(':' + v_sma10)
        ofile.write('\n')
        ofile.flush()

def get_sma(ticker, seed):
    import requests, time
    from selenium import webdriver
    from selenium.common.exceptions import SessionNotCreatedException
    from bs4 import BeautifulSoup

    sma5 = '0'; sma5_d = '?'; sma20 = '0'; sma20_d = '?';
    sma60 = '0'; sma60_d = '?'; vol = 0; v_sma5 = 0; v_sma10 = 0
    try:
        browser = webdriver.Safari( \
            executable_path = '/usr/bin/safaridriver')
        url = sources[seed]
        # print(str(seed)+": "+url)
        browser.get(url)
        # browser.switch_to.window(browser.current_window_handle) # testing to top
        time.sleep(timewaiting[seed]) # differs from source to source
        page = browser.page_source
        soup = BeautifulSoup(page, 'html.parser')
        save_to_file(soup, seed)
        SMAs    = soup.find_all("div", {"id": "fg0"})[0]
        sma5    = SMAs.find_all('span')[0].text.strip() #.replace(u'\xa0', u'')
        sma5    = sma5[sma5.index(u'\xa0')+1:]
        sma5_d  = SMAs.find_all('span')[1].text.strip()

        sma20   = SMAs.find_all('span')[2].text.strip()
        sma20   = sma20[sma20.index(u'\xa0')+1:]
        sma20_d = SMAs.find_all('span')[3].text.strip()

        sma60   = SMAs.find_all('span')[4].text.strip()
        sma60   = sma60[sma60.index(u'\xa0')+1:]
        sma60_d = SMAs.find_all('span')[5].text.strip()

        # some 'SMA5 6.39' and some '成交量 315', it differs
        # use greatest common denominator
        vols    = soup.find_all("div", {"id": "fg1"})[0]
        vol      = vols.find_all('span')[0].text.replace(u'\xa0', ' ')
        v_sma5   = vols.find_all('span')[1].text.replace(u'\xa0', ' ')
        #v_sma5   = vols.find_all('span')[1].text.replace(u'\xa0', ' ') \
        #        .split(' ')[1].replace('張','')
        v_sma10  = vols.find_all('span')[2].text.replace(u'\xa0', ' ')
    except (SessionNotCreatedException):
        # print('turn on safari remote option.')
        sma5    = '0'
        sma20   = '0'
        sma60   = '0'
        sma5_d  = '?'
        sma20_d = '?'
        sma60_d = '?'
        vol     = 0
        v_sma5  = 0
        v_sma10 = 0

    finally:
        olist = [ sma5, sma5_d, sma20, sma20_d, sma60, sma60_d, \
            vol, v_sma5, v_sma10 ]
        print(olist)
        browser.minimize_window()
        browser.quit()
        # time.sleep(3) # wait until fully released ( test )

if __name__ == "__main__":
    import sys, requests, random
    n = random.randint(0,9)
    ticker = sys.argv[1]
    if ( 2 == len(sys.argv) ):
        print_header(ticker, None)
        print_body(ticker, None, n)
    elif ( 3 == len(sys.argv) ):
        get_sma(ticker, n)
    else:
        print("not support. " + str(len(sys.argv)))

# // TODO: large volume ( 2x )
