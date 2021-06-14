#!/usr/bin/python3

# python3 transaction.py filename
# return 0: success
# listed only
# input bsContent_9904.html
# output 9904.txt colon seperated file for soffice input
# launch by soffice calc

import sys
from bs4 import BeautifulSoup

filename = sys.argv[1]
with open(filename, 'r') as f:
    contents = f.read()
    soup = BeautifulSoup(contents, 'html.parser')
tables = soup.find_all("table", {"width": "100%"})
counter = 0
n_table = 0; tmp_table = []; new_table = []
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

print( \
    'seq:', \
    'broker:', \
    'price:', \
    '#buy:', \
    '#sell' )

for tr in new_table:
    tds    = tr.find_all('td')
    seq    = int(tds[0].text.strip())
    broker = tds[1].text.strip()
    if ( 4 < len(broker) ):
        broker_full = broker
    broker = broker_full
    price  = float(tds[2].text.strip())
    bid    = tds[3].text.strip()
    ask    = tds[4].text.strip()
    print( \
        format(seq, '04d'), ':', \
        format(broker), ':', \
        format(price, '>4.2f'), ':', \
        format(bid, '>10s'), ':', \
        format(ask, '>10s') )
sys.exit(0)
