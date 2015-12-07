function csv2txt(file_input,file_output,mean_file)
	inputlist=dir([file_input filesep '*.csv']);
    mean=importdata([mean_file filesep 'aver_output_mean']);
    std=importdata([mean_file filesep 'aver_output_std']);
	len_input_files=length(inputlist);
	for n=1:len_input_files
        basename=regexp(inputlist(n).name,'\.csv','split');
        basename=char(basename(1));
        str=sprintf('Analysing file: %s',basename);
        disp(str)
        data_input=csvread1([file_input filesep inputlist(n).name]);
        for j=1:size(data_input,1)
            data_output(j,:)=data_input(j,:).*(4*std)+mean;
        end
		out_name=[file_output filesep basename '.input'];
		dlmwrite(out_name,data_input);
		
	end
