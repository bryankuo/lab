#!/usr/bin/python3

# python3 web_search.py 2330
# return 0: success

import sys, requests, time, webbrowser
from urllib.parse   import quote
from urllib.request import urlopen
from datetime import datetime

ticker = sys.argv[1]
if ( 2 < len(sys.argv) ):
    co_name  = sys.argv[2]
    co_addr  = sys.argv[3]
    chairman = sys.argv[4]
    # // TODO: could be more than one "簡山傑、王石"
    gm       = sys.argv[5]
    co_type  = sys.argv[6]
    tid      = sys.argv[7]

find_company = "https://www.findcompany.com.tw/search/"+quote(chairman)
tw_company   = "https://www.twincn.com/Lq.aspx?q="+quote(chairman)
find_company1 = "https://www.findcompany.com.tw/search/"+quote(gm)
tw_company1   = "https://www.twincn.com/Lq.aspx?q="+quote(gm) # // TODO: scrap
print(tid)
# // TODO: link by tid https://costring.com/business/54852890/
# // TODO: link by tid https://www.twfile.com/83492902
# // TODO: link by tid https://opengovtw.com/drug
# // TODO: https://www.companys.com.tw/2052473/97257913

ticker_news = \
    "https://concords.moneydj.com/Z/ZC/ZCV/ZCV_" + ticker + ".djhtm"
# // TODO: news
# https://www.moneydj.com/kmdj/common/listnewarticles.aspx?svc=NW&a=TW.1218

fundamental = \
    "https://concords.moneydj.com/z/zc/zca/zca.djhtm?a=" + ticker

comparison = "https://mopsfin.twse.com.tw"
# // TODO: 重要財務比率(type 2,4,5)
# https://mops.twse.com.tw/mops/web/t05st22_q1?firstin=1&step=1&isnew=false&co_id=2753&year=110
# https://mops.twse.com.tw/mops/web/t05st22_q1?firstin=1&step=1&isnew=false&co_id=2753&year=111
# https://mops.twse.com.tw/mops/web/t05st22_q1?firstin=1&step=1&isnew=false&co_id=2753&year=111

# // TODO: 營益分析表
# https://mops.twse.com.tw/mops/web/t163sb08?firstin=1&step=1&isnew=false&co_id=2753&year=110
# https://mops.twse.com.tw/mops/web/t163sb08?firstin=1&step=1&isnew=false&co_id=2753&year=110
# https://mops.twse.com.tw/mops/web/t163sb08?firstin=1&step=1&isnew=false&co_id=2753&year=110

# // TODO: side by side comparison
#https://goodinfo.tw/tw/StockFinCompare.asp?STOCK0=台積電&STOCK1=聯電&STOCK2=世界&STOCK3=旺宏&STOCK4=&RPT_CAT=BS_M_YEAR&RPT_TYPE=NM&selYEAR=2021&selQUAR=4&btnQry=%C2%A0查%C2%A0%C2%A0%C2%A0詢%C2%A0
# https://mopsfin.twse.com.tw

# // TODO: business daily
# https://wealth.businessweekly.com.tw/m/HSearchResult.aspx?keyword=伊朗

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

google_search_competitors = "https://www.google.com/search?q=" + \
    ticker+"+"+quote(co_name)+"+"+quote("競爭對手")+ \
    "&client=safari&rls=en&sxsrf=AOaemvKTMQonLWeFKMTZV9EVT1oZ0KIqdw:"  + \
    "1639210457623&source=lnms&tbm=nws&sa=X&ved=2ahUKEwjXi6foptv0AhWC" + \
    "JaYKHcRACmYQ_AUoAXoECAEQAw&biw=1437&bih=703&dpr=1"

google_index_components = "https://www.google.com/search?q=" + \
    ticker+"+"+quote(co_name)+"+"+quote("成分股")+ \
    "&client=safari&rls=en&sxsrf=AOaemvKTMQonLWeFKMTZV9EVT1oZ0KIqdw:"  + \
    "1639210457623&source=lnms&tbm=nws&sa=X&ved=2ahUKEwjXi6foptv0AhWC" + \
    "JaYKHcRACmYQ_AUoAXoECAEQAw&biw=1437&bih=703&dpr=1"
'''
google_map = "https://www.google.com/search?q=" + \
    quote("google map")+"+"+quote(co_name)+"+"+ \
    "&client=safari&rls=en&sxsrf=AOaemvKTMQonLWeFKMTZV9EVT1oZ0KIqdw:"  + \
    "1639210457623&source=lnms&tbm=nws&sa=X&ved=2ahUKEwjXi6foptv0AhWC" + \
    "JaYKHcRACmYQ_AUoAXoECAEQAw&biw=1437&bih=703&dpr=1"
'''

google_map = "https://www.google.com/maps?client=safari&rls=en"        + \
    "&q=google+map+"+quote(co_addr)                                           + \
    "&oe=UTF-8&um=1&ie=UTF-8&sa=X"                                     + \
    "&ved=2ahUKEwiZzvT-4JP8AhVhUfUHHcALBtAQ_AUoAXoECAEQAw"

google_pledge = "https://www.google.com/search?q=" + \
    ticker+"+"+quote(co_name)+"+"+quote("董監質設異動公告")+ \
    "&client=safari&rls=en&sxsrf=AOaemvKTMQonLWeFKMTZV9EVT1oZ0KIqdw:"  + \
    "1639210457623&source=lnms&tbm=nws&sa=X&ved=2ahUKEwjXi6foptv0AhWC" + \
    "JaYKHcRACmYQ_AUoAXoECAEQAw&biw=1437&bih=703&dpr=1"

# mops news and hq address
mops_news = 'http://mops.twse.com.tw/mops/web/ajax_t146sb05?TYPEK=all&step=1&firstin=1&off=1&queryName=co_id&co_id=' + ticker
# //TODO: https://mops.twse.com.tw/mops/web/t51sb10_q1?co_id=1514&step=1&firstin=true&id&key&TYPEK&Stp=4&go=false&keyWord&kewWord2&year=110&month1=0&begin_day=1&end_day=1

subsidiary = "https://www.cmoney.tw/finance/f00031.aspx?s="+ticker
chinai     = "https://www.cnyes.com/archive/twstock/chinai/"+ticker+".htm"
overseasi  = "https://www.cnyes.com/archive/twstock/overseasi/"+ticker+".htm"

revenue_mom = \
    "https://goodinfo.tw/StockInfo/ShowSaleMonChart.asp?STOCK_ID="+ticker

# by ticker
monthly_revenue = \
    "https://fubon-ebrokerdj.fbs.com.tw/z/zc/zch/zch_"+ticker+".djhtm"
# by ticker
revenue_growth = \
    "https://www.moneydj.com/Z/ZC/ZC1/ZC17/ZC17.djhtm?a="+ticker

# summary
monthly_revenue_chg = \
    "https://goodinfo.tw/tw2/StockList.asp?RPT_TIME=&MARKET_CAT=熱門排行&INDUSTRY_CAT=單月營收月增率%28本月份%29%40%40單月營收月增減率%40%40本月份月增率"

groups = "https://thaubing.gcaa.org.tw/group/name/G"+ticker
# // TODO: 使用統編, grep from corp.ods csv
# corp_bi = "https://www.twincn.com/item.aspx?no=97170472"
corp_bi = "https://www.twincn.com/Lq.aspx?q="+ticker

volume_profile = \
    "https://www.esunsec.com.tw/tw-stock/z/zc/zcw/zcwg/zcwg.djhtm?id=" \
    + ticker

# tech_chart = "https://invest.cnyes.com/twstock/TWS/" + ticker + "/technical"
# support 2,4 but 5
# https://invest.cnyes.com/twstock/TWS/6278/technical#fixed

# institution_holdings = "https://www.wantgoo.com/stock/" + ticker \
#    + "/institutional-investors/trend"

# // TODO: support and resistance
# https://www.cnyes.com/archive/twstock/Pressure/2528.htm

holdings = "http://fubon-ebrokerdj.fbs.com.tw/z/zc/zcj/zcj_" \
    + ticker + ".djhtm"

hinet_technicals = "https://histock.tw/stock/"+ticker

cmoney_gossip = "https://www.cmoney.tw/follow/channel/stock-" + \
    ticker +"?chart=d&type=Personal"

moneydj_profile = \
    "https://www.google.com/search?client=safari" + \
    "&rls=en&q=moneydj+"+quote("財經百科")+"+"+ticker+"&ie=UTF-8&oe=UTF-8"

convertible_bond = \
    "https://www.google.com/search?client=safari" + \
    "&rls=en&q=moneydj+"+ticker+"+"+quote("可轉債")+"+"+"&ie=UTF-8&oe=UTF-8"

cnyes_cb = "https://www.cnyes.com/twstock/cb.aspx?code="+ticker
# // TODO: cb news 分類主題新聞-可轉債
# https://www.moneydj.com/kmdj/common/listnewarticles.aspx?svc=NW&a=X0500003

pttstock_gossip = "https://www.google.com/search?q="+ticker+"+ptt+stock&client=safari&sxsrf=ALeKk02tz2-BrxlgznV37pUb3jBhfWDw8A:1623571437756&source=lnt&tbs=qdr:y&sa=X&ved=2ahUKEwi1i8L2kpTxAhWrzIsBHeciAhQQpwV6BAgBECQ&biw=1440&bih=709"

# 職缺, 公司全名
hr104_search = "https://www.google.com/search?q="+quote("職缺")+quote(co_name)+"+104&client=safari&rls=en&sxsrf=AOaemvJQ_3UVNBgOgvmw8LgOPjMQ6ukDmw%3A1637394407406&ei=56eYYZ__F-DR2roPua-g6A4&ved=0ahUKEwjfjorAuab0AhXgqFYBHbkXCO0Q4dUDCA0&uact=5&oq="+ticker+"+104&gs_lcp=Cgdnd3Mtd2l6EAM6CAgAEAcQChAeOgQIABAeOgYIABAIEB46CAgAEAgQBxAeOgIIJjoGCAAQBxAeOgUIABCRAjoFCAAQgAQ6CwguEIAEEMcBEK8BOggIABAHEAUQHkoECEEYAVD-BFiPKGC1KmgCcAB4AIABcYgBkwWSAQM3LjKYAQCgAQHAAQE&sclient=gws-wiz"
# // TODO: tracking href text change from the link, ex. 2330, 6530
# https://www.104.com.tw/company/a5h92m0#info06
# https://www.104.com.tw/company/603xdhs#info06

revenue_yoy = \
    "http://fubon-ebrokerdj.fbs.com.tw/z/zc/zch/zch_" + ticker + ".djhtm"


# eps_table = "https://goodinfo.tw/tw/StockFinDetail.asp"+ \
#    "?RPT_CAT=XX_M_QUAR&QRY_TIME=20222&STOCK_ID=" + ticker
# https://goodinfo.tw/StockInfo/StockFinDetail.asp?RPT_CAT=XX_M_QUAR&QRY_TIME=20212&STOCK_ID=1227
year  = datetime.today().strftime('%Y')
month = datetime.today().strftime('%m')
quarter = (int(month) - 1) # // 3 + 1.
quarter = quarter - 2 # to get 2 quarter away
if ( quarter <= 0 ):
    quarter = 4
    year = str( int(year) - 1 )
quarter_s = "{:d}".format(quarter)
# datetime.today().strftime('%Y-%m-%d')
eps_table = "https://goodinfo.tw/StockInfo/StockFinDetail.asp?" + \
    "RPT_CAT=XX_M_QUAR" + \
    "&QRY_TIME=" + year + quarter_s + \
    "&STOCK_ID="+ticker
# RPT_CAT: [ XX_M_QUAR ... XX_QUAR ]
# site is under maintenance at 10 o'clock in the morning.

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

# warrant = "http://warrants.sfi.org.tw/Default.aspx"
# redirect to http://warrants.sfi.org.tw/Query.aspx
# // now selenium moving mouse and click, redirect, set ticker, and click
# // via warrant.py
# source 2: https://www.cmoney.tw/finance/warrantsbystock.aspx?stock=1102
warrant = "https://www.cmoney.tw/finance/warrantsbystock.aspx?stock="+ticker
# // TODO: has option, future, compare the table
# https://www.taifex.com.tw/cht/2/stockLists

histock_future = "https://histock.tw/stock/future.aspx?no="+ticker

gdr = "https://www.google.com/search?q="+quote(co_name)+"+gdr&client=safari&rls=en&ei=a_0fY9-sN8n0-QagpqSABg&ved=0ahUKEwifjp-F7pD6AhVJet4KHSATCWAQ4dUDCA0&uact=5&oq=力晶+gdr&gs_lcp=Cgdnd3Mtd2l6EAMyBQgAEKIEMgUIABCiBDIHCAAQHhCiBDIHCAAQHhCiBDIHCAAQHhCiBDoKCAAQHhCiBBCwAzoICAAQogQQsAM6BQghEKABOgQIABAeOgYIABAeEA86CAgAEB4QDxAIOgUIABCABDoOCC4QsQMQxwEQ0QMQ1AI6CAgAELEDEIMBOgsILhCABBDHARCvAToRCC4QgAQQsQMQgwEQxwEQ0QM6CAgAEIAEELEDOgsILhCABBCxAxDUAjoOCC4QgAQQsQMQgwEQ1AI6CwgAEIAEELEDEIMBOggILhCABBCxAzoLCC4QgAQQsQMQgwE6BQgAELEDOhEILhCABBCxAxCDARDHARCvAToUCC4QgAQQsQMQgwEQxwEQ0QMQ1AI6CwguELEDEIMBENQCOgUILhCABDoOCC4QgAQQsQMQxwEQrwE6CgguEMcBENEDEEM6EAguELEDEIMBEMcBENEDEEM6BAgAEEM6CgguEMcBEK8BEEM6CAguEIAEENQCOggIABAeEAQQCjoGCAAQHhAESgQIQRgBSgQIRhgAUOUHWOJ9YOR_aBFwAHgBgAFiiAHhD5IBAjM1mAEAoAEBsAEAyAEDwAEB&sclient=gws-wiz"

dr  = "https://www.cnyes.com/archive/twstock/dr/"+ticker+".htm"

g_trend =""
# https://trends.google.com/trends/explore
# ?q=宏達電&geo=TW
# ?date=today%201-m&geo=TW&q=台電
# ?date=today%201-m&geo=TW&q=2498,2330
# ?date=now%207-d&geo=TW&q=2498,2330
# ?date=today%205-y&q=2498,2330
# ?date=now%204-H&q=2498,2330
# 全球過去1個月
# https://trends.google.com/trends/explore?date=today%201-m
if ( co_type == 4 or co_type == 5 ):
    tpex_info = "https://www.tpex.org.tw/web/regular_emerging/" \
    "corporateInfo/regular/regular_stock_detail.php?" \
    "l=zh-tw&stk_code=" + ticker
    webbrowser.open(tpex_info)
    time.sleep(1)

urls = [ \
    find_company, \
    tw_company, \
    find_company1, \
    tw_company1, \
    fundamental, \
    # comparison, \
    revenue_mom, \
    monthly_revenue, \
    revenue_growth, \
    groups, \
    subsidiary, \
    chinai, \
    overseasi, \
    ticker_news, \
    # volume_profile, \
    revenue_yoy, \
    eps_table, \
    google_news_past_year, \
    google_news_past_month, \
    google_news_past_week, \
    mops_news, \

    # technical
    # tech_chart, \
    hinet_technicals, \

    # chips
    # institution_holdings, \
    holdings, \
    # trust, \
    # government_banks, \
    warrant, \
    histock_future, \
    gdr, \
    dr, \
    convertible_bond, \
    cnyes_cb, \

    # news, information, PR, gossips
    cmoney_gossip, \
    pttstock_gossip, \
    hr104_search, \
    moneydj_profile, \
    google_gm_image, \
    google_chairman_image, \
    google_search_competitors, \
    google_index_components, \
    google_map, \
    google_pledge ]

i = 0
for url in urls:
    webbrowser.open(url)
    i += 1
    if ( i % 10 == 3 ):
        print('\a') # beep
        input("Press Enter to continue...")

sys.exit(0)
# (成分) 調整名單

# 產銷組合

# 全文

# 發言人、代理發言人、重要營運主管(如:執行長、營運長、行銷長及策略長等)、財務主管、會計主管、公司治理主管、資訊安全長、研發主管、內部稽核主管或訴訟及非訟代理人
# 辭任 辭職 離職 退休 新任
# 處分
# 董監質設異動公告
# 可轉債 認股權證 現金增資
# 本次交易 庫藏股
# 董監改選

# // TODO: 跳出總公司/工廠 google map
# https://maps.google.com/maps?client=safari&rls=en&sxsrf=AOaemvKTMQonLWeFKMTZV9EVT1oZ0KIqdw:1639210457623&biw=1437&bih=703&dpr=1&q=google+map+鈺太科技股份有限公司&um=1&ie=UTF-8&sa=X&ved=2ahUKEwjMmNzW8YT8AhWznFYBHe09AhEQ0pQJegQIBhAE

# https://web.pcc.gov.tw/prkms/tender/common/agent/indexTenderAgent
# selenium 得標廠商統編

# 得標
# 最高行政法院

# 行事曆
# https://djinfo.cathaysec.com.tw/z/zc/zci/zci.djhtm?A=3105
# https://www.cmoney.tw/finance/3105/f00028
# https://www.esunsec.com.tw/tw-stock/z/zc/zcx/zcxnewEsunsec.djhtm?id=3105
# https://histock.tw/stock/3105

# borrow/菲神/標借 site:twse.com.tw / 標借證券明細表
# count the # of borrowing, compare with that of yesterday
# type 2
# https://www.twse.com.tw/rwd/zh/borrow/BFIB8U?response=html # 上市
# type 4 ( input is required )
# https://www.tpex.org.tw/web/stock/margin_trading/lend/lend_result.php?sd=113/04/01&ed=113/04/01&stkno=&s=0,asc,1&o=htm

