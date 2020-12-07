include("material.jl")

function PC(materialid, d, frequency)
    epsilon, mu = Material(materialid, frequency)
    Z = sqrt.(mu./epsilon)
    n = sqrt.(mu.*epsilon)

    Num = ndims(epsilon)[1]
    Fnum = length(frequency)

    transmission = zeros(Fnum)
    reflection = zeros(Fnum)

    for f in 1:Fnum
        
    end
end