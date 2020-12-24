include("material.jl")

function P(Z, f, m, n)
    ratio = Z[n,f]/Z[m,f]
    return 0.5*([1+ratio 1-ratio; 1-ratio 1+ratio])
end

function M(n, d, frequency)
    c = 3e8
    w = 2*pi*frequency
    phase = exp(1im*n*w/c*d)
    return [phase 0; 0 conj(phase)]
end

function PC(materialid, d, frequency)
    epsilon, mu = Material(materialid, frequency)
    Z = sqrt.(mu./epsilon)
    n = sqrt.(mu.*epsilon)

    Num = ndims(epsilon)[1]
    Fnum = length(frequency)

    transmission = zeros(ComplexF64,Fnum)
    reflection = zeros(ComplexF64,Fnum)

    for f in 1:Fnum
        Pairin = 0.5*[1+Z[1,f] 1-Z[1,f]; 1-Z[1,f] 1+Z[1,f]]
        Pairout = 0.5*[1+1/Z[Num,f] 1-1/Z[Num,f]; 1-1/Z[Num,f] 1+1/Z[Num,f]]
        Q = [1 0; 0 1]
        Q = M(n[1,f], d[1], frequency[f])*(Pairin*Q)
        for m in 2:Num
            Q = M(n[m,f], d[m], frequency[f])*(P(Z, f, m-1, m)*Q)
        end
        Q = Pairout*Q
        
        reflection[f] = - Q[2,1]/Q[2,2]
        transmission[f] = - (Q[1,2]*Q[2,1] - Q[1,1]*Q[2,2])/Q[2,2]
    end

    return [reflection, transmission]
end