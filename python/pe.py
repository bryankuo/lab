#!/usr/bin/env python3

# python3 pe.py [ticker] [flag]
# \param in flag additional flag for uno_status.sh
# return 0: success

def print_header(ticker, ofile):
    if ( ofile is None ):
        print("代號:PER:52w高:52w低:同業平均")
    else:
        ofile.write("代號:PER:52w高:52w低:同業平均" + "\n")
        ofile.flush()

def print_body(ticker, ofile):
    import requests
    from bs4 import BeautifulSoup
    # source 1
    # url = 'http://5850web.moneydj.com/z/zc/zcx/zcxNew_' + ticker + '.djhtm'
    # source 2
    url = "https://concords.moneydj.com/z/zc/zca/zca_" + ticker + ".djhtm"
    response = requests.get(url)
    soup = BeautifulSoup(response.text, 'html.parser')
    # beta = soup.findAll('table')[3].find_all('tr')[7] \
    #    .find_all('td')[5].text
    pe = soup.findAll('table')[3].find_all('tr')[3] \
        .find_all('td')[1].text.strip()
    pe_peer = soup.findAll('table')[3].find_all('tr')[4] \
        .find_all('td')[1].text.strip()
    pe_hi = soup.findAll('table')[3].find_all('tr')[4] \
        .find_all('td')[3].text.strip()
    pe_lo = soup.findAll('table')[3].find_all('tr')[4] \
        .find_all('td')[5].text.strip()
    if ( pe is None ):
        sys.exit(1)
    if ( ofile is None ):
        print(ticker, end=':')
        print(pe, end=':')
        print(pe_hi, end=':')
        print(pe_lo, end=':')
        print(pe_peer, end='\n')
    else:
        ofile.write(ticker)
        ofile.write(':' + pe)
        ofile.write(':' + pe_hi)
        ofile.write(':' + pe_lo)
        ofile.write(':' + pe_peer)
        ofile.write('\n')
        ofile.flush()

def get_per(ticker):
    # print("get_activity " + ticker)
    import requests, random
    from bs4 import BeautifulSoup

    n = random.randint(1,3)
    if ( n == 1 ):
        # https://concords.moneydj.com/z/zc/zca/zca_2102.djhtm"
        url = "https://concords.moneydj.com/z/zc/zca/zca_" + \
            ticker + ".djhtm"
    elif ( n == 2 ):
        # https://fubon-ebrokerdj.fbs.com.tw/z/zc/zca/zca_2102.djhtm
        url = "https://fubon-ebrokerdj.fbs.com.tw/z/zc/zca/zca_" + \
            ticker + ".djhtm"
    else: # 3
        # http://jsjustweb.jihsun.com.tw/z/zc/zca/zca_2102.djhtm
        url = 'http://jsjustweb.jihsun.com.tw/z/zc/zca/zca_' + \
            ticker + '.djhtm'
    response = requests.get(url)
    soup = BeautifulSoup(response.text, 'html.parser')
    pe = soup.findAll('table')[0] \
        .find_all('table')[0] \
        .find_all('tr')[4] \
        .find_all('td')[1].text.strip()
    pe_peer = soup.findAll('table')[0] \
        .find_all('table')[0] \
        .find_all('tr')[5] \
        .find_all('td')[1].text.strip()
    pe_hi52 = soup.findAll('table')[0] \
        .find_all('table')[0] \
        .find_all('tr')[5] \
        .find_all('td')[3].text.strip()
    pe_lo52 = soup.findAll('table')[0] \
        .find_all('table')[0] \
        .find_all('tr')[5] \
        .find_all('td')[5].text.strip()
    if ( pe is None ):
        print('not found')
        sys.exit(1)
    olist = [ pe, pe_hi52, pe_lo52, pe_peer ]
    print(olist)

if __name__ == "__main__":
    import sys, requests
    from bs4 import BeautifulSoup

    ticker = sys.argv[1]
    if ( 2 == len(sys.argv) ):
        print_header(ticker, None)
        print_body(ticker, None)
    elif ( 3 == len(sys.argv) ):
        get_per(ticker)
    else:
        print("not support. " + str(len(sys.argv)))
