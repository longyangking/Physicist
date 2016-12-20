import numpy as np

def Air(frequency):
    N = len(frequency)
    epsilon = 1.0*np.ones(N)
    mur = 1.0*np.ones(N)
    return np.array([epsilon,mur])