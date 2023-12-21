#!/usr/bin/env python3

#
# python3 qfii.py [outf] [0|1] [yyyy] [mm] [dd]
#  0: net (default), 1: file
#  mm: month, no leading zero
#  dd: day, no leading zero
# highlight both qfii and fund go in the same direction
# red: same direction, green: opposite direction
# return 0: success

import sys, requests, time, os, numpy, csv
from bs4 import BeautifulSoup
from selenium import webdriver

# @see https://stackoverflow.com/a/76550727
from selenium.webdriver.safari.service import Service

# // TODO: pip install webdriver-manager==
# pip install webdriver-manager==3.9.1
# 4.0.1 NG
# 3.9.1 NG
# from webdriver_manager.safari import SafariDriverManager

from selenium.common.exceptions import SessionNotCreatedException
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import Select
from timeit import default_timer as timer
from datetime import timedelta, datetime
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
#
# margin
# https://concords.moneydj.com/z/zc/zcn/zcn_1101.djhtm
# https://fubon-ebrokerdj.fbs.com.tw/z/zc/zcn/zcn_2881.djhtm

def say(msg = "Finish", voice = "Victoria"):
    os.system(f'say -v {voice} {msg}')

print( 'qfii.py+ ' + str(len(sys.argv)) )

DIR0="./datafiles/taiex/qfbs"
NAME037="外投同買賣及異常"
NAME037_1="外投同買列表"
NAME037_2="外投同賣列表"
NAME037_3="外資賣漲停"
NAME037_4="外資買跌停"

theday = datetime.today().strftime('%Y%m%d')
is_from_net = False

if ( len(sys.argv) < 2 ):
    is_from_net = True
    ofname = DIR0 + "/" + NAME037 + '.' + theday + '.txt'
elif ( 3 == len(sys.argv) ):
    if ( sys.argv[2] == "0" ):
        is_from_net = True
        ofname = sys.argv[1]
    elif ( sys.argv[2] == "1" ):
        is_from_net = False
        ofname = sys.argv[1]
        # print(ofname)
    else:
        print("usage:")
elif ( 4 == len(sys.argv) ):
    if ( sys.argv[2] == "0" ):
        is_from_net = True
    elif ( sys.argv[2] == "1" ):
        is_from_net = False
    else:
        is_from_net = False
    yyyy   = sys.argv[3][0:4]
    mm     = sys.argv[3][4:6]
    dd     = sys.argv[3][6:8]
    theday = sys.argv[3]
    ofname = sys.argv[1]
elif ( 8 == len(sys.argv) ):
    if ( sys.argv[2] == "0" ):
        is_from_net = True
    elif ( sys.argv[2] == "1" ):
        is_from_net = False
    else:
        is_from_net = False
    yyyy   = sys.argv[3][0:4]
    mm     = sys.argv[3][4:6]
    dd     = sys.argv[3][6:8]
    theday = sys.argv[3]
    ofname = sys.argv[1]
    deal   = sys.argv[5]
    change = sys.argv[6]
    rise   = sys.argv[7]
    volume = sys.argv[7]
else:
    is_from_net = False
    ofname = sys.argv[1]
    # // TODO: net, date,file,output combination

# yyyy = datetime.today().strftime('%Y')
# mm   = datetime.today().strftime('%m')
# dd   = datetime.today().strftime('%d')

both_buy = NAME037_1 + "."  + yyyy + mm + dd + '.txt'
path1 = os.path.join(DIR0, both_buy)

both_sell = NAME037_2 + "."  + yyyy + mm + dd + '.txt'
path2 = os.path.join(DIR0, both_sell)

qslu = NAME037_3 + "."  + yyyy + mm + dd + '.txt'
path3 = os.path.join(DIR0, qslu)

qbld = NAME037_4 + "."  + yyyy + mm + dd + '.txt'
path4 = os.path.join(DIR0, qbld)

try:
    full_tab = []; list1b = []; list1s = []; list2b = []; list2s = []
    limit_ulist = []; limit_dlist = [];

    def fetch():
        url_qfii = "https://www.twse.com.tw/zh/page/trading/fund/TWT38U.html"
        url_fund = "https://www.twse.com.tw/zh/page/trading/fund/TWT44U.html"
        q_fname = "qfii." + theday + '.html'
        q_path = os.path.join(DIR0, q_fname)
        f_fname = "fund." + theday + '.html'
        f_path = os.path.join(DIR0, f_fname)
        if ( is_from_net ):
            # pip3 install selenium==3.141.0
            browser = webdriver.Safari( \
                executable_path = '/usr/bin/safaridriver')

            # pip3 uninstall selenium; pip3 install -U selenium
            # browser = webdriver.Safari()
            # browser = webdriver.Safari(quiet = True)

            # pip install selenium==
            # pip3 uninstall selenium; pip3 install selenium==3.141.0
            # pip3 install webdriver-manager==
            # 3.9.1 NG
            # pip3 install webdriver-manager==3.9.0 NG
            # pip3 install -U webdriver-manager
            # 4.0.1 NG
            # browser = webdriver.Safari(executable_path=SafariDriverManager().install())

            browser.implicitly_wait(10)
            browser.maximize_window()
            browser.get(url_qfii)
            # time.sleep(1) # // TODO: test if removed
            Select(WebDriverWait(browser, 3)                                \
                .until(EC.element_to_be_clickable(                          \
                    (By.XPATH,"//select[@name='yy']"))))   \
                .select_by_value(yyyy)
            Select(WebDriverWait(browser, 3)                                \
                .until(EC.element_to_be_clickable(                          \
                    (By.XPATH,"//select[@name='mm']"))))   \
                .select_by_value(mm.lstrip("0"))
            Select(WebDriverWait(browser, 3)                                \
                .until(EC.element_to_be_clickable(                          \
                    (By.XPATH,"//select[@name='dd']"))))   \
                .select_by_value(dd.lstrip("0"))

            # wait until rendered @see https://l8.nu/rTdU
            search =  WebDriverWait(browser, 3)                                \
                .until(EC.element_to_be_clickable(                          \
                    (By.XPATH, '//button[text()="查詢"]')))
            search.click()
            per_page = Select(WebDriverWait(browser, 3)                     \
                .until(EC.element_to_be_clickable(                          \
                    (By.XPATH,"//div[@class='per-page']//select"))))
            # @see https://stackoverflow.com/a/29059348
            per_page.select_by_value("-1")

            page1 = browser.page_source
            soup1 = BeautifulSoup(page1, 'html.parser')
            with open(q_path, "w") as outfile1:
                outfile1.write(soup1.prettify())
            outfile1.close()
            print("write to: " + q_path)

            browser.get(url_fund)
            # time.sleep(1)
            Select(WebDriverWait(browser, 1)                                \
                .until(EC.element_to_be_clickable(                          \
                    (By.XPATH,"//select[@name='yy']"))))   \
                .select_by_value(yyyy)
            Select(WebDriverWait(browser, 1)                                \
                .until(EC.element_to_be_clickable(                          \
                    (By.XPATH,"//select[@name='mm']"))))   \
                .select_by_value(mm.lstrip("0"))
            Select(WebDriverWait(browser, 1)                                \
                .until(EC.element_to_be_clickable(                          \
                    (By.XPATH,"//select[@name='dd']"))))   \
                .select_by_value(dd.lstrip("0"))
            # browser.find_element_by_link_text("查詢").click()
            search =  WebDriverWait(browser, 3)                             \
                .until(EC.element_to_be_clickable(                          \
                    (By.XPATH, '//button[text()="查詢"]')))
            search.click()

            per_page = Select(WebDriverWait(browser, 3)                     \
                .until(EC.element_to_be_clickable(                          \
                    (By.XPATH,"//div[@class='per-page']//select"))))
            # @see https://stackoverflow.com/a/29059348
            per_page.select_by_value("-1")

            page2 = browser.page_source
            soup2 = BeautifulSoup(page2, 'html.parser')
            with open(f_path, "w") as outfile2:
                outfile2.write(soup2.prettify())
            outfile2.close()
            print("write to: " + f_path)

            browser.minimize_window()
            browser.quit()
        else:
            with open(q_path) as q:
                soup1 = BeautifulSoup(q, 'html.parser')
                print("loaded: " + q_path)
            q.close()
            with open(f_path) as r:
                soup2 = BeautifulSoup(r, 'html.parser')
                print("loaded: " + f_path)

        return soup1, soup2

    # list whatever qfii buy or sell
    def parse_1(soup1):
        # print("parse_1+")
        '''
        tab1 = soup1.find_all("div",                                          \
                {"class": "rwd-table dragscroll sortable F3 R4_"})
        '''
        # n_tab = len(tab1)
        # print("# table: " + str(n_tab))

        '''
        ths = soup1 \
            .find_all("div", {"rwd-table dragscroll sortable F3 R4_"})[0] \
            .find_all("thead")[0] \
            .find_all("th")
        n_th = len(ths)
        print("# th:" + str(n_th))
        '''

        n_rec = len(soup1.find_all("table", {})[0]   \
                .find_all("tbody")[0]                                   \
                .find_all("tr"))
        # print("n_rec: " + str(n_rec))

        q_all  = DIR0 + "/" + "list1."  + yyyy + mm + dd + '.txt'
        q_buy  = DIR0 + "/" + "list1b." + yyyy + mm + dd + '.txt'
        q_sell = DIR0 + "/" + "list1s." + yyyy + mm + dd + '.txt'
        with open(q_all, 'wt') as out0, \
            open(q_buy, 'wt') as out1, \
            open(q_sell, 'wt') as out2:

            tab1 = soup1.find_all("table", {})[0].find_all("tbody")[0]
            n_td = len(soup1.find_all("table", {})[0]   \
                .find_all("tbody")[0]                                   \
                .find_all("tr")[0] \
                .find_all("td"))
            # print("n_td: " + str(n_td))

            for i in range(0, n_rec):
                '''
                tkr1  = tab1                                            \
                        .find_all("tbody")[0]                           \
                        .find_all("tr")[i]                              \
                        .find_all("td")[1].text.strip().replace(',', '')

                tkr1 = soup1.find_all("table", {})[0] \
                    .find_all("tbody")[0] \
                    .find_all("tr")[i].find_all("td")[1].text.strip().replace(',', '')
                '''
                # print(i)
                row = tab1.find_all("tr")[i]
                tkr1 = row.find_all("td")[1].text.strip().replace(',', '')

                name1 = row.find_all("td")[2].text.strip().replace(',', '')
                # print(name1)

                # vol1  = row.find_all("td")[n_td-1].text.strip() \
                #        .replace(',', '') # [:-3] # 1000 shares
                # however td could be empty,

                vol1  = row.find_all("td")[5].text.strip() \
                        .replace(',', '') # [:-3] # 1000 shares
                # print(vol1)

                out0.write(tkr1+":"+name1+":"+vol1+"\n")

                item = []
                item.append(tkr1); item.append(name1);
                item.append(int(vol1))

                if ( vol1.lstrip("-").isdigit() ):
                    if ( 0 < int(vol1) ):
                        out1.write(tkr1+":"+name1+":"+vol1+"\n")
                        list1b.append(item)
                    if ( int(vol1) < 0 ):
                        out2.write(tkr1+":"+name1+":"+vol1+"\n")
                        list1s.append(item)

                # end = timer()
                # msg = "{0}: {1} {2}" \
                #     .format(str(i).zfill(6), \
                #    timedelta(seconds=end-start), \
                #    item )
                #print(msg)

        out0.close(); out1.close(); out2.close()
        # print("parse_1-")
        return n_rec

    # list whatever fund buy or sell
    def parse_2(soup2):
        # print("parse_2+")
        '''
        tab2 = soup2.find_all("div",                                          \
                {"class": "rwd-table dragscroll sortable F3 R4_"})
        '''
        tab2 = soup2.find_all("table", {})[0].find_all("tbody")[0]

        '''
        n_td = len(soup2.find_all("table", {"id": "report-table"})[0]   \
                .find_all("tbody")[0]                                   \
                .find_all("tr")[0]                                      \
                .find_all("td"))
        '''
        n_td = len(soup2.find_all("table", {})[0]   \
            .find_all("tbody")[0]                                   \
            .find_all("tr")[0] \
            .find_all("td"))

        '''
        n_rec = len(soup2.find_all("table", {"id": "report-table"})[0]   \
                .find_all("tbody")[0]                                   \
                .find_all("tr"))
        '''
        n_rec = len(soup2.find_all("table", {})[0]   \
                .find_all("tbody")[0]                                   \
                .find_all("tr"))


        f_all  = DIR0 + "/" + "list2."  + yyyy + mm + dd + '.txt'
        f_buy  = DIR0 + "/" + "list2b." + yyyy + mm + dd + '.txt'
        f_sell = DIR0 + "/" + "list2s." + yyyy + mm + dd + '.txt' #// TODO: 'list2' to 'fund'

        with open(f_all, 'wt') as out0, \
            open(f_buy, 'wt') as out1, \
            open(f_sell, 'wt') as out2:

            for i in range(0, n_rec):
                row = tab2.find_all("tr")[i]
                '''
                tkr2  = tab2                                            \
                        .find_all("tbody")[0]                           \
                        .find_all("tr")[i]                              \
                        .find_all("td")[1].text.strip().replace(',', '')
                '''
                tkr2  = row.find_all("td")[1].text.strip().replace(',', '')

                '''
                name2 = tab2                                            \
                        .find_all("tbody")[0]                           \
                        .find_all("tr")[i]                              \
                        .find_all("td")[2].text.strip().replace(',', '')
                '''
                name2 = row.find_all("td")[2].text.strip().replace(',', '')

                '''
                vol2  = tab2                                            \
                        .find_all("tbody")[0]                           \
                        .find_all("tr")[i]                              \
                        .find_all("td")[n_td-1].text.strip()            \
                            .replace(',', '') # [:-3] # 1000 shares
                '''
                vol2  = row.find_all("td")[n_td-1].text.strip() \
                        .replace(',', '')

                out0.write(tkr2+":"+name2+":"+vol2+"\n")

                if ( vol2.lstrip("-").isdigit() ):
                    if ( 0 < int(vol2) ):
                        item = []
                        item.append(tkr2); item.append(name2);
                        item.append(int(vol2))
                        list2b.append(item)
                        out1.write(tkr2+":"+name2+":"+vol2+"\n")
                    elif ( int(vol2) <= 0 ):
                        item = []
                        item.append(tkr2); item.append(name2);
                        item.append(int(vol2))
                        list2s.append(item)
                        out2.write(tkr2+":"+name2+":"+vol2+"\n")
            '''
            for i in range(0, len(list2b)):
                out1.write(list2b[i][0]+":"+ \
                    list2b[i][1]+":"+str(list2b[i][2])+"\n")
            for i in range(0, len(list2s)):
                out2.write(list2s[i][0]+":"+ \
                    list2s[i][1]+":"+str(list2s[i][2])+"\n")
            '''
        out0.close(); out1.close(); out2.close()
        # print("parse_2-")
        return n_rec

    # \param market: 0 (choppy), 1 (down), 2 (up)
    def merge12(market, l1_b, l1_s, l2_b, l2_s, ld_lst, lu_lst):
        # transpose ( @see shorturl.at/ntuy8 ) then union
        # extend # of row, then looping
        print("merge12+ {}".format(market)) # // FIXME:
        l1b = l1_b.copy()
        l1s = l1_s.copy()
        l2b = l2_b.copy()
        l2s = l2_s.copy()

        # start = timer()
        # print("transpose...")
        t_list1b = numpy.transpose(l1b)[0]
        t_list1s = numpy.transpose(l1s)[0]
        t_list2b = numpy.transpose(l2b)[0]
        t_list2s = numpy.transpose(l2s)[0]
        # end = timer()
        # print(timedelta(seconds=end-start))

        # start = timer()
        # print("union...")
        # union without repition @see shorturl.at/kSVW8
        u_f = list( set(t_list1b) | set(t_list1s) | set(t_list2b) | set(t_list2s) )
        # end = timer()
        # print(timedelta(seconds=end-start))

        # start = timer()
        # print("strip None...")
        t_f = [i for i in u_f if i is not None]
        # with open("t_f.txt", 'wt') as ofile:
        #    ofile.write(pprint(t_f))
        #    ofile.close()
        # to be validated
        # end = timer()
        # print(timedelta(seconds=end-start))

        # start = timer()
        # print("transpose back...")
        tab1 = numpy.transpose(t_f)
        # end = timer()
        # print(timedelta(seconds=end-start))

        # start = timer()
        # print("to list...")
        for i in range(0, len(tab1)):
            lst = []; lst.append(tab1[i])
            full_tab.append(lst)
        # end = timer()
        # print(timedelta(seconds=end-start))

        # assert all ticker in place

        # start = timer()
        # print("append name column...")
        for i in range(0, len(full_tab)):
            full_tab[i].append("") # '' "" None
        # end = timer()
        # print(timedelta(seconds=end-start))

        # start = timer()
        # print("add 'qfii buy' column with default value...")
        for i in range(0, len(full_tab)):
            full_tab[i].append(0)
        # update qfii buy numbers
        for i in range(0, len(l1_b)):
            for j in range(0, len(full_tab)):
                if l1_b[i][0] in full_tab[j]: #.index()
                    full_tab[j][2] = l1_b[i][2]
                    # update name as well
                    if len(full_tab[j][1]) <= 0 :
                        full_tab[j][1] = l1_b[i][1]
        # end = timer()
        # print(timedelta(seconds=end-start))


        # start = timer()
        # print("add 'qfii sell' column with default value...")
        for i in range(0, len(full_tab)):
            full_tab[i].append(0)
        # print("update qfii sell numbers...")
        for i in range(0, len(l1_s)):
            for j in range(0, len(full_tab)):
                if l1_s[i][0] in full_tab[j]:
                    full_tab[j][3] = l1_s[i][2]
                    # update name as well
                    if len(full_tab[j][1]) <= 0 :
                        full_tab[j][1] = l1_s[i][1]
        # end = timer()
        #print(timedelta(seconds=end-start))

        # start = timer()
        # print("add 'fund buy' column with default value...")
        for i in range(0, len(full_tab)):
            full_tab[i].append(0)
        # print("update fund buy numbers...")
        for i in range(0, len(l2_b)):
            for j in range(0, len(full_tab)):
                if l2_b[i][0] in full_tab[j]:
                    full_tab[j][4] = l2_b[i][2]
                    # update name as well
                    if len(full_tab[j][1]) <= 0 :
                        full_tab[j][1] = l2_b[i][1]
        # end = timer()
        # print(timedelta(seconds=end-start))

        # pprint(full_tab)

        # start = timer()
        # print("add 'fund sell' column with default value...")
        for i in range(0, len(full_tab)):
            full_tab[i].append(0)
        # print("update fund sell numbers...")
        for i in range(0, len(l2_s)):
            for j in range(0, len(full_tab)):
                if l2_s[i][0] in full_tab[j]:
                    full_tab[j][5] = l2_s[i][2]
                    # update name as well
                    if len(full_tab[j][1]) <= 0 :
                        full_tab[j][1] = l2_s[i][1]
        # end = timer()
        # print(timedelta(seconds=end-start))

        # add columns
        for i in range(0, len(full_tab)):
            full_tab[i].append(0) # 2 b
            full_tab[i].append(0) # 2 s
            full_tab[i].append(0) # qfii anomaly
        print("highlight b2, s2, and qa ...")

        outf1 = open(path1, 'wt')
        outf2 = open(path2, 'wt')
        outf3 = open(path3, 'wt')
        outf4 = open(path4, 'wt')

        for i in range(0, len(full_tab)):
            tkr = full_tab[i][0].strip()
            # print(tkr)
            if ( 0 < int(full_tab[i][2]) ) and ( 0 < int(full_tab[i][4]) ):
                full_tab[i][6] = 1
                rec = "{0}:{1}:{2}:{3}" \
                    .format( \
                    full_tab[i][0],
                    full_tab[i][1], \
                    full_tab[i][2], \
                    full_tab[i][4] )
                outf1.write(rec +"\n")

            if ( int(full_tab[i][3]) < 0 ) and ( int(full_tab[i][5]) < 0 ):
                full_tab[i][7] = 1
                rec = "{0}:{1}:{2}:{3}" \
                    .format( \
                    full_tab[i][0], full_tab[i][1], \
                    full_tab[i][3], full_tab[i][5] )
                outf2.write(rec +"\n")

            # in updown list and qfii doing reverse
            if ( len(tkr) <= 4 ):
                # rule 37.3 qfii sell at limit up
                if ( lu_lst is not None and \
                    0 < len(lu_lst) ):
                    if ( int(tkr) in lu_lst \
                        and int(full_tab[i][3]) < 0 ):
                        print( "qslu " + tkr )
                        full_tab[i][8] = 1
                        rec = "{0}:{1}:{2}:{3}" \
                            .format( \
                            full_tab[i][0], full_tab[i][1], \
                            full_tab[i][2], full_tab[i][3] )
                        outf3.write(rec +"\n")

                # rule 37.4 qfii buy at limit down
                if ( ld_lst is not None and \
                    0 < len(ld_lst) ):
                    if ( int(tkr) in ld_lst \
                        and 0 < int(full_tab[i][2]) ):
                        full_tab[i][8] = 1
                        print( "qbld " + tkr )
                        rec = "{0}:{1}:{2}:{3}" \
                            .format( \
                            full_tab[i][0], full_tab[i][1], \
                            full_tab[i][2], full_tab[i][3] )
                        outf4.write(rec +"\n")

            # // TODO: another file, drop limit but stock qfii doing reverse

            # condition 1.
            # market rip and qfii climax sell or
            # market dip and qfii buy
            if ( market == 1 and 0 < int(full_tab[i][2]) ):
                full_tab[i][8] = 1
                rec = "{0}:{1}:{2}:{3}" \
                    .format( \
                    full_tab[i][0], full_tab[i][1], \
                    full_tab[i][2], full_tab[i][3] )
                outf3.write(rec +"\n")
            elif ( market == 2 and int(full_tab[i][3]) < 0 ):
                full_tab[i][8] = 1
                rec = "{0}:{1}:{2}:{3}" \
                    .format( \
                    full_tab[i][0], full_tab[i][1], \
                    full_tab[i][2], full_tab[i][3] )
                outf3.write(rec +"\n")
            else:
                # print("market is 0")
                pass
            # // TODO: index drop but stock qfii doing reverse


            # condition 3. limit up and qfi sell for several days

            # more?

            rec = "{0}:{1}:{2}:{3}:{4}:{5}:{6}:{7}:{8}" \
                .format( \
                full_tab[i][0], full_tab[i][1], \
                full_tab[i][2], full_tab[i][3], \
                full_tab[i][4], full_tab[i][5], \
                full_tab[i][6], full_tab[i][7], \
                full_tab[i][8] )

        outf1.close(); outf2.close(); outf3.close(); outf4.close()
        return full_tab

    # // TODO: definition of high
    def is_market_rip(deal, change, rise, volume):
        if ( "-" in rise ):
            status = 1
        else:
            status = 2
        return status

    def parse_limit_updown():
        limit_ulist = []; limit_dlist = [];
        u_fname = "limit.up" + "." +yyyy+mm+dd+ '.csv'
        u_path = os.path.join(DIR0, u_fname)
        if ( os.path.exists(u_path) ):
            # print( "usize: " + str(os.path.getsize(u_path)) )
            f = open(u_path, "r")
            line = f.readline().strip()
            while line != '':
                if ( len(line) == 4 ):
                    limit_ulist.append(int(line))
                line = f.readline().strip()
            f.close()
            # print( "lu " + str(len(limit_ulist)) + ": " +
            #        str(pprint(limit_ulist)) )
        else:
            print("not found: " + u_path)

        d_fname = "limit.down" + "." +yyyy+mm+dd+ '.csv'
        d_path = os.path.join(DIR0, d_fname)
        if ( os.path.exists(d_path) ):
            f = open(d_path, "r")
            line = f.readline().strip()
            while line != '':
                if ( len(line) == 4 ):
                    limit_dlist.append(int(line))
                line = f.readline().strip()
            f.close()
            # print( "ld " + str(len(limit_dlist)) + ": " +
            #         str(pprint(limit_dlist)) )
        else:
            print("not found: " + d_path)

        return [ limit_dlist, limit_ulist ]

    start = timer()
    n3 = parse_limit_updown()
    end = timer()
    print("get limit updown list..."+yyyy+mm+dd+" done, takes " \
            +str(timedelta(seconds=end-start)))

    # 0 (choppy), 1 (down), 2 (up)
    market_status = is_market_rip(deal, change, rise, volume)
    print("-is_market_rip " + str(market_status))

    start = timer()
    soups = fetch()
    end = timer()
    print("fetched: "+theday+ " takes " + str(timedelta(seconds=end-start)))

    start = timer()
    n1 = parse_1(soups[0])
    end = timer()
    print("processed qfii " + theday + " takes " + \
        str(timedelta(seconds=end-start)))

    start = timer()
    n2 = parse_2(soups[1])
    end = timer()
    print("processed fund " + theday + " takes " \
            +str(timedelta(seconds=end-start)))

    print("merging, highlight, and output to 3 files...")
    tab = merge12(market_status, list1b, list1s, list2b, list2s, n3[0], n3[1] )
    with open(ofname, 'wt') as ofile:
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
            qa   = tab[i][8] # qfii anomaly
            ofile.write(tkr+":"+name+":"+ \
                    str(qb)+":"+str(qs)+":"+str(fb)+":"+str(fs)+":"+ \
                    str(b2)+":"+str(s2)+":"+str(qa)+"\n")
        ofile.close()
    msg = "finish buying "+str(n1)+", and selling "+str(n2)+"."
    say(msg)

except (SessionNotCreatedException):
    print('turn on safari remote option.')

except:
    # traceback.format_exception(*sys.exc_info())
    e = sys.exc_info()[0]
    print("Unexpected error:", sys.exc_info()[0])
    raise

finally:
    # print('finally...')
    pass

print('qfii.py-')

sys.exit(0)
