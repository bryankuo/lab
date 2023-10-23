#!/usr/bin/env python3

# python3 activity.py [ticker]
# python3 activity.py [ticker] [flag]
#
# counting chips in recent 5 days,
# \param in ticker
# \param in flag, 0: TBD, 1: serving uno_status.sh,
#           show console if not provided.
# return 0: success

import sys
ticker = sys.argv[1]
sources = [                                                         \
    "http://fubon-ebrokerdj.fbs.com.tw/z/zc/zcl/zcl.djhtm?a=" + ticker + "&b=2",
    "http://jsjustweb.jihsun.com.tw/z/zc/zcl/zcl.djhtm?a=" + ticker + "&b=2",
    "https://concords.moneydj.com/z/zc/zcl/zcl.djhtm?a=" + ticker + "&b=2"
]
# // FIXME: per, eps, range, sma5

def print_header(ticker, ofile):
    print("代號:外資:投信:自營商:近5日合計")
    if ( ofile ):
        ofile.write("代號:外資:投信:自營商:近5日合計" + "\n")
        ofile.flush()

def print_body(ticker, ofile, seed):
    import requests
    from bs4 import BeautifulSoup

    url = sources[seed]
    # print(str(n) + ": " + url)
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
    print(ticker, end=':')
    print(qdi, end=':')
    print(fund, end=':')
    print(retail, end=':')
    print(total, end='\n')
    if ( ofile ):
        ofile.write(ticker)
        ofile.write(':' + qdi)
        ofile.write(':' + fund)
        ofile.write(':' + retail)
        ofile.write(':' + total)
        ofile.write('\n')
        ofile.flush()

# serving uno_status.sh
def get_activity(ticker, seed):
    # print("get_activity " + ticker)
    import requests, os
    from bs4 import BeautifulSoup

    url = sources[seed]
    # print(str(n) + ": " + url)
    response = requests.get(url)
    soup = BeautifulSoup(response.text, 'html.parser')
    '''
    DIR0="."
    fname = "activity." + ticker + "." + str(n) + '.html'
    path = os.path.join(DIR0, fname)
    with open(path, "w") as outfile2:
        outfile2.write(soup.prettify())
        outfile2.close()
    '''

    amounts = soup.find_all("tr", {"id": "oScrollFoot"})[0].find_all('td')
    if ( amounts is None ):
        sys.exit(1)
    sub_header = amounts[0].text.strip()
    qdi = amounts[1].text.strip()
    fund = amounts[2].text.strip()
    retail = amounts[3].text.strip()
    total = amounts[4].text.strip()
    olist = [ qdi, fund, retail, total ]
    print(olist)

if __name__ == "__main__":
    import sys, random #, requests
    from bs4 import BeautifulSoup

    ticker = sys.argv[1]
    # random source selection
    # random.seed()
    n = random.randint(0,2)
    if ( 2 == len(sys.argv) ):
        print_header(ticker, None)
        print_body(ticker, None, n)
    elif ( 3 == len(sys.argv) ):
        get_activity(ticker, n)
    else:
        print("not support. " + str(len(sys.argv)))
