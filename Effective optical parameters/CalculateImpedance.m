function CalculateOpticalParameter(filename)
	content = importdata(filename);
	freq = 1e9*content(:,1);
	s11 = content(:,2); setas11 = pi/180*content(:,3);
	s21 = content(:,4); setas21 = pi/180*content(:,5);
	z = zeros(1,length(freq));
	fprintf('Maybe error happened when d > %f mm\n',3e8/14/freq(length(freq))*1e3);
	for m = 1:length(freq)
		r = s11(m)*cos(setas11(m)) + i*s11(m)*sin(setas11(m));
		t = s21(m)*cos(setas21(m)) + i*s21(m)*sin(setas21(m));		
		z(m) = conj(sqrt(((1+r)^2-t^2)/((1-r)^2-t^2)));
	end
	figure(1); 
	plot(freq,real(z),freq,imag(z));
	title('Impedance'); legend('Real','Imag');
end