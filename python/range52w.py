#!/usr/bin/env python3

# python3 range52w.py [ticker]
# python3 range52w.py [ticker] [flag]
#
# return 0: success
import sys
ticker = sys.argv[1]
sources = [                                                         \
    "https://concords.moneydj.com/z/zc/zca/zca_" + ticker + ".djhtm",
    'http://jsjustweb.jihsun.com.tw/z/zc/zca/zca_' + ticker + '.djhtm',
    "https://trade.ftsi.com.tw/z/zc/zca/zca_" + ticker + ".djhtm",
    "https://just2.entrust.com.tw/z/zc/zca/zca.djhtm?A=" + ticker
]
# // FIXME: eps, sma5

def print_header(ticker, ofile):
    print("代號:價格:52w低價:低距％:52w高價:高距％")
    if ( ofile ):
        ofile.write("代號:價格:52w低價:低距％:52w高價:高距％" + "\n")
        ofile.flush()

def print_body(ticker, ofile, seed):
    import requests
    from bs4 import BeautifulSoup

    url = sources[seed]
    response = requests.get(url)
    soup = BeautifulSoup(response.text, 'html.parser')
    # beta = soup.findAll('table')[3].find_all('tr')[7] \
    #    .find_all('td')[5].text
    rows = soup.select('table .t01 tr')
    # per = rows[3].select('td')[1].renderContents().decode("utf-8")
    opn = float(rows[1].select('td')[1].renderContents())
    quote = float(rows[1].select('td')[7].renderContents())
    # name = rows[0].select('td')[0].renderContents() \
    #    .decode("utf-8").split("(")[0].strip()
    tds = rows[2].select('td')
    low52 = float(tds[5].renderContents())
    high52 = float(tds[3].renderContents())
    spans= tds[1].select('span')
    change = float(spans[0].renderContents()) / opn
    p_low52 = ( low52 - quote ) * 100 / quote
    p_high52 = ( high52 - quote ) * 100 / quote

    print(ticker, end=':')
    # print(name, end=':')
    print("{:>5.02f}".format(quote), end=':')
    print("{:>5.02f}".format(low52), end=':')
    print("{:>5.02f}".format(p_low52)+"%", end=':')
    print("{:>5.02f}".format(high52), end=':')
    print("{:>5.02f}".format(p_high52)+"%", end='\n')
    if ( ofile ):
        ofile.write(ticker)
        ofile.write(':' + "{:>5.02f}".format(quote))
        ofile.write(':' + "{:>5.02f}".format(low52))
        # ofile.write(':' + "{:>5.02f}".format(p_low52)+"%")
        ofile.write(':' + "{:>5.02f}".format(p_low52))
        ofile.write(':' + "{:>5.02f}".format(high52))
        # ofile.write(':' + "{:>5.02f}".format(p_high52)+"%")
        ofile.write(':' + "{:>5.02f}".format(p_high52))
        ofile.write('\n')
        ofile.flush()

def get_range52w(ticker, seed):
    # print("get_activity " + ticker)
    import requests #, random
    from bs4 import BeautifulSoup

    url = sources[seed]
    # print(str(seed) + ": " + url)
    response = requests.get(url)
    soup = BeautifulSoup(response.text, 'html.parser')
    rows = soup.select('table .t01 tr')
    opn = float(rows[1].select('td')[1].renderContents())
    quote = float(rows[1].select('td')[7].renderContents())
    tds = rows[2].select('td')
    low52 = float(tds[5].renderContents())
    if ( low52 is None ):
        print('not found')
        sys.exit(1)
    high52 = float(tds[3].renderContents())
    spans= tds[1].select('span')
    change = float(spans[0].renderContents()) / opn
    p_low52 = ( low52 - quote ) * 100 / quote
    p_high52 = ( high52 - quote ) * 100 / quote
    olist = [                       \
        "{:>.02f}".format(low52),   \
        "{:>.02f}".format(p_low52), \
        "{:>.02f}".format(high52),  \
        "{:>.02f}".format(p_high52) ]
    print(olist)

if __name__ == "__main__":
    import sys, requests, random

    ticker = sys.argv[1]
    n = random.randint(0,3)
    if ( 2 == len(sys.argv) ):
        print_header(ticker, None)
        print_body(ticker, None, n)
    elif ( 3 == len(sys.argv) ):
        get_range52w(ticker, n)
    else:
        print("not support. " + str(len(sys.argv)))
