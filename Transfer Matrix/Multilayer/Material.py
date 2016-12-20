import numpy as np
import materials

MATERIALIDS = {
    0:materials.Si,
    1:materials.SiO2
}

def Material(materialid,frequency):
    N = len(materialid)
    M = len(frequency)
    epsilon = np.ones([N,M])
    mur = np.ones([N,M])

    for n in range(N):
        [eps,mu] = MATERIALIDS[materialid[n]](frequency)
        epsilon[n,:] = eps
        mur[n,:] = mu