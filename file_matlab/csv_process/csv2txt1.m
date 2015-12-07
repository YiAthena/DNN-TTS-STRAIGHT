function csv2txt1(file_input,file_output,mean_file)
inputlist=dir([file_input filesep '*.csv']);
mean=importdata([mean_file filesep 'output_mean.mat']);
std=importdata([mean_file filesep 'output_std.mat']);
len_input_files=length(inputlist);
%mgc_range=[1,26];
%f0_range=27;
%bap_range=[28,53];
%VU_range=54;
mgc_file=[file_output filesep 'mgc'];
lf0_file=[file_output filesep 'lf0'];
bap_file=[file_output filesep 'bap'];
vu_file=[file_output filesep 'vu'];
mkdir(mgc_file);
mkdir(lf0_file);
mkdir(bap_file);
mkdir(vu_file);
for n=1:len_input_files
        basename=regexp(inputlist(n).name,'\.csv','split');
        basename=char(basename(1));
        str=sprintf('Analysing file: %s',basename);
        disp(str)
        data_input=csvread1([file_input filesep inputlist(n).name]);
        for j=1:size(data_input,1)
            data_output(j,:)=data_input(j,:).*(4*std)+mean;
        end
        mgc=data_output(:,1:26)';
		lf0=data_output(:,27)';
		bap=data_output(:,28:53)';
		vu=data_output(:,54)';
      
        % for j=1:length(lf0)
        % 	if(0.4>=vu(j))
        % 		lf0(j)=-1.0e+10;
        % 	end
        % end


		mgc_name=[file_output filesep 'mgc' filesep basename '.mgc'];
		lf0_name=[file_output filesep 'lf0' filesep basename '.lf0'];
		bap_name=[file_output filesep 'bap' filesep basename '.bap'];
		vu_name=[file_output filesep 'vu' filesep basename '.vu'];


		fid=fopen(mgc_name,'w');
		fwrite(fid,mgc,'float');
		fclose(fid);
		fid=fopen(lf0_name,'w');
		fwrite(fid,lf0,'float');
		fclose(fid);
		fid=fopen(bap_name,'w');
		fwrite(fid,bap,'float');
		fclose(fid);
		fid=fopen(vu_name,'w');
		fwrite(fid,vu,'float');
		fclose(fid);
		%dlmwrite(out_name,data_input);
		
end