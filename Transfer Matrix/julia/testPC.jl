using Plots
include("PC.jl")

N = 20
c = 3e8
lambda0 = c/1e10
frequency = 1e9*(0:0.01:20)
#frequency = 1e9*[1 2]

materialid = ones(N)
d = ones(N)
for n = 1:N
    if n%2 == 0
        materialid[n] = 1
        d[n] = lambda0/4/sqrt(12.25)
    else
        materialid[n] = 2
        d[n] = lambda0/4/sqrt(4)
    end
end

reflection, transmission = PC(materialid, d, frequency)
println("Plotting...")
gr()
display(plot(1e-9*frequency, abs2.(transmission)))