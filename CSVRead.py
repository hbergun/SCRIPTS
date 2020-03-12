import pandas as pd
import matplotlib.pyplot as plt
import statsmodels.tsa.holtwinters as ets 
#import numpy as np
#from sklearn.model_selection import train_test_split

spy = pd.read_csv('C:/Users/Berk/Desktop/resource export.csv',sep = ';')
print(spy)
