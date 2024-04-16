#!/usr/bin/python3

# python3 gretai50.py [yyyymmdd] [net|file]
# \param in  富櫃50指數成分股資訊
# \param out gretai50.txt
# scrap_market_value.sh => call gretai50.py then uno/load/gretai50_component.py
# instead
# return 0

import os, sys, requests, time, random, csv
import urllib.request
from datetime import timedelta, datetime
from bs4 import BeautifulSoup
from pprint import pprint
sys.path.append(os.getcwd())
import useragents as ua

# print( len(sys.argv) )
# print(sys.argv)

if ( len(sys.argv) < 2 ):
    print("python3 after_market.py [yyyymmdd] [net|file]")
    sys.exit(0)

from_file     = True
if ( len(sys.argv) < 3 ):
    yyyymmdd = datetime.today().strftime('%Y%m%d')
    if ( int(sys.argv[1]) == 0 ):
        from_file     = False
else:
    yyyymmdd = sys.argv[1]
    if ( int(sys.argv[2]) == 0 ):
        from_file     = False

DIR0 = "./datafiles/taiex/etf_components" # // FIXME: be done in .sh script
if not os.path.exists(DIR0):
    os.mkdir(DIR0)

fname = 'gretai50.' + yyyymmdd + '.html'
html_path = os.path.join(DIR0, fname)

fname0 = 'gretai50.txt'
path0 = os.path.join(DIR0, fname0)

if ( from_file ):
    print("from {}".format(html_path))
    fp = open(html_path, 'r')
    soup = BeautifulSoup(fp, 'html.parser')
    lst = [None] * 50; count = 0
    rows = soup.find_all("table", {})[0] \
        .find_all("tbody")[0] \
        .find_all("tr")
    n_rows = len(rows)
    for i in range(0, n_rows):
        tds = rows[i].find_all("td")
        n_tds = len(tds)
        for j in range(0, n_tds):
            if ( j % 2 == 0 ):
                if ( 0 < len(tds[j].text.strip()) ):
                    rank = int( tds[j].text.strip() )
                    print("count {:>02} rank {:>02}".format(count+1, rank))
                    tkr  = int( tds[j+1].text.strip().split('\xa0')[0] )
                    lst[rank-1] = tkr; count += 1
                else:
                    continue
    fp.close()

    # pprint(lst)
    f = open(path0, 'w')
    # f = csv.writer(path0, lineterminator='\n')
    # @see https://www.geeksforgeeks.org/python-save-list-to-csv/
    # writer = csv.writer(f)
    # f.writerow(lst)
    for element in lst:
        f.write(str(element) + '\n')
    f.close()
    print("to {}".format(path0))
else:
    url = "https://www.tpex.org.tw/web/stock/iNdex_info/" + \
        "gretai50/ingrid/r50cnstnt_result.php?l=zh-tw&s=0,asc,0&o=htm"
    print("from {}".format(url))
    headers = {'User-Agent': random.choice(ua.list)}
    response = requests.get(url, headers=headers)
    # response.encoding = 'cp950'
    soup = BeautifulSoup(response.text, 'html.parser')
    outfile2 = open(html_path, "w")
    outfile2.write(soup.prettify())
    outfile2.close()
    print("to {}".format(html_path))

sys.exit(0)
