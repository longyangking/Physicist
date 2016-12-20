import numpy as np

def SiO2(frequency):
    N = len(frequency)
    epsilon = 12.5*np.ones(N)
    mur = 1.0*np.ones(N)
    return np.array([epsilon,mur])