#!/usr/bin/python3

# python3 borrowing_daily.py

import sys, webbrowser
from datetime import datetime

# borrow/菲神/標借 site:twse.com.tw / 標借證券明細表
# count the # of borrowing, compare with that of yesterday
# type 2
# https://www.twse.com.tw/rwd/zh/borrow/BFIB8U?response=html # 上市
type2 = "https://www.twse.com.tw/rwd/zh/borrow/BFIB8U?response=html"

# type 4 ( input is required )
# https://www.tpex.org.tw/web/stock/margin_trading/lend/lend_result.php?sd=113/04/01&ed=113/04/01&stkno=&s=0,asc,1&o=htm
roc_yr = str(int(datetime.today().strftime("%Y")) - 1911)
dt     = datetime.today().strftime("%m") \
    + "/" + datetime.today().strftime("%d")
sdt    = roc_yr + "/" + dt
edt    = roc_yr + "/" + dt
type4 = "https://www.tpex.org.tw" + \
    "/web/stock/margin_trading/lend/lend_result.php?" + \
    "sd=" + sdt + "&ed="+ edt + "&stkno=&s=0,asc,1&o=htm"
print("type 4 {}".format(type4))

borrowing_daily_announcement = [ type2, type4 ]

for url in borrowing_daily_announcement:
    webbrowser.open(url)
    # input("Press Enter to continue...")
    # print('\a') # beep works

sys.exit(0)
# // TODO: count # of lines, everyday
