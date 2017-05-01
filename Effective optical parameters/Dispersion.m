function Dispersion(filename,L)
	content = importdata(filename);
	freq = 1e9*content(:,1); c = 3e8;
	s11 = content(:,2); setas11 = pi/180*content(:,3);
	s21 = content(:,4); setas21 = pi/180*content(:,5);
	eps = ones(1,length(freq)); mur = ones(1,length(freq));
	if freq(length(freq)) > (c/14/L)
		fprintf('Bad Accuracy! May occur Error from %f GHz\n',c/14/L/1e9);
	end
	r = s11.*cos(setas11) + i*s11.*sin(setas11);
	t = s21.*cos(setas21) + i*s21.*sin(setas21);
	k = 2*pi*freq/c; 	
	n = acos((1-(r.^2-t.^2))./(2*t))./(k*L);
	k = n.*k;
	figure
	%plot(real(k),freq,imag(k),freq,'LineWidth',2);  
	%legend('Re Wavevector','Im Wavevector');
	plot(real(k),freq/1e9,'LineWidth',2);  
	title('Dispersion Basic');
	xlabel('Wave vector (1/m)'); ylabel('Frequency (GHz)');
	figure
	plot(real(k),freq/1e9,imag(k),freq/1e9,'LineWidth',2);  
	legend('Re Wavevector','Im Wavevector');
	title('Dispersion');
	xlabel('Wave vector (1/m)'); ylabel('Frequency (GHz)');
end