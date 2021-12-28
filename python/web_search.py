#!/usr/bin/python3

# python3 web_search.py 2330
# return 0: success

import sys, requests, time, webbrowser
from urllib.parse   import quote
from urllib.request import urlopen

ticker = sys.argv[1]

ticker_news = \
    "http://jsjustweb.jihsun.com.tw/Z/ZC/ZCV/ZCV_" + ticker + ".djhtm"

fundamental = \
    "http://jsjustweb.jihsun.com.tw/z/zc/zca/zca.djhtm?a=" + ticker

# google news search
# unicode encoding ( https://bit.ly/3syqeyC )
google_news = "https://www.google.com/search?q="+ticker+"+"+quote("新聞")+"&client=safari&rls=en&sxsrf=AOaemvKTMQonLWeFKMTZV9EVT1oZ0KIqdw:1639210457623&source=lnms&tbm=nws&sa=X&ved=2ahUKEwjXi6foptv0AhWCJaYKHcRACmYQ_AUoAXoECAEQAw&biw=1437&bih=703&dpr=1"

subsidiary = "https://www.cmoney.tw/finance/f00031.aspx?s="+ticker

revenue_mom = \
    "https://goodinfo.tw/StockInfo/ShowSaleMonChart.asp?STOCK_ID="+ticker

groups = "https://thaubing.gcaa.org.tw/group/name/G"+ticker

volume_profile = \
    "https://www.esunsec.com.tw/tw-stock/z/zc/zcw/zcwg/zcwg.djhtm?id=" \
    + ticker

tech_chart = "https://invest.cnyes.com/twstock/TWS/" + ticker + "/technical"

institution_holdings = "https://www.wantgoo.com/stock/" + ticker \
    + "/institutional-investors/trend"

hinet_technicals = "https://histock.tw/stock/"+ticker

cmoney_gossip = "https://www.cmoney.tw/follow/channel/stock-" + \
    ticker +"?chart=d&type=Personal"

share_outstanding = \
    "https://norway.twsthr.info/StockHolders.aspx?stock="+ticker

moneydj_profile = \
    "https://www.google.com/search?client=safari" + \
    "&rls=en&q=moneydj+"+quote("財經百科")+"+"+ticker+"&ie=UTF-8&oe=UTF-8"

pttstock_gossip = "https://www.google.com/search?q="+ticker+"+ptt+stock&client=safari&sxsrf=ALeKk02tz2-BrxlgznV37pUb3jBhfWDw8A:1623571437756&source=lnt&tbs=qdr:y&sa=X&ved=2ahUKEwi1i8L2kpTxAhWrzIsBHeciAhQQpwV6BAgBECQ&biw=1440&bih=709"

hr104_search = "https://www.google.com/search?q="+ticker+"+104&client=safari&rls=en&sxsrf=AOaemvJQ_3UVNBgOgvmw8LgOPjMQ6ukDmw%3A1637394407406&ei=56eYYZ__F-DR2roPua-g6A4&ved=0ahUKEwjfjorAuab0AhXgqFYBHbkXCO0Q4dUDCA0&uact=5&oq=6152+104&gs_lcp=Cgdnd3Mtd2l6EAM6CAgAEAcQChAeOgQIABAeOgYIABAIEB46CAgAEAgQBxAeOgIIJjoGCAAQBxAeOgUIABCRAjoFCAAQgAQ6CwguEIAEEMcBEK8BOggIABAHEAUQHkoECEEYAVD-BFiPKGC1KmgCcAB4AIABcYgBkwWSAQM3LjKYAQCgAQHAAQE&sclient=gws-wiz"

revenue_yoy = \
    "http://fubon-ebrokerdj.fbs.com.tw/z/zc/zch/zch_" + ticker + ".djhtm"

google_gm_image = \
    "https://www.google.com/search?q=%22"+ \
    ticker + "*%22+%22" + quote("總經理") + "%22&client=safari&rls=en&sxsrf=AOaemvJXeaXjO0UbVWkuEdDa9LoCtKikwA:1640721761933&source=lnms&tbm=isch&sa=X&ved=2ahUKEwjl3q3upIf1AhU2yosBHTRcByMQ_AUoA3oECAEQBQ&biw=1440&bih=709&dpr=1"

google_chairman_image = \
    "https://www.google.com/search?q=%22"+ \
    ticker + "*%22+%22" + quote("董事長") + "%22&client=safari&rls=en&sxsrf=AOaemvJXeaXjO0UbVWkuEdDa9LoCtKikwA:1640721761933&source=lnms&tbm=isch&sa=X&ved=2ahUKEwjl3q3upIf1AhU2yosBHTRcByMQ_AUoA3oECAEQBQ&biw=1440&bih=709&dpr=1"

management = ""

urls = [ \
    fundamental, \
    revenue_mom, \
    groups, \
    subsidiary, \
    ticker_news, \
    volume_profile, \
    revenue_yoy, \
    google_news, \
    tech_chart, \
    institution_holdings, \
    hinet_technicals, \
    cmoney_gossip, \
    pttstock_gossip, \
    hr104_search, \
    share_outstanding, \
    moneydj_profile, \
    google_gm_image, \
    google_chairman_image, \
    management ]

for url in urls:
    webbrowser.open(url)
    time.sleep(1)

sys.exit(0)
