#!/usr/bin/python3

# python3 geo.py 2330
# return 0: success

'''
# pygmaps @see https://stackoverflow.com/a/45990656
# git+https://github.com/thearn/pygmaps-extended
# import pygmaps
# import pygmaps-enhanced
# import gmaps
import gmplot

# maps method return map object
# 1st argument is center latitude
# 2nd argument is center longitude
# 3ed argument zoom level
mymap1 = pygmaps.maps(30.3164945, 78.03219179999999, 15)

# create the HTML file which includes
# google map. Pass the absolute path
# as an argument.
mymap1.draw('pygmap1.html')
'''

# in order to read from LO calc ods
# python3 -m pip install odfpy

# Open Street Map database
# @see https://stackoverflow.com/a/62069773
import sys, requests
import urllib.parse
import webbrowser, os
from pprint import pprint

# address = '320桃園市中壢區中和路'
# traditional chinese to english
# address = 'Zhonghe Rd, Zhongli District, Taoyuan City, 320'
address = 'No. 23, Jiucheng N Rd, Yilan City, Yilan County, 260, Taiwan'
url = 'https://nominatim.openstreetmap.org/search/' + \
    urllib.parse.quote(address) +'?format=json'
response = requests.get(url).json()
# pprint(response)
# print(response[0]["lat"]+","+response[0]["lon"])

import folium
# from folium.plugins import MarkerCluster
# myMap = folium.Map([22.73444963475145, 120.28458595275877], zoom_start=14)
# myMap = folium.Map([response[0]["lat"], response[0]["lon"]], zoom_start=14)
# center of map, suitable size
myMap = folium.Map([23.97421357476865, 120.97979067775111], zoom_start=8)
# marker_cluster = MarkerCluster().add_to(myMap)

# @see shorturl.at/hpvyU
# Import the pandas library
import pandas as pd

# Make a data frame with dots to show on the map
'''
data = pd.DataFrame({
   'lon':['120.29', response[0]["lon"]],
   'lat':['22.75', response[0]["lat"]],
   'name':['Buenos Aires', 'Paris'],
   'value':[10, 12]
}, dtype=str)
'''

'''
# read corp from calc ods @see shorturl.at/cvQX9 howto @see shorturl.at/ksvyB
corp = pd.read_excel('./datafiles/corp.ods', engine='odf')
# customize marker @see https://bit.ly/3OQloFu
for i in range(0,len(corp)):
   folium.Marker(
      location=[corp.iloc[i]['lat'], corp.iloc[i]['lon']],
      color='orange',
      clustered_marker=True,
      popup=corp.iloc[i]['name'],
      icon=folium.Icon(color='green', icon='info-sign'),
   ).add_to(myMap)
# 基本資料查詢彙總表 2,4,5
# https://mops.twse.com.tw/mops/web/t51sb01
# https://mops.twse.com.tw/mops/web/t51sb01
# grep -rnp --color="auto" -e "台南" datafiles/taiex/sii.csv | wc -l
# cf. datafiles/taiex/summary.ods
'''

# bkr = pd.read_excel('./datafiles/bkr.ods', engine='odf')
bkr = pd.read_excel('./datafiles/taiex/broker_list.20220518.1533.ods', engine='odf')
# comment is not allowed in calc
# print(bkr)
for i in range(0,len(bkr)):
    if ( bkr.iloc[i]['action'] == 1 ):
        folium.Marker(
            location=[bkr.iloc[i]['lat'], bkr.iloc[i]['lon']],
            color='orange',
            clustered_marker=True,
            popup=bkr.iloc[i]['name'],
            icon=folium.Icon(color='green', icon='info-sign'),
        ).add_to(myMap)
    else:
        folium.Marker(
            location=[bkr.iloc[i]['lat'], bkr.iloc[i]['lon']],
            color='orange',
            clustered_marker=True,
            popup=bkr.iloc[i]['name'],
            icon=folium.Icon(color='red', icon='info-sign'),
        ).add_to(myMap)

'''
# add marker one by one on the map
for i in range(0,len(bkr)):
   folium.Marker(
      location=[bkr.iloc[i]['lat'], bkr.iloc[i]['lon']],
      popup=bkr.iloc[i]['name'],
   ).add_to(myMap)
'''

filename = 'myMap.html'
myMap.save(filename)
# //TODO: figure out not opening
# filename = 'myMap.1533.20220518.html'
url = 'file://' + os.path.realpath(filename)
# print("generate file: " + url)
webbrowser.open(url)
sys.exit(0)

'''
# tgos map
url = "https://map.tgos.tw/TGOSimpleViewer/Web/Map/TGOSimpleViewer_Map.aspx?"+ \
 "CX="+response[0]["lon"]+"&CY="+response[0]["lat"]+"&L=14&Theme=&Data=743315175A117DDD730C2F0E6122B8120B63E4A690F7D038FF0D3B37EED0A286"
webbrowser.open(url)
'''

'''
# google map
url = "https://www.google.com/search?client=safari&rls=en&q=" + \
    response[0]["lat"] + "," + response[0]["lon"] + "&ie=UTF-8&oe=UTF-8"
webbrowser.open(url)
'''

'''
# google map
url = 'https://maps.google.com?q=' + \
    response[0]["lat"]+","+response[0]["lon"]
webbrowser.open(url)
'''

# style off
'''
style = "&style=feature:all|element:labels|visibility:off"
url = 'https://maps.google.com?q=' + \
    response[0]["lat"]+","+response[0]["lon"] + style
webbrowser.open(url)
'''

'''
# open street map
url = "https://www.openstreetmap.org/#map=10/" + \
    response[0]["lat"] + "/" + response[0]["lon"]
webbrowser.open(url)
'''

'''
# apple map
url = "https://duckduckgo.com/?q=" + \
    response[0]["lat"] + \
    "%2C" + response[0]["lon"] + "&t=h_&ia=web&iaxm=maps"
webbrowser.open(url)
'''

'''
# bing map
# @see https://bit.ly/3rSlzWX
url = "https://bing.com/maps/default.aspx?cp=" + \
    response[0]["lat"] + "~" + response[0]["lon"]
webbrowser.open(url)
'''

'''
# yandex map ??
url = "https://yandex.com/maps/?ll="+response[0]["lat"]+","+response[0]["lon"]+"&z=4"
webbrowser.open(url)
'''

# can thought of may layers

sys.exit(0)
