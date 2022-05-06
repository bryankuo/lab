#!/usr/bin/python3

# python3 transaction.py filename
# output: sort by broker,price,buy,sell
# return 0: success

# source 1:
# listed only ( type 2 ) one cert one query, save frame as html
# input 買賣日報表查詢系統 https://bsr.twse.com.tw/bshtm/
# input bsContent_9904.html
# python3 transaction.py ~/Downloads/bsContent2006.html
# output 9904.txt colon seperated file for soffice input
# launch by soffice calc
# source 1.1:
# ( type 4 ) utf8 csv 5483_1110415.CSV one cert many query
# https://www.tpex.org.tw/web/stock/aftertrading/broker_trading/brokerBS.php?l=zh-tw

# source 2: hinet ( branch.py ), logon required.
# type 2, 4 applies, type 5 not included ( verified )
# https://histock.tw/stock/branch.aspx?no=2330
#  by ticker symbol
#  date is available, at most 14 days in range
#  https://histock.tw/stock/branch.aspx?no=1514&from=20210713&to=20210713

# source 3: moneyDJ*
# https://www.moneydj.com/Z/ZG/ZGB/ZGB0/ZGB0.djhtm
# https://www.moneydj.com/z/zg/zgb/zgb0.djhtm?a=9200&b=9200&c=E&e=2022-4-13&f=2022-4-13
# https://www.moneydj.com/z/zg/zgb/zgb0.djhtm?a=9200&b=0039003200300046
# a: broker major id
# https://www.moneydj.com/z/zg/zgb/zgb0.djhtm?a=9200&b=9208
# b: broker minor id

# source 4: fubon* ( identical input parameters )
# https://fubon-ebrokerdj.fbs.com.tw/Z/ZG/ZGB/ZGB.djhtm
#  by broker
# https://fubon-ebrokerdj.fbs.com.tw/z/zg/zgb/zgb0.djhtm?a=1380&b=1380&c=B&e=2021-12-1&f=2021-12-3
# https://fubon-ebrokerdj.fbs.com.tw/z/zg/zgb/zgb0.djhtm?a=9200&b=9208&c=B&e=2022-4-14&f=2022-4-15

# source 5: *
# http://jsjustweb.jihsun.com.tw/z/zg/zgb/zgb0.djhtm?a=9800&b=9875

# source 6, for each broker, for each ticker,
#  display positions in time period
# https://histock.tw/stock/brokertrace.aspx?bno=1560&no=3008
# // TODO: there are exact daily numbers in wangoo

# how to parse? what do they offer?
# what is this? type2, type4, how about type5?
# who they are?
# what ticker has something todo with major buyer/seller?

import sys
from bs4 import BeautifulSoup

ticker   = sys.argv[1]
stamp    = sys.argv[2]
filename = sys.argv[3]

with open(filename, 'r') as f:
    contents = f.read()
    soup = BeautifulSoup(contents, 'html.parser')
tables = soup.find_all("table", {"width": "100%"})
counter = 0
n_table = 0; tmp_table = []; new_table = [];
for table in tables:
    if ( counter % 3 != 0 ):
        rows = table.select('tr[class*="column_value_price_"]')
        if ( n_table % 2 == 0 ):
            tmp_table.clear()
            tmp_table = rows.copy()
        else:
            for i, e in reversed(list(enumerate(rows))):
                tmp_table.insert(i+1, e)
            new_table.extend(tmp_table)
        n_table += 1
    counter += 1

n_trans = 0; bdes = ''
file_name = 'datafiles/' + ticker + '/' + stamp + '.txt'
with open(file_name, 'w') as the_file:
    the_file.write( 'seq :broker:price:#buy:#sell\n' )
    for tr in new_table:
        tds    = tr.find_all('td')
        pattern = "\x20\x20\x20\x20\x0a\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20"
        # print( str(n_trans) + ": " + tds[0].text.replace(pattern,'').encode("utf-8").hex() )
        txt = tds[0].text.replace(pattern,'').strip()
        if not txt.isnumeric():
            continue # exclude last line
        seq    = int( txt )
        bno    = tds[1].text.strip()[0:4]
        broker = tds[1].text.strip()
        # for type 2, no redundant desc, therefore keep it for next round
        if ( 4 < len(broker) ):
            # pattern1 = "\xe3\x80\x80\xe3\x80\x80"
            bdes   = tds[1].text.strip()[4:].replace(' ','')
            # bdes   = bdes.replace(pattern1, '')
            # print(bdes.encode("utf-8").hex())
            # print(bdes)
            broker = bno + '-' + bdes
            broker_full = broker
        broker = broker_full
        price  = float(tds[2].text.strip().replace(',',''))
        # float(tds[2].text.strip())
        bid    = int(tds[3].text.strip().replace(',',''))
        ask    = int(tds[4].text.strip().replace(',',''))
        row    = format(seq, '04d') + ':' + \
                 format(broker) + ':' + \
                 format(price, '>4.2f') + ':' + \
                 format(bid, '>10d') + ':' + \
                 format(ask, '>10d') + '\n'
        the_file.write( row )
        n_trans = n_trans + 1

print( ticker + " " + stamp + " " + \
    str(len(new_table)-1) + " transactions." )

sys.exit(0)
