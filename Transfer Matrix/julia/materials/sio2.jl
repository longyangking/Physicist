function SiO2(frequency)
    N = length(frequency)
    epsilon = 12.5*ones(N)
    mu = 1.0*ones(N)
    [epsilon, mu]
end