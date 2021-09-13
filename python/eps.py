#!/usr/bin/env python3

# python3 eps.py [ticker]
# return 0: success

def get_from_source(ticker):
    import time
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
    url = "https://goodinfo.tw/StockInfo/StockFinDetail.asp?RPT_CAT=XX_M_QUAR&QRY_TIME=20212&STOCK_ID="+ticker
    browser = webdriver.Safari(executable_path = '/usr/bin/safaridriver')
    if ( browser is None ):
        print("make sure safari automation enabled")
        sys.exit(3)
    browser.get(url)
    time.sleep(7) # wait until page fully loaded
    page = browser.page_source
    soup = BeautifulSoup(page, 'html.parser')
    browser.close()
    '''
    with open("eps.txt.2") as fp:
        soup = BeautifulSoup(fp, 'html.parser')
    '''
    return soup

def print_header(ticker, soup, ofile):
    num_q_available = 10
    title = soup.find("meta",  {"name":"description"})
    name = title["content"].split(' ')[0].split(')')[1].strip()
    ths = soup.find("div", {"id": "divFinDetail"}) \
        .find_all('tr')[0] \
        .find_all('th')
    if ( ofile is None ):
        print("代號", end=':')
        print("公司", end=':')
        for i in range(1, len(ths)):
            quarter = ths[i].text
            if ( i < num_q_available ):
                print(quarter, end=':')
            else:
                print(quarter, end='\n')
    else:
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
    tds = soup.find("div", {"id": "divFinDetail"}) \
        .find_all('tr')[7] \
        .find_all('td')
    if ( name is None ):
        title = soup.find("meta",  {"name":"description"})
        name = title["content"].split(' ')[0].split(')')[1].strip()
    if ( ofile is None ):
        print(ticker, end=':')
        print(name, end=':')
        for i in range(1, len(tds)):
            eps = float(tds[i].text)
            if ( i < num_q_available ):
                print("{:>.02f}".format(eps), end=':')
            else:
                print("{:>.02f}".format(eps), end='\n')
    else:
        ofile.write(ticker)
        ofile.write(':' + name)
        for i in range(1, len(tds)):
            eps = tds[i].text
            ofile.write(':' + eps)
        ofile.write('\n')
        ofile.flush()

if __name__ == "__main__":
    import sys, requests
    # from bs4 import BeautifulSoup
    from pprint import pprint
    # from selenium import webdriver

    ticker = sys.argv[1]
    soup = get_from_source(ticker)
    name = print_header(ticker, soup, None)
    print_body(ticker, name, soup)
