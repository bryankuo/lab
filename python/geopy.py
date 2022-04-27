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

# https://www.latlong.net
import sys, requests
import urllib.parse
from bs4 import BeautifulSoup

# Open Street Map database
# @see https://stackoverflow.com/a/62069773
import sys, requests
import urllib.parse
import webbrowser, os

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

# folium
import folium
# myMap = folium.Map([22.73444963475145, 120.28458595275877], zoom_start=14)
myMap = folium.Map([response[0]["lat"], response[0]["lon"]], zoom_start=14)

# Import the pandas library
import pandas as pd

# Make a data frame with dots to show on the map
data = pd.DataFrame({
   'lon':['120.29', response[0]["lon"]],
   'lat':['22.75', response[0]["lat"]],
   'name':['Buenos Aires', 'Paris'],
   'value':[10, 12]
}, dtype=str)

# print(len(data))

# add marker one by one on the map
for i in range(0,len(data)):
   folium.Marker(
      location=[data.iloc[i]['lat'], data.iloc[i]['lon']],
      popup=data.iloc[i]['name'],
   ).add_to(myMap)

filename = 'myMap.html'
myMap.save(filename)
# url = "file:///Users/chengchihkuo/github/python/myMap.html"
url = 'file://' + os.path.realpath(filename)
print("generate file: " + url)
# url = 'file:///Users/chengchihkuo/github/python/myMap.html'
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
