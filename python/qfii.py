#!/usr/bin/env python3

# python3 qfii.py [0|1], 0: net (default), 1: file
# highlight both qfii and fund go in the same direction
# red: same direction, green: opposite direction
# return 0: success

import sys, requests, time, os, numpy
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.common.exceptions import SessionNotCreatedException
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import Select
from timeit import default_timer as timer
from datetime import timedelta,datetime
from pprint import pprint

# source:
# official, detailed, history, csv
# qfii
# https://www.twse.com.tw/zh/page/trading/fund/TWT38U.html
# fund
# https://www.twse.com.tw/zh/page/trading/fund/TWT44U.html
#
# 50
# https://histock.tw/stock/three.aspx?s=a
# https://www.wantgoo.com/stock/institutional-investors/foreign/net-buy-sell-rank
# 30, 2 markets, history
# https://www.cnyes.com/twstock/a_QFII9.aspx
# 200
# https://stock.wearn.com/a50.asp
#
# government sponsored banks
# https://histock.tw/stock/broker8.aspx?d=2023-01-11

def say(msg = "Finish", voice = "Victoria"):
    os.system(f'say -v {voice} {msg}')

from datetime import date
if ( len(sys.argv) < 2 ):
    is_from_net = True
    fname = '外資投信同步買賣超.' + datetime.today().strftime('%m%d') + '.txt'
elif ( 2 <= len(sys.argv) and sys.argv[1] == "0" ):
    is_from_net = True
    fname = sys.argv[2]
else:
    is_from_net = False
    fname = sys.argv[2]
    # // FIXME: net,file,output combination

try:
    full_tab = []; list1b = []; list1s = []; list2b = []; list2s = []
    def parse_1(soup1):
        tab1 = soup1.find_all("table", {"id": "report-table"})[0]
        len1 = len(soup1.find_all("table", {"id": "report-table"})[0]   \
                .find_all("tbody")[0]                                   \
                .find_all("tr")[0]                                      \
                .find_all("td"))
        num1 = len(soup1.find_all("table", {"id": "report-table"})[0]   \
                .find_all("tbody")[0]                                   \
                .find_all("tr"))

        # with open('list1b.txt', 'wt') as out1, \
        # open('list1s.txt', 'wt') as out2:
        for i in range(0, num1):
            tkr1  = tab1                                            \
                    .find_all("tbody")[0]                           \
                    .find_all("tr")[i]                              \
                    .find_all("td")[1].text.strip().replace(',', '')
            name1 = tab1                                            \
                    .find_all("tbody")[0]                           \
                    .find_all("tr")[i]                              \
                    .find_all("td")[2].text.strip().replace(',', '')
            vol1  = tab1                                            \
                    .find_all("tbody")[0]                           \
                    .find_all("tr")[i]                              \
                    .find_all("td")[len1-1].text.strip()            \
                        .replace(',', '') # [:-3] # 1000 shares
            # if ( 0 < len(vol1) ):
            if ( vol1.lstrip("-").isdigit() ):
                if ( 0 < int(vol1) ):
                    # out1.write(tkr1+":"+name1+":"+vol1+"\n")
                    item = []
                    item.append(tkr1); item.append(name1);
                    item.append(int(vol1))
                    list1b.append(item)
                if ( int(vol1) < 0 ):
                    # out2.write(tkr1+":"+name1+":"+vol1+"\n")
                    item = []
                    item.append(tkr1); item.append(name1);
                    item.append(int(vol1))
                    list1s.append(item)
            # out1.close()
            # out2.close()
        return num1

    def parse_2(soup2):
        tab2 = soup2.find_all("table", {"id": "report-table"})[0]
        len2 = len(soup2.find_all("table", {"id": "report-table"})[0]   \
                .find_all("tbody")[0]                                   \
                .find_all("tr")[0]                                      \
                .find_all("td"))
        num2 = len(soup2.find_all("table", {"id": "report-table"})[0]   \
                .find_all("tbody")[0]                                   \
                .find_all("tr"))

        with open('list2.txt', 'wt') as out0, \
            open('list2b.txt', 'wt') as out1, \
            open('list2s.txt', 'wt') as out2:

            for i in range(0, num2):
                tkr2  = tab2                                            \
                        .find_all("tbody")[0]                           \
                        .find_all("tr")[i]                              \
                        .find_all("td")[1].text.strip().replace(',', '')
                name2 = tab2                                            \
                        .find_all("tbody")[0]                           \
                        .find_all("tr")[i]                              \
                        .find_all("td")[2].text.strip().replace(',', '')
                vol2  = tab2                                            \
                        .find_all("tbody")[0]                           \
                        .find_all("tr")[i]                              \
                        .find_all("td")[len2-1].text.strip()            \
                            .replace(',', '') # [:-3] # 1000 shares

                if ( vol2.lstrip("-").isdigit() ):
                    print(vol2)
                    if ( 0 < int(vol2) ):
                        item = []
                        item.append(tkr2); item.append(name2);
                        item.append(int(vol2))
                        list2b.append(item)
                    elif ( int(vol2) <= 0 ):
                        item = []
                        item.append(tkr2); item.append(name2);
                        item.append(int(vol2))
                        list2s.append(item)

                out0.write(tkr2+":"+name2+":"+vol2+"\n")
            for i in range(0, len(list2b)):
                out1.write(list2b[i][0]+":"+ \
                    list2b[i][1]+":"+str(list2b[i][2])+"\n")
            for i in range(0, len(list2s)):
                out2.write(list2s[i][0]+":"+ \
                    list2s[i][1]+":"+str(list2s[i][2])+"\n")
        out0.close(); out1.close(); out2.close()
        return num2

    def merge12(list1b, list1s, list2b, list2s):
        # full_tab = list1b.copy()
        # transpose ( @see shorturl.at/ntuy8 ) then union
        # extend # of row, then looping

        start = timer()
        print("transpose...")
        t_list1b = numpy.transpose(list1b)[0]
        t_list1s = numpy.transpose(list1s)[0]
        t_list2b = numpy.transpose(list2b)[0]
        t_list2s = numpy.transpose(list2s)[0]
        end = timer()
        print(timedelta(seconds=end-start))

        start = timer()
        print("union...")
        # union without repition @see shorturl.at/kSVW8
        u_f = list( set(t_list1b) | set(t_list1s) | set(t_list2b) | set(t_list2s) )
        end = timer()
        print(timedelta(seconds=end-start))

        start = timer()
        print("strip None...")
        t_f = [i for i in u_f if i is not None]
        # with open("t_f.txt", 'wt') as ofile:
        #    ofile.write(pprint(t_f))
        #    ofile.close()
        # to be validated
        end = timer()
        print(timedelta(seconds=end-start))

        start = timer()
        print("transpose back...")
        tab1 = numpy.transpose(t_f)
        end = timer()
        print(timedelta(seconds=end-start))

        start = timer()
        print("to list...")
        for i in range(0, len(tab1)):
            lst = []; lst.append(tab1[i])
            full_tab.append(lst)
        end = timer()
        print(timedelta(seconds=end-start))

        # assert all ticker in place

        start = timer()
        print("append name column...")
        # add 'name' column
        for i in range(0, len(full_tab)):
            full_tab[i].append("") # '' "" None
        end = timer()
        print(timedelta(seconds=end-start))

        start = timer()
        print("add 'qfii buy' column with default value...")
        for i in range(0, len(full_tab)):
            full_tab[i].append(0)
        # update qfii buy numbers
        for i in range(0, len(list1b)):
            for j in range(0, len(full_tab)):
                if list1b[i][0] in full_tab[j]: #.index()
                    full_tab[j][2] = list1b[i][2]
                    # update name as well
                    if len(full_tab[j][1]) <= 0 :
                        full_tab[j][1] = list1b[i][1]
        end = timer()
        print(timedelta(seconds=end-start))


        start = timer()
        print("add 'qfii sell' column with default value...")
        for i in range(0, len(full_tab)):
            full_tab[i].append(0)
        # update qfii sell numbers
        for i in range(0, len(list1s)):
            for j in range(0, len(full_tab)):
                if list1s[i][0] in full_tab[j]:
                    full_tab[j][3] = list1s[i][2]
                    # update name as well
                    if len(full_tab[j][1]) <= 0 :
                        full_tab[j][1] = list1s[i][1]
        end = timer()
        print(timedelta(seconds=end-start))

        start = timer()
        print("add 'fund buy' column with default value...")
        for i in range(0, len(full_tab)):
            full_tab[i].append(0)
        # update fund buy numbers
        for i in range(0, len(list2b)):
            for j in range(0, len(full_tab)):
                if list1s[i][0] in full_tab[j]:
                    full_tab[j][4] = list2b[i][2]
                    # update name as well
                    if len(full_tab[j][1]) <= 0 :
                        full_tab[j][1] = list2b[i][1]
        end = timer()
        print(timedelta(seconds=end-start))

        # pprint(full_tab)

        start = timer()
        print("add 'fund sell' column with default value...")
        for i in range(0, len(full_tab)):
            full_tab[i].append(0)
        # update fund sell numbers
        for i in range(0, len(list2s)):
            for j in range(0, len(full_tab)):
                if list1s[i][0] in full_tab[j]:
                    full_tab[j][5] = list2s[i][2]
                    # update name as well
                    if len(full_tab[j][1]) <= 0 :
                        full_tab[j][1] = list2s[i][1]
        end = timer()
        print(timedelta(seconds=end-start))

        # // FIXME: highlight here
        start = timer()
        print("hightlight 'b2','s2'...")
        for i in range(0, len(full_tab)):
            full_tab[i].append(0)
            full_tab[i].append(0)
        # highlight those qfii and fund go in the same direction
        for i in range(0, len(full_tab)):
            if ( 0 < int(full_tab[i][2]) ) and ( 0 < int(full_tab[i][4]) ):
                full_tab[i][6] = 1
            else:
                full_tab[i][6] = 0
        for i in range(0, len(full_tab)):
            if ( int(full_tab[i][3]) < 0 ) and ( int(full_tab[i][5]) < 0 ):
                full_tab[i][7] = 1
            else:
                full_tab[i][7] = 0
        end = timer()
        print(timedelta(seconds=end-start))

        return full_tab

    start = timer()
    print("fetching...")
    if ( is_from_net ):
        print("from internet...")
        browser = webdriver.Safari( \
            executable_path = '/usr/bin/safaridriver')

        qfii = "https://www.twse.com.tw/zh/page/trading/fund/TWT38U.html"
        fund = "https://www.twse.com.tw/zh/page/trading/fund/TWT44U.html"

        browser.get(qfii)
        # https://stackoverflow.com/a/72901664
        Select(WebDriverWait(browser, 10)                               \
            .until(EC.element_to_be_clickable(                          \
                (By.XPATH,"//select[@name='report-table_length']"))))   \
            .select_by_value('-1')
        page1 = browser.page_source
        soup1 = BeautifulSoup(page1, 'html.parser')
        with open("qfii.html", "w") as outfile1:
            outfile1.write(soup1.prettify())
            outfile1.close()

        browser.get(fund)
        time.sleep(3)
        Select(WebDriverWait(browser, 10)                               \
            .until(EC.element_to_be_clickable(                          \
                (By.XPATH,"//select[@name='report-table_length']"))))   \
            .select_by_value('-1')
        page2 = browser.page_source
        soup2 = BeautifulSoup(page2, 'html.parser')
        with open("fund.html", "w") as outfile2:
            outfile2.write(soup2.prettify())
            outfile2.close()
        browser.quit()
    else:
        print("from file...")
        with open("qfii.html") as q:
            soup1 = BeautifulSoup(q, 'html.parser')
        with open("fund.html") as r:
            soup2 = BeautifulSoup(r, 'html.parser')
    end = timer()
    print(timedelta(seconds=end-start))

    start = timer()
    print("qfii processing...")
    n1 = parse_1(soup1)
    end = timer()
    print(timedelta(seconds=end-start))

    print("fund processing...")
    start = timer()
    n2 = parse_2(soup2)
    end = timer()
    print(timedelta(seconds=end-start))

    # print("merging and output to file...")
    # start = timer()
    tab = merge12(list1b, list1s, list2b, list2s)
    with open(fname, 'wt') as ofile:
        # ofile.write(pprint(tab))
        n_col = len(tab[0])
        for i in range(0, len(tab)):
            tkr  = tab[i][0]
            name = tab[i][1]
            qb   = tab[i][2]
            qs   = tab[i][3]
            fb   = tab[i][4]
            fs   = tab[i][5]
            b2   = tab[i][6]
            s2   = tab[i][7]
            ofile.write(tkr+":"+name+":"+ \
                    str(qb)+":"+str(qs)+":"+str(fb)+":"+str(fs)+":"+ \
                    str(b2)+":"+str(s2)+"\n")
        ofile.close()
    # end = timer()
    # print(timedelta(seconds=end-start))
    msg = "finish buying "+str(n1)+", and selling "+str(n2)+"."
    say(msg)

except (SessionNotCreatedException):
    print('turn on safari remote option.')

finally:
    print('finally')

print('done.')

sys.exit(0)
