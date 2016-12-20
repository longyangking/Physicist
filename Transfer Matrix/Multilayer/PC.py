import numpy as np

def PC(materialid,d,frequency):
    [epsilon,mur] = Material(materialid,frequency)
    Z = np.sqrt(mur/epsilon)
    n = np.sqrt(mur*epsilon)
    