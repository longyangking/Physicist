function Result = DeleteSpecificLineOfFile(filename,strings)
%   Delete the Lines that contains the specific string from the file,
%   delete the blank line defaultly.
% Arguments:
%   filename:  the file name you operate
%   strings :  an array that contains the string that you want to 
%              delete 
    try
        filein = fopen(filename);
        fileoutname =  strcat('_temp_result_',filename);
        fileout = fopen(fileoutname,'w');
        tline = fgetl(filein);
        while ischar(tline)
           num = 0;
           if isempty(tline)  %delete the blank line (default)
               num = 1;
           end
           for i = 1:length(strings)
                num = num  + length(strfind(tline, strings(i)));
           end
           if num == 0
              %fprintf(1,'%s\n',tline); %Just for debugging!
              fprintf(fileout,'%s\r\n',tline);
           end
           tline = fgetl(filein);
        end
        fclose(filein);
        fclose(fileout);
		delete(filename); %delete source
		movefile(fileoutname,filename,'f'); %rename the result
        Result = 1;
    catch err
		fprintf(1,'%s\n','Well,something wrong happen in the function DeleteSpecificLineOfFile');
        Result = 0;
    end
end

