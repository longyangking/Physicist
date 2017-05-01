function CalculateOpticalParameter(filename)
	content = importdata(filename);
	freq = 1e9*content(:,1); c = 3e8;
	s11 = content(:,2); setas11 = pi/180*content(:,3);
	s21 = content(:,4); setas21 = pi/180*content(:,5);
	Ka = ones(1,length(freq));
	for m = 1:length(freq)
		r = s11(m)*cos(setas11(m)) + i*s11(m)*sin(setas11(m));
		t = s21(m)*cos(setas21(m)) + i*s21(m)*sin(setas21(m));	
		Ka(m) =1/(2*pi)*acos((1-r^2+t^2)/(2*t));
	end
	figure(1); plot(real(Ka),freq/1e9,imag(Ka),freq/1e9);
	title('Dispersion'); legend('K real','K imag');
	xlabel('Bloch wave length/(2*pi/a)'); ylabel('Frequency/GHz');
end