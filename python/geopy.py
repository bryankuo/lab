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

bkr = pd.DataFrame({
   'lon':[
       '121.551510', '121.535080', '121.576460', '121.442000', '121.536594',
       '120.432934', '121.547735', '121.549190', '121.565080', '121.567021' ],
   'lat':[
       '25.084880', '25.052340', '25.049880', '24.978716', '25.060288',
       '23.709612', '25.057556', '25.022218', '25.042985', '25.032741' ],
   'name':[
       '凱基', '凱基-台北', '凱基-松山', '元大-土城永寧', '富邦-建國',
       '富邦-虎尾', '群益金鼎', '國泰', '康和', '摩根大通' ],
   'value':[
       1, 2, 3, 4, 5,
       6, 7, 8, 9, 10 ],
   'bno': [
       9200, 9268, 9217, 9875, 9658,
       9697, 9100, 8880, 8450, 8440 ],
   'addr': [
       "No. 698, Mingshui Rd, Zhongshan District Taipei City, 10491, Taiwan",
       "No. 137, Section 2, Nanjing E Rd, Zhongshan District Taipei City, 10491, Taiwan",
       "No. 678, Section 4, Bade Rd, Songshan DistrictTaipei City, 105, Taiwan",
       "No. 8, Yuanfu St, Tucheng District New Taipei City, 236, Taiwan",
       "No. 196a, Section 2, Jianguo N Rd, Zhongshan District Taipei City, 10491, Taiwan",
       "No. 133, Gong'an Rd, Huwei Township, 632, Taiwan",
       "14, No. 156, Section 3, Minsheng E Rd, Songshan District, Taipei City, 105, Taiwan",
       "No. 335, Section 2, Dunhua S Rd, Da’an District, Taipei City, 106, Taiwan",
       "No. 176-1, Section 1, Keelung Rd, Xinyi District, Taipei City, 110 Taiwan",
       "3, No. 106, Section 5, Xinyi Rd, Xinyi District, Taipei City, 110, Taiwan" ]
}, dtype=str)

tkr = pd.DataFrame({
   'lon': ['121.187423', '120.604278', '120.283691', '120.882676', '121.297149' ],
   'lat': ['24.885206', '24.147509', '22.764811', '24.696713', '25.040364' ],
   'name':['合晶科技', '大立光電', '久陽精密', '超豐電子', '長榮航空'],
   'value':[ 6182, 3008, 5011, 2441, 2618 ],
   'addr': [
       "No. 100, Longyuan 1st Rd, Longtan District, Taoyuan City, 325, Taiwan",
       "No. 11, Jingke Rd, Nantun District, Taichung City, 408 Taiwan",
       "No. 299, Yulin Rd, Qiaotou District, Kaohsiung City, 825 Taiwan",
       "No. 136, Gongyi Rd, Zhunan Township, Miaoli County, 350 Taiwan",
       "No. 376, Section 1, Xinnan Rd, Luzhu District, Taoyuan City, 338 Taiwan" ]
}, dtype=str)

# add marker one by one on the map
for i in range(0,len(bkr)):
   folium.Marker(
      location=[bkr.iloc[i]['lat'], bkr.iloc[i]['lon']],
      popup=bkr.iloc[i]['name'],
   ).add_to(myMap)

# @see https://bit.ly/3OQloFu
for i in range(0,len(tkr)):
   folium.Marker(
      location=[tkr.iloc[i]['lat'], tkr.iloc[i]['lon']],
      color='orange',
      clustered_marker=True,
      popup=tkr.iloc[i]['name'],
      icon=folium.Icon(color='green', icon='info-sign'),
   ).add_to(myMap)

filename = 'myMap.html'
myMap.save(filename)
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
