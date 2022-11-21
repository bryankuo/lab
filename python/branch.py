#!/usr/bin/python3

# python3 branch.py [ticker]
# return 0: success

import sys, requests, time, re, os, webbrowser
import urllib.request
from datetime import timedelta, datetime
from dateutil.relativedelta import relativedelta
from bs4 import BeautifulSoup


# @see https://www.twse.com.tw/zh/brokerService/brokerServiceAudit
geo_group = [
    '台北市', '基隆市', '新北市', '桃園市', '桃園縣',                      \
    '新竹縣', '新竹市', '苗栗縣', '苗栗市', '台中市', '台中縣', '南投縣',  \
    '彰化市', '彰化縣', '雲林縣',                                          \
    '嘉義市', '嘉義縣',                                                    \
    '台南市', '台南縣', '台東市', '台東縣',                                \
    '高雄市', '高雄縣', '鳳山市', '屏東市', '屏東縣', '宜蘭縣', '宜蘭市',  \
    '花蓮縣', '花連市', '澎湖縣', '金門縣' ]

# 1. legendary branch
# 2. 個股買超第一名且買超佔比在20%以上的券商分點
# 3. assume smallcap attracts major attention, and is likey to locate
#    the branch where transactions occur
# 4. assume it it likely to find branch that major in the form of subsidary,
#    individual, investor, geographically related to active smallcap, within
#    14 days.
# 5. assume clustered broker with SEC alert implies certain kind of price act
# 6. presume a cluster of branch on the same side implies some kind of
# coordination
# 7. space/time/participants/volume/intetion
# 8. presume broker nearby manufacturing plant has something todo with corp
# 9. prusume local corp has more todo with local broker activities

# cut -f 4 -d ':' datafiles/broker_list.csv | cut -c1-3 | sort | uniq | wc -l
# export LC_CTYPE="zh_TW.UTF-8"; cut -f 4 -d ':' datafiles/broker_list.csv | cut -c1-3 | sort | uniq | wc -l
# ( cut -f 4 -d ':' datafiles/broker_list.csv | cut -c1-3 | sort | uniq ) | xxd
n_geo_group = [                    \
    210, 10, 112,   62,  3,        \
    15,  25,  15,    6, 65, 3, 10, \
    14,  28,  18,                  \
    20,  5,                        \
    48,  3,    4,    2,            \
    94,  1,    1,   12, 15, 9,  6, \
     5,  6,    2,    2 ]



ticker = sys.argv[1]

b = sum(n_geo_group)
# print( b )
# print( len(n_geo_group) )
sys.exit(0)

# trades = "b.txt" # download html
# with open(trades) as fp:
#    soup = BeautifulSoup(fp, 'html.parser')

url = "https://histock.tw/stock/branch.aspx?no="+ticker
# previous day ( @see transaction.py )
# https://histock.tw/stock/branch.aspx?no=2015&from=20220502&to=20220502
# day off
# https://histock.tw/stock/branch.aspx?no=2015&from=20220501&to=20220501
# day: 30, ... 365
# from, to
# https://histock.tw/stock/branch.aspx?no=5011&day=30
present = datetime.today()
# present = datetime.today() + relativedelta(months=-2)
tday = present.strftime("%Y") + present.strftime("%m") + present.strftime("%d")
dates = []; wkdys = []
MAX_RANGE_AVAILABLE = 9
for i in range( 1, MAX_RANGE_AVAILABLE ):
    before = present + relativedelta(days=-i)
    w = before.weekday()
    d = before.strftime("%Y") + before.strftime("%m") + before.strftime("%d")
    dates.append(d)
    wkdys.append(w)
# print("present: " + tday )
# print( "dates: " + str(dates)[1:-1] )
# print( "wkdys: " + str(wkdys)[1:-1] )

for i in range( 0, len(dates) ):
    time.sleep(5)
    print( "\ndates: " + str(dates[i]) + " is " + str(wkdys[i]) )
    url = "https://histock.tw/stock/branch.aspx?" + \
        "no="+ticker+"&from="+str(dates[i])+"&to="+str(dates[i])
    print(url)
    response = requests.get(url)
    soup = BeautifulSoup(response.text, 'html.parser')
    if ( soup is None ):
        continue
    # print(soup.prettify()) # logon required.
    divs = soup \
        .find_all("div", {"class": "row-stock txtC"})[0].text.strip()
    # dt = divs.split("\xa0\xa0\xa0\xa0")[1]
    # tokens = dt.split('/')
    # year = tokens[0]
    # month = tokens[1]
    # day = tokens[2]
    # stamp = year+month+day
    table = soup \
        .find_all("table", {"class": "tb-stock tbChip tbHide"})[0]
    if ( table is None ):
        print("table not found")
        continue
    rows = table.find_all('tr')
    if ( len(rows) <= 1 ):
        print(str(dates[i])+" is "+str(wkdys[i]))
        continue
    # backup for later usage
    path = 'datafiles/' + ticker
    isExist = os.path.exists(path)
    if not isExist:
      os.makedirs(path)
    file_name = 'datafiles/' + ticker + '/' + dates[i] + '.txt'
    with open(file_name, 'w') as the_file:
        the_file.write(table.prettify())
    the_file.close()
    ths = rows[0].find_all('th')
    for th in ths:
        print(th.text.strip(), end=':')
    print("\r")
    tds = rows[0].find_all('td')
    for i in range(1, len(rows)):
        tds = rows[i].find_all('td')
        col = 0
        for td in tds:
            if col in [0, 5] :
                # broker = td.find_all("a")[0].text.strip()
                # bs documentation @see https://tinyurl.com/satpd5rk
                url = td.find_all('a')[0].get('href').strip()
                mark1 = 'bno='; start = url.find(mark1)
                mark2 = '&'   ; end   = url.find(mark2)
                bno = url[start+len(mark1):end]
            text = td.text.strip()
            if col in [1, 2, 3, 6, 7, 8] and len(text) <= 0 :
                text = "0"
            if col in [0, 5] :
                text = bno + text
            print(text, end=":")
            col += 1
        print("\r")

sys.exit(0)

# by ticker symbol
# date is available, at most 14 days in range
# https://histock.tw/stock/branch.aspx?no=1514&from=20210713&to=20210713

# by broker
# https://fubon-ebrokerdj.fbs.com.tw/z/zg/zgb/zgb0.djhtm?a=1380&b=1380&c=B&e=2021-12-1&f=2021-12-3

# @see transaction.py parsing frame html source
# 買賣日報表查詢系統 https://bsr.twse.com.tw/bshtm/
# or download csv file


# enumerate 10 minor id of interest
# ref: https://cutt.ly/GFZrjFd

# https://www.moneydj.com/z/zg/zgb/zgb0.djhtm?a=9200&9268
# 9217
# 9875
# https://www.moneydj.com/z/zg/zgb/zgb0.djhtm?a=9600&b=9658
# a=9600&b=9697

# https://www.moneydj.com/z/zg/zgb/zgb0.djhtm?a=9100&b=0039003100380065
# https://fubon-ebrokerdj.fbs.com.tw/z/zg/zgb/zgb0.djhtm?a=8880&b=8880

# 主力進出比較圖
# https://fubon-ebrokerdj.fbs.com.tw/z/zc/zco/zco_2618.djhtm

# https://www.moneydj.com/z/zg/zgb/zgb0.djhtm?a=8450&b=0038003400350042
# https://fubon-ebrokerdj.fbs.com.tw/z/zg/zgb/zgb0.djhtm?a=8440&b=8440
# http://jsjustweb.jihsun.com.tw/z/zg/zgb/zgb0.djhtm?a=8440&b=8440
broker_group = [ \
    # http://jsjustweb.jihsun.com.tw/z/zg/zgb/zgb0.djhtm?a=9200&b=9268
    9200, 9268, \
    9217, 9875, 9658, \
    9697, 9100, 8880, 8450, 8440, \
]

huwei_gang = [ \
    # http://jsjustweb.jihsun.com.tw/z/zg/zgb/zgb0.djhtm?a=9800&b=003900380030006c
    '980I', \
    # http://jsjustweb.jihsun.com.tw/z/zg/zgb/zgb0.djhtm?a=9300&b=9377
    9377 \
]

ticker_group = [ 6182, 3008, 5011, 2441, 2618 ]

webbrowser.open(url)

'''
# given address, get latlng, then open browser
# address = 'Shivaji Nagar, Bangalore, KA 560001'
# address = '南投縣埔里鎮南昌街231號'
# address = 'No. 231, Nanchang St, Puli Township, Nantou County, 545, Taiwan'
# address = '320桃園市中壢區中和路'
# address = 'Zhonghe Rd, Zhongli District, Taoyuan City, 320'
address = 'No. 23, Jiucheng N Rd, Yilan City, Yilan County, 260, Taiwan'
# traditional chinese to english
url = 'https://nominatim.openstreetmap.org/search/' + \
    urllib.parse.quote(address) +'?format=json'
response = requests.get(url).json()
print(response[0]["lat"]+","+response[0]["lon"])
url = "https://www.google.com/search?client=safari&rls=en&q=" + \
    response[0]["lat"] + "," + response[0]["lon"] + "&ie=UTF-8&oe=UTF-8"
webbrowser.open(url)
'''

sys.exit(0)
