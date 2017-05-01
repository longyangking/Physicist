%{
This file contains the code that calculate the electrical field distribution of point source.
Reminder:
  1. It don't contain Perfect Match Layer (PML).
  2. The backgroud is set as Air.
%}

pointsX = 100; pointsY = 100;  %The mesh grid of the calculation field
%FDTD calculation field
Dz = zeros(pointsX,pointsY); Ez = Dz; Hx = Dz; Hy = Dz;
c = 3e8;

f0 = 10e9; lambda0 = c/f0;
dx = lambda0/10; dy = dx; dt = dx/c/2;

Nt = 100; %Nt: the mount of time steps
sourceX = 50; sourceY = 50; % The position of source in mesh grid
for n = 1:Nt
    for i = 2:pointsX
        for j = 2:pointsY
            Dz(i,j) = Dz(i,j) + 0.5*(Hy(i,j) - Hy(i-1,j) - Hx(i,j) + Hx(i,j-1));
            Ez(i,j) = Dz(i,j);
        end
    end
    Ez(sourceX,sourceY) = exp(-0.5*(n-50)^2/20^2);
    for i = 1:pointsX-1
        for j = 1:pointsY-1
            Hx(i,j) = Hx(i,j) + 0.5*(Ez(i,j) - Ez(i,j+1));
            Hy(i,j) = Hy(i,j) + 0.5*(Ez(i+1,j) - Ez(i,j));
        end
    end
end

%Plot result
pcolor(Ez); 
shading interp; 
%set(gca, 'CLim', [-1 1]); 
colorbar; colormap jet;
title('FDTD Point Source');