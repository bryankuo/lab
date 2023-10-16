#!/usr/bin/env python3

# python3 eps.py [ticker]
# return 0: success

def get_from_source(ticker):
    import time
    from datetime import datetime
    from selenium import webdriver
    from bs4 import BeautifulSoup
    # source 1
    # https://stock.wespai.com/p/7733
    # url = "https://stock.wespai.com/p/7733"
    # source 2
    # https://stock.wespai.com/p/21988
    # url = "https://stock.wespai.com/p/21988"

    # source 3
    # https://goodinfo.tw/StockInfo/StockFinDetail.asp?RPT_CAT=XX_M_QUAR&QRY_TIME=20212&STOCK_ID=1227
    year  = datetime.today().strftime('%Y')
    month = datetime.today().strftime('%m')
    quarter = (int(month) - 1) # // 3 + 1.
    quarter = quarter - 2 # to get 2 quarter away
    if ( quarter <= 0 ):
        quarter = 4
        year = str( int(year) - 1 )
    quarter_s = "{:d}".format(quarter)
    # datetime.today().strftime('%Y-%m-%d')
    url = "https://goodinfo.tw/StockInfo/StockFinDetail.asp?" + \
        "RPT_CAT=XX_M_QUAR" + \
        "&QRY_TIME=" + year + quarter_s + \
        "&STOCK_ID="+ticker
    # RPT_CAT: [ XX_M_QUAR ... XX_QUAR ]
    # site is under maintenance at 10 o'clock in the morning.
    # print(url)
    try:
        browser = webdriver.Safari(executable_path = '/usr/bin/safaridriver')
        if ( browser is None ):
            print("make sure safari automation enabled")
            sys.exit(3)
        browser.get(url)
        time.sleep(6) # wait until page fully loaded
        page = browser.page_source
        soup = BeautifulSoup(page, 'html.parser')
    except (SessionNotCreatedException):
        print('make sure allow remote is on')
    finally:
        browser.quit()
        time.sleep(1) # wait until fully released ( test )
    return soup

def print_header(ticker, soup, ofile):
    num_q_available = 10 # depends upon source 3
    title = soup.find("meta",  {"name":"description"})
    name = title["content"].split(' ')[0].split(')')[1].strip()
    ths = soup.find("div", {"id": "divFinDetail"}) \
        .find_all('tr')[0] \
        .find_all('th')
    print("代號", end=':')
    print("公司", end=':')
    for i in range(1, len(ths)):
        quarter = ths[i].text
        if ( i < num_q_available ):
            print(quarter, end=':')
        else:
            print(quarter, end='\n')
    if ( ofile ):
        ofile.write("代號")
        ofile.write(':' + "公司")
        for i in range(1, len(ths)):
            quarter = ths[i].text
            ofile.write(':' + quarter)
        ofile.write('\n')
        ofile.flush()
    return name

def print_body(ticker, name, soup, ofile):
    num_q_available = 10
    # print(soup.prettify())
    # tds = soup.find("div", {"id": "divFinDetail"}) \
    tds = soup.find("table", {"class": "b1 p4_4 r0_10 row_mouse_over"}) \
        .find_all('tr')[7] \
        .find_all('td')
    if ( name is None ):
        title = soup.find("meta",  {"name":"description"})
        name = title["content"].split(' ')[0].split(')')[1].strip()
    print(ticker, end=':')
    print(name, end=':')
    for i in range(1, len(tds)):
        if ( tds[i].text == '-' ):
            eps = 0
        else:
            eps = float(tds[i].text)
        if ( i < num_q_available ):
            print("{:>.02f}".format(eps), end=':')
        else:
            print("{:>.02f}".format(eps), end='\n')
    if ( ofile ):
        ofile.write(ticker)
        ofile.write(':' + name)
        for i in range(1, len(tds)):
            if ( tds[i].text == '-' ):
                eps = 0
            else:
                eps = float(tds[i].text)
            ofile.write(':' + "{:>.02f}".format(eps))
        ofile.write('\n')
        ofile.flush()

def get_eps(ticker, soup):
    num_q_available = 10
    # print(soup.prettify())
    tds = soup.find("table", {"class": "b1 p4_4 r0_10 row_mouse_over"}) \
        .find_all('tr')[7] \
        .find_all('td')
    olist = []
    for i in range(1, len(tds)):
        if ( tds[i].text == '-' ):
            eps = 0
        else:
            eps = float(tds[i].text)
        olist.append( "{:>.02f}".format(eps) )
    print(olist)

if __name__ == "__main__":
    import sys, requests
    from pprint import pprint

    ticker = sys.argv[1]
    soup = get_from_source(ticker)
    if ( 2 == len(sys.argv) ):
        name = print_header(ticker, soup, None)
        print_body(ticker, name, soup, None)
    elif ( 3 == len(sys.argv) ):
        get_eps(ticker, soup)
    else:
        print("not support. " + str(len(sys.argv)))

# // TODO: 毛利率/營業利益率 @see https://bit.ly/3XumrPR
# fetch_opm fetch_gm
