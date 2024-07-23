
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

    # down
    # "https://sjmain.esunsec.com.tw", \

    # site: kgieworld.moneydj.com 個股基本資料
    # https://kgieworld.moneydj.com/z/con_CSA.htm?a=
    # "https://kgieworld.moneydj.com/z/con_CSA.htm?A=1227" # works
    "https://kgieworld.moneydj.com",            \

    # site: djinfo.cathaysec.com.tw 個股基本資料
    # "https://djinfo.cathaysec.com.tw/z/zc/zcx/ZCXNEWCATHAYSEC.djhtm?A="
    # https://www.cathaysec.com.tw/exclude_AL/market.aspx?btn=1-00-00&st=2330
    "https://djinfo.cathaysec.com.tw",          \

    # "http://tcfhcsec.moneydj.com/z/zc/zco/zco0/zco0.djhtm" # works
    "http://tcfhcsec.moneydj.com", \

    "http://5850web.moneydj.com", \
    # // TODO: to be verified
    # http://5850web.moneydj.com/z/zg/zgb/zgb0.djhtm?a=9600&b=9600

    "https://jdata.yuanta.com.tw", \

    # sites: masterlink.com.tw 個股基本資料
    # "https://www.masterlink.com.tw/stock-individualinteractive" # different?
    # "https://www.masterlink.com.tw"

    "https://newjust.masterlink.com.tw"
]

import requests

def test():
    print("# sites: " + str(len(list)))
    i = 0
    for url in list:
        try:
            # print(url)
            # url += "/z/zc/zca/zca_2885.djhtm"     # 基本資料
            # url += "/z/zc/zcg/zcg_1101.djhtm"     # 轉投資
            url += "/z/zc/zcn/zcn_2317.djhtm"       # magin balance
            page = requests.get(url)
            a = page.status_code
            # a = "404"
        except (requests.exceptions.HTTPError, requests.exceptions.ConnectionError):
            a = "C.Error" # print("Error")
        finally:
            print("{:02d} {} {}".format(i, a, url))
            i += 1

# test()
