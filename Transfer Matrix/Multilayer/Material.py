import numpy as np
import materials

MATERIALIDS = {
    0:materials.Air,
    1:materials.SiO2,
    2:materials.Si
}

def Material(materialid,frequency):
    N = len(materialid)
    M = len(frequency)
    epsilon = np.ones([N,M])
    mur = np.ones([N,M])
    MaxType = len(MATERIALIDS)

    for n in range(N):
        if materialid[n] < MaxType:
            [eps,mu] = MATERIALIDS[materialid[n]](frequency)
            epsilon[n,:] = eps
            mur[n,:] = mu

    return np.array([epsilon,mur])