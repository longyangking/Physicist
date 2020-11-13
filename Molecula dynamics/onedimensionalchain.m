clear all;
tic

k = 1;
a = 0;
b = 0.0;
T1 = 1.0;
gamma1 = 1.0;
T2 = 3.0;
gamma2 = 1.0;
N = 100;
nc = 5;
A = 0;
omega = 1;
deltaT = 3e-2;
num = 999990;

disp(sprintf('%s','Starting...'));
x_pre = zeros(1, N); x = zeros(1, N);
p_pre = zeros(1, N); p = zeros(1, N);
f_pre = zeros(1, N); f = zeros(1, N);

Q1 = 0; Q2 = 0; W = 0;
temperature_dis_pre = zeros(1, N); temperature_dis = zeros(1, N);
temperature_avg = temperature_dis_pre;

n = 0;
% Initiate Hamiltonian force
left_x = [0, x(1:(N-1))];
right_x = [x(2:N),0];
f1 = -k*(x-left_x) + a*(x-left_x).^2 - b*(x-left_x).^3;
f2 = -k*(x-right_x) - a*(x-right_x).^2 - b*(x-right_x).^3;
f = f1 + f2;

% Initiate Random force from thermal bath
f_bath1 = -gamma1*p(1) + sqrt(2*T1*gamma1/deltaT)*randn();
f_bath2 = -gamma2*p(N) + sqrt(2*T2*gamma2/deltaT)*randn();

% Initiate External driving force
f_ext = A*sin(omega*deltaT*n);

% Initiate Total force
f(1) = f(1) + f_bath1;
f(N) = f(N) + f_bath2;
f(nc) = f(nc) + f_ext;

% Initiate temperature
temperature_dis_pre = temperature_dis;
temperature_dis = p.^2/2;

count = 1;
for n = 0:num
    x_pre = x; 
    f_pre = f; 
    p_pre = p;

    % update the positions
    x = x_pre + p_pre*deltaT + f_pre*deltaT^2/2;

    % Hamiltonian force
    left_x = [0, x(1:(N-1))];
    right_x = [x(2:N),0];
    f1 = -k*(x-left_x) + a*(x-left_x).^2 - b*(x-left_x).^3;
    f2 = -k*(x-right_x) + a*(x-right_x).^2 - b*(x-right_x).^3;
    f = f1 + f2;

    % Random force from thermal bath
    f_bath1 = -gamma1*p(1) + sqrt(2*T1*gamma1/deltaT)*randn();
    f_bath2 = -gamma2*p(N) + sqrt(2*T2*gamma2/deltaT)*randn();

    % External driving force
    f_ext = A*sin(omega*deltaT*n);

    % Total force
    f(1) = f(1) + f_bath1;
    f(N) = f(N) + f_bath2;
    f(nc) = f(nc) + f_ext;

    %updating the momenta
    p = p_pre + (f + f_pre)*deltaT/2;

    % updating temperature
    temperature_dis_pre = temperature_dis;
    temperature_dis = p.^2/2;

    % updating Q1, Q2, W
    if n >= (3*num/4)
        temperature_avg = temperature_avg + temperature_dis;
        Q1 = Q1 + deltaT*p(1)*f_bath1;
        Q2 = Q2 + deltaT*p(N)*f_bath2;
        W = W + deltaT*p(nc)*f_ext;
    end 

    count = count + 1;
    if (count >= num/10)
        disp(sprintf('Calculating %0.1f%%...',(n/num)*100));
        count = 0;
    end
end

temperature_avg = temperature_avg/(num/4);
Q1 = Q1/(num*deltaT/4);
Q2 = Q2/(num*deltaT/4);
W = W/(num*deltaT/4);

toc

disp(sprintf('Q1 = %0.2f', Q1))
disp(sprintf('Q2 = %0.2f', Q2))
disp(sprintf('W = %0.2f', W))