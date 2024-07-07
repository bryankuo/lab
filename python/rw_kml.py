#!/usr/bin/python3

# python3 rw_kml.py

# \param in kml file
# \parm out csv file to upload

# how to export my google map? (takeout) export check kml
# distance between two points based on latitude/longitude
# geopy
# read kml? import kml? fastkml? pykml?
# @see https://shorturl.at/gtZLr @see https://rb.gy/7tb4dp
# pip3 install pykml fastkml

# return 0: success

import sys, pandas as pd
from pykml import parser
from pprint import pprint

'''
# from fastkml import kml
f = open('./datafiles/taiex/companies.kml', 'rt')
doc = f.read().encode('utf-8')
k = kml.KML()
k.from_string(doc) # @see https://rb.gy/7tb4dp
# print(doc)
# print(k.to_string(prettyprint=True))
# features = list(k.features())
len(list(features[0].features()))
print(features[0].name) # TWSE listed companies
print(features[0].features)
features = list(k.features())
# with multiple folders in it
'''

# @see https://stackoverflow.com/a/13716220
root = parser.fromstring( \
    open('./datafiles/taiex/companies.kml', 'r') \
        .read().encode('utf-8'))
# print(root.Document.Folder[0].name)
# print(root.Document.Folder[0].Placemark[1].name.text[0:4])
# sys.exit(0)

total_p = len(root.Document.Folder[0].Placemark)
# print(root.Document.Folder[0].Placemark[466].Point.coordinates.text.strip())
lst = []
for p in root.Document.Folder[0].Placemark:
    # print(p.Point.coordinates.text.strip())
    tkr  = p.name.text[0:4]
    locs = p.Point.coordinates.text.strip().split(',')
    lng  = locs[0]; lat = locs[1]
    t = (tkr, lng, lat)
    # print(t)
    lst.append(t)

columns = ['ticker', 'longitude', 'latitude']
# data = [(103, 201, 67), (103, 203, 67), (103, 204, 89)]
df = pd.DataFrame(lst, columns=columns)
# pprint(df)
opath = './datafiles/taiex/companies.kml.csv'
df.to_csv(opath, sep = ':', header=True, index=False)

sys.exit(0)
