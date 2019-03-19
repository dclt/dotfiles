# finance with pandas

import pandas_datareader.data as web
import datetime

start = datetime.datetime(2010, 1, 1)
end = datetime.datetime(2013, 1, 27)
f = web.DataReader("F", 'google', start, end)

f.ix['2010-01-04']

# get quote
q = web.get_quote_google(['AMZN', 'GOOG'])

In [44]: q

# get symbol info

rom pandas_datareader.nasdaq_trader import get_nasdaq_symbols
symbols = get_nasdaq_symbols()
print(symbols.ix['IBM'])


# stata to csv
import pandas as pd
dv = pd.read_stata('data.dta')
filename = 'newdata.csv'
df = pd.DataFrame(dv)
df.to_csv(filename, index=False, encoding='utf-8')
