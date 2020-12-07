include("./materials/air.jl")
include("./materials/si.jl")
include("./materials/sio2.jl")

MaterialIDs = Dict(
    0 => Air,
    1 => SiO2,
    2 => Si
)

function Material(materialID, frequency)
    N = length(materialID)
    M = length(frequency)
    epsilons = ones((N, M))
    mus = ones((N, M))
    maxtype = length(MaterialIDs)

    for i in 1:N
        if materialID[i] <= maxtype
            eps, mu = MaterialIDs[materialID[i]](frequency)
            epsilons[i, :] = eps
            mus[i, :] = mu
        end
    end

    [epsilons, mus]
end