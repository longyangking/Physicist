files = dir('*.txt');
num = length(files);
regstr = '-?[0-9]+.?[0-9]+';

fprintf('Start to load data...\n');
data = [];
pos = zeros(num,3);
for i = 1:num
    [startIndex,endIndex] = regexp(files(i).name,regstr);
    for index = 1:3
        pos(i,index) = str2num(files(i).name(startIndex(index):endIndex(index)));
    end
    content = importdata(files(i).name);
    data(i,:,:) = content.data;
    
    if mod(i,floor(num/10))==0
        fprintf('Load data... %.1f%%\n',i/num*100);
    end
end

fprintf('Start to select points...\n');
frequencypoint = 500;
Xnum = 30; Ynum = 30;  AA1 = 10.866; D = 2.6;
xv = reshape(pos(:,1),Xnum,Ynum); yv = reshape(pos(:,2),Xnum,Ynum);
X0 = 3*AA1*10+AA1*2; Y0 = -sqrt(3)*AA1*2;
fprintf('Center of Unit Cell {%.2f,%.2f}\n',X0,Y0);
x = xv - X0; y = yv - Y0;

out1 = (y < sqrt(3)/2*AA1 + D/2) & (y > -(sqrt(3)/2*AA1 + D/2));
out2 = (y < -sqrt(3)*x + sqrt(3)*(AA1+D/sqrt(3))) & (y > -sqrt(3)*x - sqrt(3)*(AA1+D/sqrt(3)));
out3 = (y < sqrt(3)*x + sqrt(3)*(AA1+D/sqrt(3))) & (y > sqrt(3)*x - sqrt(3)*(AA1+D/sqrt(3)));

in1 = (y > sqrt(3)/2*AA1 - D/2) | (y < -sqrt(3)/2*AA1 + D/2);
in2 = (y > -sqrt(3)*x + sqrt(3)*(AA1-D/sqrt(3))) | (y < -sqrt(3)*x - sqrt(3)*(AA1-D/sqrt(3)));
in3 = (y > sqrt(3)*x + sqrt(3)*(AA1-D/sqrt(3))) | (y < sqrt(3)*x - sqrt(3)*(AA1-D/sqrt(3)));

mask =  out1 & out2 & out3 & (in1 | in2 | in3);

figure(1);
phase = reshape(pi/180*data(:,frequencypoint,2),Xnum,Ynum);
phase(~mask) = 0;
pcolor(x,y,phase); colormap('jet'); drawnow;

fprintf('Start to compute...\n');
[theta,r] = cart2pol(x,y);
theta(~mask) = 0;

%normphase = sqrt(abs(sum(sum(exp(1j*phase(mask))))));
%normp = sqrt(abs(sum(sum(exp(1j*theta(mask))))));
%normd = sqrt(abs(sum(sum(exp(2j*theta(mask))))));
norm0 = sqrt(abs(sum(sum(exp(1j)*mask))));
p1 = sum(sum(exp(1j*(-theta(mask)-phase(mask)))))/norm0^2;
p2 = sum(sum(exp(1j*(theta(mask)-phase(mask)))))/norm0^2;
d1 = sum(sum(exp(1j*(-2*theta(mask)-phase(mask)))))/norm0^2;
d2 = sum(sum(exp(1j*(2*theta(mask)-phase(mask)))))/norm0^2;

figure(2);
title('Ratio');
bar(abs([p1,p2,d1,d2]).^2);
set(gca,'xticklabel',{'P_{+}','P_{-}','D_{+}','D_{-}'});

figure(3);
title('Phase');
bar(angle([p1,p2,d1,d2]));
set(gca,'xticklabel',{'P_{+}','P_{-}','D_{+}','D_{-}'});
