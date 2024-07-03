#!/usr/bin/python3

# python3 get_listed.py [type]
# \param in type
# \param out txt file
# \param out html file

# input:
# 0 n/a
# 1: not listed
# https://isin.twse.com.tw/isin/C_public.jsp?strMode=2
# 3: CB
# 本國上市證券國際證券辨識號碼一覽表
# https://isin.twse.com.tw/isin/C_public.jsp?strMode=4
# 本國上櫃證券國際證券辨識號碼一覽表
# https://isin.twse.com.tw/isin/C_public.jsp?strMode=5
# 本國興櫃證券國際證券辨識號碼一覽表
# // TODO: 7 is trust
# not available for 'all'

# categorize by TWSE
# https://isin.twse.com.tw/isin/class_main.jsp?owncode=&stockname=&isincode=&market=&issuetype=&industry_code=01&Page=1&chklike=Y

# categorize by moneydj
# https://www.moneydj.com/Z/ZH/ZHA/ZHA.djhtm
# sites.py applies
# https://stock.capital.com.tw/Z/ZH/ZHA/ZHA.djhtm
# @see requests_url.py

# return : num of line

import sys, requests, time, re, os
import urllib.request
from datetime import timedelta,datetime
from bs4 import BeautifulSoup
from pprint import pprint

mode = sys.argv[1]
if mode not in ['2', '4', '5']:
    print('invlid option')
    sys.exit(-1)

DIR0="./datafiles"
DIR1="./datafiles/taiex"

fname = "type" + mode + "." + \
    datetime.today().strftime('%Y%m%d') + ".html"
htm_path = os.path.join(DIR1, fname)

url = 'https://isin.twse.com.tw/isin/C_public.jsp?strMode=' + mode
# print("from " + url)
response = requests.get(url)
response.encoding = 'big5'
soup = BeautifulSoup(response.text, 'html.parser')
# print('done.')

# print("writing html...")
outfile2 = open(htm_path, "w")
outfile2.write(soup.prettify())
outfile2.close()
# print("done.")

rows = soup.findAll('table')[1].find_all('tr')
if ( rows is None ):
    print("not found")
    sys.exit(-2)

sectors = []

# print("writing txt...")
count = 0
lname = 'listed_' + mode + '.txt'
lst_path = os.path.join(DIR0, lname)
the_file = open(lst_path, 'w')
for tr in rows:
    symbol = tr.find_all('td')[0].text.split()[0].strip()
    # name = tr.find_all('td')[0].text.split()[1]
    # array = tr.find_all('td')[0].text.strip().split(' ')[0]
        # .split(' ')[0]
        # .split(' ')
        # .renderContents()
        # .decode("Big5")
        #.split(' ')
    # print(name)
    # symbol = tr.find_all('td')[0].text.split(' ')[0]
    # name = array[1]
    if ( len(symbol) == 4 and \
        symbol.isdigit() and \
        1000 < int(symbol) ):
            the_file.write(symbol+'\n')
            # // FIXME: append list then write once
            s = tr.find_all('td')[4].text.strip()
            if s not in sectors and 0 < len(s):
                sectors.append(s)
            count += 1
the_file.close()
# print("done.")

n_rows = str(count)
print(n_rows)
# pprint("{} {}".format(len(sectors), sectors))
sys.exit(0)
'''
python$ python3 get_listed.py 2
1021
("33 ['水泥工業', '食品工業', '塑膠工業', '建材營造業', '汽車工業', '其他業', '紡織纖維', '運動休閒', "
 "'電子零組件業', '電機機械', '電器電纜', '生技醫療業', '化學工業', '玻璃陶瓷', '造紙工業', '鋼鐵工業', '居家生活', "
 "'橡膠工業', '航運業', '電腦及週邊設備業', '半導體業', '其他電子業', '通信網路業', '光電業', '電子通路業', "
 "'資訊服務業', '貿易百貨業', '油電燃氣業', '觀光餐旅', '金融保險業', '數位雲端', '綠能環保', '']")
python$ python3 get_listed.py 4
825
("28 ['農業科技業', '觀光餐旅', '食品工業', '電子零組件業', '生技醫療業', '電腦及週邊設備業', '電機機械', '其他業', "
 "'運動休閒', '化學工業', '其他電子業', '鋼鐵工業', '電器電纜', '建材營造業', '數位雲端', '航運業', '居家生活', "
 "'文化創意業', '光電業', '綠能環保', '通信網路業', '半導體業', '資訊服務業', '電子通路業', '塑膠工業', '紡織纖維', "
 "'金融保險業', '油電燃氣業']")
python$ python3 get_listed.py 5
325
("27 ['食品工業', '觀光餐旅', '生技醫療業', '綠能環保', '鋼鐵工業', '電子零組件業', '電機機械', '電器電纜', "
 "'其他電子業', '航運業', '居家生活', '電腦及週邊設備業', '半導體業', '資訊服務業', '光電業', '電子通路業', '其他業', "
 "'紡織纖維', '運動休閒', '化學工業', '建材營造業', '金融保險業', '通信網路業', '文化創意業', '數位雲端', '油電燃氣業', "
 "'農業科技業']")
 '''
