a = 1.0; % related to the viscosity
m = 1.0; % mass
N_T = 50; % number of time pieces
N_sample = 50; % number of samples

NdT = 100; % number of time steps for each time piece
N = NdT*N_T; % number of total time steps
dt = 1e-3; % time step
F_rand0 = 1.0;

xs = zeros(N_sample, N_T);

disp('Calculating...');
tic
for index = 1:N_sample
    x = 0; v = 0; count = 1;
    for n = 1:N
        x = x + v*dt; 
        if mod(n, NdT)==0
            xs(index, count) = x;
            count = count + 1;
        end
        F_rand = F_rand0 * randn();
        F = -a*v + F_rand;
        v = v + dt/m*F;
    end
    if mod(index, round(N_sample/50)) == 0
        disp(sprintf('Calculating %.2f%%...', index/N_sample*100));
    end
end
toc

mx2 = mean(xs.^2, 1); % the ensemble average of x^2 
Ts = NdT*dt*(1:N_T); 
% plot(Ts, (mx2)./(Ts.^2));
plot(Ts, mx2);