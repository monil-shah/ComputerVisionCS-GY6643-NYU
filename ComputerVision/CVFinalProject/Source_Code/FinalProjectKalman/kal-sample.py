import numpy as np
from matplotlib import pyplot as plt
import pandas as pd

df1 = pd.read_csv('/Users/tabish/CVProjectVideo/vidfinal/detections.txt', sep=' ')
df1.drop(df1.columns[[0]], axis=1, inplace=True)

df2 = pd.read_csv('/Users/tabish/CVProjectVideo/vidfinal/predictions.txt', sep=' ')
df2.drop(df2.columns[[0]], axis=1, inplace=True)

Measured = df1.values
kalman = df2.values

plt.plot(Measured[:,0], Measured[:,1]*(-1), 'ro', label='measured')
plt.plot(kalman[:,0], kalman[:,1]*(-1), 'x', label='kalman output')
plt.legend(loc=2)
plt.title("Ball Trajectory")
plt.show()