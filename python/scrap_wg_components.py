#!/usr/bin/python3

# python3 scrap_wg_components.py [eid]
#
# \param  in eid
# \param out eid.csv
#
# return 0

import sys, requests, time, os
from datetime import timedelta, datetime
from pprint import pprint
from bs4 import BeautifulSoup

if ( len(sys.argv) < 2 ):
    print("python3 scrap_wg_components.py [id]")
    sys.exit(0)

eid = sys.argv[1]
DIR0="datafiles/taiex/etf_components"

ifname1 = eid + ".html"
ipath1  = os.path.join(DIR0, ifname1)

fname = eid + ".csv"
path = os.path.join(DIR0, fname)

print("from {}".format(ipath1))

try:
    f1 = open(ipath1)
    soup = BeautifulSoup(f1, 'html.parser')
    tables = soup.find_all("tbody", {"id": "holdingTable"})
    rows = tables[0].find_all("tr")
    print("# tables {}, # rows {}".format(len(tables), len(rows)))

    outfile = open(path, "w")
    for i in range(0, len(rows)-1 ):
        tkr = rows[i].find_all("td")[0].text.strip()
        print("{}".format(tkr))
        outfile.write(tkr+"\n" )
    outfile.close()
    print("to {}".format(path))

except:
    # traceback.format_exception(*sys.exc_info())
    e = sys.exc_info()[0]
    print("Unexpected error:", sys.exc_info()[0])
    raise

finally:
    pass
    # print("finally")

print("\ndone.")

sys.exit(0)
