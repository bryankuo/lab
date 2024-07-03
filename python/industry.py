#!/usr/bin/python3

# minimum python function for shell script

# python3 industry.py

# \param in  url
# \param out html path
#
# return 0

import os, sys, requests, random
from bs4 import BeautifulSoup
from pprint import pprint
sys.path.append(os.getcwd())
import useragents as ua
import sites

# if ( len(sys.argv) < 1 ):
#     print("python3 requests_url.py [url]")
#    sys.exit(0)
# url = sys.argv[1]

DIR0 = "./datafiles/taiex"
if not os.path.exists(DIR0):
    os.mkdir(DIR0)

fname = 'industry.html'
html_path = os.path.join(DIR0, fname)

'''
url = random.choice(sites.list) + "/z/zh/zha/zha.djhtm"
print("from {}".format(url))
headers = {'User-Agent': random.choice(ua.list)}
response = requests.get(url, headers=headers)
# response.encoding = 'cp950'
soup = BeautifulSoup(response.text, 'html.parser')
outfile2 = open(html_path, "w")
outfile2.write(soup.prettify())
outfile2.close()
print("to {}".format(html_path))
'''

f = open(html_path, "r")
soup = BeautifulSoup(f, 'html.parser')
table = soup.find("table", {"id": "oMainTable"})
print("{} oMain".format(len(table)))
a = table.find_all('tr')[3].text.strip()
print(a)
i = 0
# for row in range(2, len(rows)-2):
    # i = rows[i].find_all('td')[0].text.strip()
    # print("{}".format(i))
industry = []
f.close()

sys.exit(0)
