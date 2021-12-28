#!/usr/bin/python3

# python3 cb.py 2330
# return 0: not found, assume otc

import sys, requests, time, webbrowser
import urllib.request
from urllib.parse   import quote
from urllib.request import urlopen

from datetime import timedelta,datetime
from bs4 import BeautifulSoup

ticker = sys.argv[1]
# cb detail
# https://thefew.tw/quote/33462

# MOPS if any CB issued
mops_cb = 'http://mops.twse.com.tw/mops/web/ajax_t05st03?TYPEK=all&step=1&firstin=1&off=1&queryName=co_id&co_id=' + ticker

google_cb = "https://www.google.com/search?q=%22" + \
        ticker+"*%22+%22"+quote("債")+ \
        "%22&client=safari&rls=en&sxsrf=AOaemvKtRrhOd7f-DKEPVkGBeowA3PVEIg%3A1640718936202&ei=WGLLYe3TC9aGoATM4obwCQ&ved=0ahUKEwjt3_iqmof1AhVWA4gKHUyxAZ4Q4dUDCA0&uact=5&oq=%226150*%22+%22債%22&gs_lcp=Cgxnd3Mtd2l6LXNlcnAQAzIFCCEQoAE6BwgAEEcQsAM6BwgjEK4CECdKBAhBGABKBAhGGABQ9OUFWLj1BWC2hAZoAnACeACAAVaIAewEkgECMTGYAQCgAQHIAQbAAQE&sclient=gws-wiz-serp"

google_dr = "https://www.google.com/search?q=%22" + \
        ticker+"*%22+%22"+quote("存託憑證")+ \
        "%22&client=safari&rls=en&sxsrf=AOaemvKtRrhOd7f-DKEPVkGBeowA3PVEIg%3A1640718936202&ei=WGLLYe3TC9aGoATM4obwCQ&ved=0ahUKEwjt3_iqmof1AhVWA4gKHUyxAZ4Q4dUDCA0&uact=5&oq=%226150*%22+%22債%22&gs_lcp=Cgxnd3Mtd2l6LXNlcnAQAzIFCCEQoAE6BwgAEEcQsAM6BwgjEK4CECdKBAhBGABKBAhGGABQ9OUFWLj1BWC2hAZoAnACeACAAVaIAewEkgECMTGYAQCgAQHIAQbAAQE&sclient=gws-wiz-serp"

urls = [ \
    mops_cb, \
    google_cb, \
    google_dr ]

for url in urls:
    webbrowser.open(url)
    time.sleep(1)

# OCB
# https://www.cnyes.com/twstock/ocb3.aspx?code=2303

# https://www.tpex.org.tw/web/bond/publish/convertible_bond_search/memo.php?l=zh-tw
# https://www.tpex.org.tw/web/bond/publish/search/search.php?l=zh-tw

# detail
# MOPS
# https://mops.twse.com.tw/mops/web/t120sg01?TYPEK=&bond_id=66683&bond_kind=5&bond_subn=%24M00000001&bond_yrn=3&come=2&encodeURIComponent=1&firstin=ture&issuer_stock_code=6668&monyr_reg=202112&pg=&step=0&tg=

# DR 海外存託憑證
# https://www.cnyes.com/twstock/dr.aspx?code=2412
# 總表
# https://www.twse.com.tw/zh/page/trading/fund/FMGDRK.html
# There are ADR and GDR

sys.exit(0)
