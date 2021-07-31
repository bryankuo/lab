import matplotlib.pyplot as plt
import seaborn
import numpy as np
import pandas as pd
import pandas_datareader as web
from datetime import datetime

start = datetime(2019, 1, 1)
symbols_list = [ \
    'F', 'AAPL', 'TSM', 'UMC', 'MU', \
    'ASML','ASX','KLIC','INTC','AMD'
]
symbols = []
for ticker in symbols_list:
    r = web.DataReader(ticker, 'yahoo', start)
    r['Symbol'] = ticker
    symbols.append(r)
df = pd.concat(symbols)
df = df.reset_index()
df = df[['Date', 'Close', 'Symbol']]
df.head()
df_pivot=df.pivot('Date','Symbol','Close').reset_index()
df_pivot.head()

corr_df = df_pivot.corr(method='pearson')
corr_df.head().reset_index()
corr_df.head(10)

plt.figure(figsize=(13,8))
seaborn.heatmap(corr_df, annot=True, cmap='YlGnBu')
plt.figure()
plt.show()
