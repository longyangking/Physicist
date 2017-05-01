function Result = PlotDispersion(filename,strings)
    try
		DeleteSpecificLineOfFile(filename,strings);
        [phases,freqs] = textread(filename,'%f %f');
		figure(1);
		plot(phases,freqs,'.'); title('Dispersion Relationship');
		xlabel('Phase Shift'); ylabel('Frequency/Norm Unit');
    catch err
		fprintf(1,'%s\n','Well,something wrong happen in Plot');
    end
end