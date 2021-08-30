#!/usr/bin/env python3

# python3 pe.py [ticker]
# return 0: success

def print_header1():
    print("代號:PE:52w高:52w低:同業平均")

def print_body1(ticker):
    import requests
    from bs4 import BeautifulSoup
    url = 'http://5850web.moneydj.com/z/zc/zcx/zcxNew_' + ticker + '.djhtm'
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
    print(ticker, end=':')
    print(pe, end=':')
    print(pe_hi, end=':')
    print(pe_lo, end=':')
    print(pe_peer, end='\n')

if __name__ == "__main__":
    import sys, requests
    from bs4 import BeautifulSoup
    ticker = sys.argv[1]
    print_header1()
    print_body1(ticker)
