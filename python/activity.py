#!/usr/bin/env python3

# python3 activity.py [ticker]
# return 0: success

def print_header():
    print("代號:外資:投信:自營商:合計")

def print_body(ticker):
    import requests
    from bs4 import BeautifulSoup
    # source 1
    # https://fubon-ebrokerdj.fbs.com.tw/z/zc/zcl/zcl.djhtm?a=2303&b=2
    # url = 'https://fubon-ebrokerdj.fbs.com.tw/z/zc/zcl/zcl.djhtm?' + \
    #    'a=' + ticker + '&b=2'
    # source 2 ( interchangable )
    # http://jsjustweb.jihsun.com.tw/z/zc/zcl/zcl.djhtm?a=5820&b=2
    url = 'http://jsjustweb.jihsun.com.tw/z/zc/zcl/zcl.djhtm?a=' + \
        ticker + '&b=2'
    response = requests.get(url)
    soup = BeautifulSoup(response.text, 'html.parser')
    amounts = soup.find_all("tr", {"id": "oScrollFoot"})[0].find_all('td')
    if ( amounts is None ):
        sys.exit(1)
    sub_header = amounts[0].text.strip()
    qdi = amounts[1].text.strip()
    fund = amounts[2].text.strip()
    retail = amounts[3].text.strip()
    total = amounts[4].text.strip()

    # print(header)
    print(ticker, end=':')
    print(qdi, end=':')
    print(fund, end=':')
    print(retail, end=':')
    print(total, end='\n')

if __name__ == "__main__":
    import sys, requests
    from bs4 import BeautifulSoup
    ticker = sys.argv[1]
    print_header()
    print_body(ticker)
