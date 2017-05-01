function CalculateOpticalParameter(filename,d)
	content = importdata(filename);
	freq = 1e9*content(:,1); c = 3e8;
	s11 = content(:,2); setas11 = pi/180*content(:,3);
	s21 = content(:,4); setas21 = pi/180*content(:,5);
	eps = ones(1,length(freq)); mur = ones(1,length(freq));
	if freq(length(freq)) > (c/14/d)
		fprintf('Bad Accuracy! May occur Error from %f GHz\n',c/14/d/1e9);
	end
	for m = 1:length(freq)
		r = s11(m)*cos(setas11(m)) + i*s11(m)*sin(setas11(m));
		t = s21(m)*cos(setas21(m)) + i*s21(m)*sin(setas21(m));		
		k = 2*pi*freq(m)/c; 
		n = acos((1-(r^2-t^2))/(2*t))/(k*d);
		z = sqrt(((1+r)^2-t^2)/((1-r)^2-t^2));
		eps(m) = conj(n/z); mur(m) = conj(n*z);
	end
	figure(1); 
	plot(freq,real(eps),freq,imag(eps));
	title('Epsilon'); legend('Real','Imag');
	figure(2); 
	plot(freq,real(mur),freq,imag(mur));
	title('Mur'); legend('Real','Imag');
end