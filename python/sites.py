
list = [ # the most comprehensive site list in project
    "https://concords.moneydj.com",
    "https://trade.ftsi.com.tw", \
    "https://just2.entrust.com.tw", \
    "http://fubon-ebrokerdj.fbs.com.tw", \
    "https://stockchannelnew.sinotrade.com.tw", \
    "http://moneydj.emega.com.tw", \
    "https://stock.capital.com.tw", \
    "https://fund.hncb.com.tw", \
    "https://just.honsec.com.tw", \
    "https://sjmain.esunsec.com.tw", \

    # site: kgieworld.moneydj.com 個股基本資料
    # https://kgieworld.moneydj.com/z/con_CSA.htm?a=
    # "https://kgieworld.moneydj.com/z/con_CSA.htm?A=1227" # works
    "https://kgieworld.moneydj.com",            \

    # site: djinfo.cathaysec.com.tw 個股基本資料
    # "https://djinfo.cathaysec.com.tw/z/zc/zcx/ZCXNEWCATHAYSEC.djhtm?A="
    # https://www.cathaysec.com.tw/exclude_AL/market.aspx?btn=1-00-00&st=2330
    "https://djinfo.cathaysec.com.tw",          \

    # "http://tcfhcsec.moneydj.com/z/zc/zco/zco0/zco0.djhtm" # works
    "http://tcfhcsec.moneydj.com"

    # // TODO: to be verified
    # http://5850web.moneydj.com/z/zg/zgb/zgb0.djhtm?a=9600&b=9600

    # sites: www.yuanta.com.tw 個股基本資料
    # "www.yuanta.com.tw/eYuanta/Securities" # howto? different?
    # https://www.yuanta.com.tw/eYuanta/Securities/Node/Index?MainId=00412&C1=2018040405227002&C2=2018040406827696&ID=2018040406827696&Level=2

    # sites: masterlink.com.tw 個股基本資料
    # "https://www.masterlink.com.tw/stock-individualinteractive" # different?
    # "https://www.masterlink.com.tw"
]

import requests

def test():
    print("# sites: " + str(len(list)))
    for url in list:
        try:
            page = requests.get(url)
            a = page.status_code
        except (requests.exceptions.HTTPError, requests.exceptions.ConnectionError):
            a = "C.Error" # print("Error")
        finally:
            print("test " + str(a) + " " + url)
