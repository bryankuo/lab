# connect to google

import sys
from pytrends.request import TrendReq
from pprint import pprint

ticker = sys.argv[1]
pytrends = TrendReq(hl='en-US', tz=360)

# @see shorturl.at/gtCJ1
# build payload, list of keywords to get data
# at most 5?
# kw_list = ['1455', '3025', '1909', '1312', '5483']
kw_list = [ ticker, '2330', '2603' ]
pytrends.build_payload(kw_list, cat=0, timeframe='today 1-m', geo='TW', \
     gprop='')
#1 Interest over Time
data = pytrends.interest_over_time()
# pprint(data)
data = data.reset_index()
import plotly.express as px
fig = px.line(data, x="date", y=kw_list, \
        title='Keyword Web Search Interest Over Time')
fig.show()
