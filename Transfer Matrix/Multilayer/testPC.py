import numpy as np
import math
import matplotlib.pyplot as plt
from PC import PC as PC

if __name__ == '__main__':
    N = 20
    c = 3.0*10**8
    lambda0 = c/10**10
    frequency = 10**9*np.arange(0,20,0.01)

    materialid = np.ones(N)
    d = np.ones(N)
    for n in range(N):
        if n%2 == 1:
            materialid[n] = 1
            d[n] = lambda0/4/math.sqrt(12.25)
        else:
            materialid[n] = 2
            d[n] = lambda0/4/math.sqrt(4)


    [reflection,transmission] = PC(materialid,d,frequency)
    plt.plot(1.0*10**-9*frequency,np.square(np.abs(transmission)))
    plt.title('Transmission Spectrum')
    plt.xlabel('Frequency (GHz)')
    plt.ylabel('Transmission')
    plt.ylim(0,1)
    plt.show()