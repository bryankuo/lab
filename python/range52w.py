#!/usr/bin/env python3

# python3 range52w.py [ticker]
# return 0: success

def print_header(ticker, ofile):
    print("代號:價格:52w低價:低距％:52w高價:高距％")
    if ( ofile ):
        ofile.write("代號:價格:52w低價:低距％:52w高價:高距％" + "\n")
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
        ofile.write(':' + "{:>5.02f}".format(p_low52)+"%")
        ofile.write(':' + "{:>5.02f}".format(high52))
        ofile.write(':' + "{:>5.02f}".format(p_high52)+"%")
        ofile.write('\n')
        ofile.flush()

if __name__ == "__main__":
    import sys, requests
    from bs4 import BeautifulSoup
    ticker = sys.argv[1]
    print_header(ticker, None)
    print_body(ticker, None)
