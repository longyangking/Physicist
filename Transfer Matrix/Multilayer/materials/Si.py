import numpy as np

def Si(frequency):
    N = len(frequency)
    epsilon = 4.0*np.ones(N)
    mur = 1.0*np.ones(N)
    return np.array([epsilon,mur])