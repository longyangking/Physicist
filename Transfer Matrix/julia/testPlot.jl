using Plots
x = 0:0.05*pi:4*pi
y = sin.(x)
gr()
display(plot(x,y))