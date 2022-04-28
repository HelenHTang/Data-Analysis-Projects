# Python Notebook - Clone of Python Tutorial - Lessons 7 & 8

datasets[0].head(n=5)

import pandas as pd
import numpy as np

data = datasets[0] 
data = data.fillna(np.nan)

data.sort_values(by='arr_delay', ascending=False)[:10]

data['delayed'] = data['arr_delay'].apply(lambda x: x > 0)

data['delayed'].value_counts()

not_delayed = data['delayed'].value_counts()[0] 
delayed = data['delayed'].value_counts()[1] 
total_flights = not_delayed + delayed 
print float(delayed) / total_flights

print 'About 49% of all flights from January 1-15, 2015, were delayed.'

data['cancelled'].value_counts()

not_delayed, delayed = data['cancelled'].value_counts()
print float(delayed) / (delayed + not_delayed),

print 'About 2.38% of flights were cancelled.'

group_by_carrier = data.groupby(['unique_carrier','delayed'])
delays_by_carrier = group_by_carrier.size().unstack()
delays_by_carrier

delays_by_carrier.plot(kind='bar', title='Flight Delays by Carrier', figsize=[16,6], colormap='winter')

flights_by_carrier = data.pivot_table(index='flight_date', columns='unique_carrier', values='flight_num', aggfunc='count')
flights_by_carrier.head()

delays_list = ['carrier_delay','weather_delay','late_aircraft_delay','nas_delay','security_delay']
flight_delays_by_day = data.pivot_table(index='flight_date', values=delays_list, aggfunc='sum')
flight_delays_by_day

flight_delays_by_day.plot(kind='area', figsize=[16,6], colormap='summer')



