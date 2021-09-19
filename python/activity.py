#!/usr/bin/env python3

# python3 activity.py [ticker]
# return 0: success

def print_header(ticker, ofile):
    if ( ofile is None ):
        print("代號:外資:投信:自營商:近5日合計")
    else:
        ofile.write("代號:外資:投信:自營商:近5日合計")
        ofile.write('\n')
        ofile.flush()

def print_body(ticker, ofile):
    import requests
    from bs4 import BeautifulSoup
    # source 1
    # https://fubon-ebrokerdj.fbs.com.tw/z/zc/zcl/zcl.djhtm?a=2303&b=1
    url = 'https://fubon-ebrokerdj.fbs.com.tw/z/zc/zcl/zcl.djhtm?' + \
        'a=' + ticker + '&b=2'
    # source 2 ( interchangable )
    # http://jsjustweb.jihsun.com.tw/z/zc/zcl/zcl.djhtm?a=5820&b=1
    # url = 'http://jsjustweb.jihsun.com.tw/z/zc/zcl/zcl.djhtm?a=' + \
    #     ticker + '&b=2'
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

    if ( ofile is None ):
        print(ticker, end=':')
        print(qdi, end=':')
        print(fund, end=':')
        print(retail, end=':')
        print(total, end='\n')
    else:
        ofile.write(ticker)
        ofile.write(':' + qdi)
        ofile.write(':' + fund)
        ofile.write(':' + retail)
        ofile.write(':' + total)
        ofile.write('\n')
        ofile.flush()

if __name__ == "__main__":
    import sys, requests
    from bs4 import BeautifulSoup
    ticker = sys.argv[1]
    print_header(ticker, None)
    print_body(ticker, None)
