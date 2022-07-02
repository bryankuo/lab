#!/usr/bin/python3

# python3 web_search.py 2330
# return 0: success

import sys, requests, time, webbrowser
from urllib.parse   import quote
from urllib.request import urlopen

ticker = sys.argv[1]
if ( len(sys.argv) > 2 ):
    co_name = sys.argv[2]
    co_addr = sys.argv[3]
    chairman = sys.argv[4]
    gm = sys.argv[5]
    #//TODO: pass as search parameter
    '''
    print(co_addr)
    print(chairman)
    print(gm)
    sys.exit(0)
    '''
    co_type = sys.argv[6]

ticker_news = \
    "http://jsjustweb.jihsun.com.tw/Z/ZC/ZCV/ZCV_" + ticker + ".djhtm"

fundamental = \
    "http://jsjustweb.jihsun.com.tw/z/zc/zca/zca.djhtm?a=" + ticker

comparison = "https://mopsfin.twse.com.tw"

# google news search
# unicode encoding ( https://bit.ly/3syqeyC )
google_news_past_year = "https://www.google.com/search?q=" + \
    ticker+"+"+quote(co_name)+"+"+quote("新聞")+ \
    "&client=safari&rls=en&sxsrf=AOaemvKTMQonLWeFKMTZV9EVT1oZ0KIqdw:"  + \
    "1639210457623&source=lnms&tbm=nws&sa=X&ved=2ahUKEwjXi6foptv0AhWC" + \
    "JaYKHcRACmYQ_AUoAXoECAEQAw&biw=1437&bih=703&dpr=1"

google_news_past_month = "https://www.google.com/search?q="+ticker+"+"+quote(co_name)+"+ptt+stock&client=safari&sxsrf=AOaemvL0avYEloIhMAK972aGGrvD8Q2uRA:1641678179089&source=lnt&tbs=qdr:m&sa=X&ved=2ahUKEwiRnczlj6P1AhWLHXAKHa7EAJ8QpwV6BAgBEBg&biw=1396&bih=708&dpr=1"

google_news_past_week = "https://www.google.com/search?q="+ticker+"+"+quote(co_name)+"+ptt+stock&client=safari&rls=en&sxsrf=AOaemvJsxUJoN92AaqXX-OrtFeeDwiKuyg:1641688213276&source=lnt&tbs=qdr:w&sa=X&ved=2ahUKEwj8z6KWtaP1AhWRGaYKHQOgDgUQpwV6BAgBEBc&biw=1396&bih=708&dpr=1"

google_news_custom_date = "https://www.google.com/search?q=力山工業+天下&client=safari&rls=en&biw=1440&bih=709&sxsrf=APq-WBum_3tpXoRWy8R-7OrqTzxyIR5hbQ%3A1643968325345&source=lnt&tbs=cdr%3A1%2Ccd_min%3A12%2F1%2F2019%2Ccd_max%3A1%2F31%2F2020&tbm="

# mops news and hq address
mops_news = 'http://mops.twse.com.tw/mops/web/ajax_t146sb05?TYPEK=all&step=1&firstin=1&off=1&queryName=co_id&co_id=' + ticker
# //TODO: https://mops.twse.com.tw/mops/web/t51sb10_q1?co_id=1514&step=1&firstin=true&id&key&TYPEK&Stp=4&go=false&keyWord&kewWord2&year=110&month1=0&begin_day=1&end_day=1

subsidiary = "https://www.cmoney.tw/finance/f00031.aspx?s="+ticker

revenue_mom = \
    "https://goodinfo.tw/StockInfo/ShowSaleMonChart.asp?STOCK_ID="+ticker

revenue_growth = \
    "https://www.moneydj.com/Z/ZC/ZC1/ZC17/ZC17.djhtm?a="+ticker

groups = "https://thaubing.gcaa.org.tw/group/name/G"+ticker

volume_profile = \
    "https://www.esunsec.com.tw/tw-stock/z/zc/zcw/zcwg/zcwg.djhtm?id=" \
    + ticker

tech_chart = "https://invest.cnyes.com/twstock/TWS/" + ticker + "/technical"
# support 2,4 but 5
# https://invest.cnyes.com/twstock/TWS/6278/technical#fixed

institution_holdings = "https://www.wantgoo.com/stock/" + ticker \
    + "/institutional-investors/trend"

holdings = "http://fubon-ebrokerdj.fbs.com.tw/z/zc/zcj/zcj_" \
    + ticker + ".djhtm"

hinet_technicals = "https://histock.tw/stock/"+ticker

cmoney_gossip = "https://www.cmoney.tw/follow/channel/stock-" + \
    ticker +"?chart=d&type=Personal"

share_outstanding = \
    "https://norway.twsthr.info/StockHolders.aspx?stock="+ticker

moneydj_profile = \
    "https://www.google.com/search?client=safari" + \
    "&rls=en&q=moneydj+"+quote("財經百科")+"+"+ticker+"&ie=UTF-8&oe=UTF-8"

pttstock_gossip = "https://www.google.com/search?q="+ticker+"+ptt+stock&client=safari&sxsrf=ALeKk02tz2-BrxlgznV37pUb3jBhfWDw8A:1623571437756&source=lnt&tbs=qdr:y&sa=X&ved=2ahUKEwi1i8L2kpTxAhWrzIsBHeciAhQQpwV6BAgBECQ&biw=1440&bih=709"

# 職缺, 公司全名
hr104_search = "https://www.google.com/search?q="+ticker+"+104&client=safari&rls=en&sxsrf=AOaemvJQ_3UVNBgOgvmw8LgOPjMQ6ukDmw%3A1637394407406&ei=56eYYZ__F-DR2roPua-g6A4&ved=0ahUKEwjfjorAuab0AhXgqFYBHbkXCO0Q4dUDCA0&uact=5&oq="+ticker+"+104&gs_lcp=Cgdnd3Mtd2l6EAM6CAgAEAcQChAeOgQIABAeOgYIABAIEB46CAgAEAgQBxAeOgIIJjoGCAAQBxAeOgUIABCRAjoFCAAQgAQ6CwguEIAEEMcBEK8BOggIABAHEAUQHkoECEEYAVD-BFiPKGC1KmgCcAB4AIABcYgBkwWSAQM3LjKYAQCgAQHAAQE&sclient=gws-wiz"

revenue_yoy = \
    "http://fubon-ebrokerdj.fbs.com.tw/z/zc/zch/zch_" + ticker + ".djhtm"

eps_table = "https://goodinfo.tw/tw/StockFinDetail.asp"+ \
    "?RPT_CAT=XX_M_QUAR&QRY_TIME=20214&STOCK_ID=" + ticker

google_gm_image = \
    "https://www.google.com/search?q=%22"+ \
    ticker + "*%22+%22" + quote("總經理") + "%22&client=safari&rls=en&sxsrf=AOaemvJXeaXjO0UbVWkuEdDa9LoCtKikwA:1640721761933&source=lnms&tbm=isch&sa=X&ved=2ahUKEwjl3q3upIf1AhU2yosBHTRcByMQ_AUoA3oECAEQBQ&biw=1440&bih=709&dpr=1"

google_chairman_image = \
    "https://www.google.com/search?q=%22"+ \
    ticker + "*%22+%22" + quote("董事長") + "%22&client=safari&rls=en&sxsrf=AOaemvJXeaXjO0UbVWkuEdDa9LoCtKikwA:1640721761933&source=lnms&tbm=isch&sa=X&ved=2ahUKEwjl3q3upIf1AhU2yosBHTRcByMQ_AUoA3oECAEQBQ&biw=1440&bih=709&dpr=1"

# is not update
trust = \
    "http://fubon-ebrokerdj.fbs.com.tw/z/zc/zc0/zc07/zc07_" + \
    ticker + ".djhtm"
# quick update
# https://www.yesfund.com.tw/w/wr/wr04.djhtm?a=ACII01
# https://fund.cnyes.com/detail/兆豐國際第一基金/A19001/shareholding
# components
# https://funds.citibank.com.tw/w/wr/wr04.djhtm?a=ACII01-A22004
# http://just2.entrust.com.tw/w/wr/wr04.djhtm?a=ACYT11-A03011
# http://just2.entrust.com.tw/w/wr/wr04.djhtm?a=ACII01-A22004
# one month late
# https://www.sitca.org.tw/ROC/Industry/IN2105.aspx?pid=IN2212_02

# where to get complete fund list? ISIN Code/mode 7:
# https://isin.twse.com.tw/isin/C_public.jsp?strMode=7
# or:
# https://isin.twse.com.tw/isin/class_main.jsp?owncode=&stockname=&isincode=&market=&issuertype=&industry_code=&others=1&Page=1&chklike=Y

# for each fund, basic data
# https://announce.fundclear.com.tw/MOPSonshoreFundWeb/main1.jsp?fundId=00965469

# enquery:
# https://isin.twse.com.tw/isin/class_i.jsp?kind=1

government_banks = "https://histock.tw/stock/broker.aspx?no="+ticker
# scrap gbank_activities.py

major_holders_bs = \
    "https://fubon-ebrokerdj.fbs.com.tw/z/zc/zck/zck_"+ticker+".djhtm"

management = ""

g_trend =""
# https://trends.google.com/trends/explore
# ?q=宏達電&geo=TW
# ?date=today%201-m&geo=TW&q=台電
# ?date=today%201-m&geo=TW&q=2498,2330
# ?date=now%207-d&geo=TW&q=2498,2330
# ?date=today%205-y&q=2498,2330
# ?date=now%204-H&q=2498,2330

if ( co_type == 4 or co_type == 5 ):
    tpex_info = "https://www.tpex.org.tw/web/regular_emerging/" \
    "corporateInfo/regular/regular_stock_detail.php?" \
    "l=zh-tw&stk_code=" + ticker
    webbrowser.open(tpex_info)
    time.sleep(1)

urls = [ \
    fundamental, \
    comparison, \
    revenue_mom, \
    revenue_growth, \
    groups, \
    subsidiary, \
    ticker_news, \
    volume_profile, \
    revenue_yoy, \
    eps_table, \
    google_news_past_year, \
    google_news_past_month, \
    google_news_past_week, \
    mops_news, \

    # technical
    tech_chart, \
    hinet_technicals, \

    # chips
    major_holders_bs, \
    share_outstanding, \
    institution_holdings, \
    holdings, \
    trust, \
    government_banks,

    # news, information, PR, gossips
    cmoney_gossip, \
    pttstock_gossip, \
    hr104_search, \
    moneydj_profile, \
    google_gm_image, \
    google_chairman_image, \
    management ]

i = 0
for url in urls:
    webbrowser.open(url)
    i += 1
    if ( i % 10 == 9 ):
        print('\a') # beep
        input("Press Enter to continue...")

sys.exit(0)
