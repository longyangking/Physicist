N = 25; 
%Read Data
datas = cell(N,N);
for i = 1:N
	for j = 1:N
		filename = '';
		if i<10
			filename = strcat('0',int2str(i));
		else
			filename = int2str(i);
		end
		if j<10
			filename = strcat(filename,'0',int2str(j),'.csv');
		else
			filename = strcat(filename,int2str(j),'.csv');
		end
		content = importdata(filename);
		datas{i,j} = content.data;
	end
end
%Process Data
fs = length(datas{N,N}); freqs = datas{N,N}(:,1); E = cell(fs,1);
for f = 1:fs
	e = zeros(N,N);
	for i = 1:N
		for j = 1:N
			%e(i,j) = 10^(datas{i,j}(f,2)/20);
			e(i,j) = datas{i,j}(f,2);
		end
	end
	E{f} = e;
end
%Plot
fs = [1,50,100,150,200,250,300,350,400];
for f = 1:length(fs)
	figure(f);
	pcolor(E{fs(f)}); 
	shading interp; set(gca, 'CLim', [-100 -50]); colorbar; colormap jet;
	title(strcat('f = ',num2str(freqs(fs(f)))));
end
