import numpy as np
from Material import Material as Material

def PC(materialid,d,frequency):
    [epsilon,mur] = Material(materialid,frequency)
    Z = np.sqrt(mur/epsilon)
    n = np.sqrt(mur*epsilon)
    Num = epsilon.shape[0]
    Fnum = len(frequency)

    transmission = np.zeros(Fnum,dtype=complex)
    reflection = np.zeros(Fnum,dtype=complex)

    for f in range(Fnum):
        Pairin = 0.5*np.array([[1+Z[0,f],1-Z[0,f]],[1-Z[0,f],1+Z[0,f]]])
        Pairout = 0.5*np.array([[1+1/Z[Num-1,f],1-1/Z[Num-1,f]],[1-1/Z[Num-1,f],1+1/Z[Num-1,f]]])
        Q = np.identity(2)
        Q = M(n[0,f],d[0],frequency[f]).dot(Pairin.dot(Q))
        for m in range(1,Num):
            Q = M(n[m,f],d[m],frequency[f]).dot(P(Z,f,m-1,m).dot(Q))
        Q = Pairout.dot(Q)

        reflection[f] = -Q[1,0]/Q[1,1]
        transmission[f] = -(Q[0,1]*Q[1,0]-Q[0,0]*Q[1,1])/Q[1,1]
    
    return np.array([reflection,transmission])

def P(Z,f,m,n):
    ratio = Z[n,f]/Z[m,f]
    return 0.5*np.array([[1+ratio, 1-ratio],[1-ratio, 1+ratio]])

def M(n,d,frequency):
    c = 3.0*10**8
    w = 2*math.pi*frequency
    phase = np.exp(1j*n*w/c*d)
    return np.array([[phase,0],[0,np.conj(phase)]])