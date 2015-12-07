
function csv2wav(file_input,file_target,mean_file)
	inputlist=dir([file_input filesep '*.csv']);
	targetlist=dir([file_target filesep '*.target']);

    mean=importdata([mean_file filesep 'aver_output_mean']);
    std=importdata([mean_file filesep 'aver_output_std']);
	len_input_files=length(inputlist);
	len_target_files=length(targetlist);
	assert(len_input_files==len_target_files, 'len_input_files==len_target_files');

	mcd=0;
	f0_err=0;
	vu_err=0;

	wav_dir=[file_input filesep 'wav'];
	mkdir(wav_dir);

	for n=1:len_input_files
        basename=regexp(inputlist(n).name,'\.csv','split');
        basename=char(basename(1));
        str=sprintf('Analysing file: %s',basename);
        disp(str)
        data_input=csvread1([file_input filesep inputlist(n).name]);
        for j=1:size(data_input,1)
            data_input(j,:)=data_input(j,:).*(4*std)+mean;
        end
		mgc=data_input(:,2:26);
		lf0=data_input(:,79);
		f0=exp(lf0);
		vu=data_input(:,82);

		data_target=importdata([file_target filesep basename '.target']);
		mgc_target=data_target(:,2:26);
		lf0_target=data_target(:,79);
		f0_target=exp(lf0_target);
		vu_target=data_target(:,82);

		mcd=mcd+getMCD(mgc,mgc_target);
		f0_err=f0_err+getRMSE(lf0,lf0_target);
		vu_err=vu_err+getVU(vu,vu_target);

		
		wav_name=[wav_dir filesep basename '.wav'];
		getwav(wav_name,mgc,f0);
	end
		mcd=mcd/len_input_files;
		f0_err=f0_err/len_input_files;
		vu_err=vu_err/len_input_files;
		err=['MCD' num2str(mcd) 'f0_err' num2str(f0_err), 'vu_err', num2str(vu_err)];
		disp(err)
		fid=fopen([file_input filesep 'error.txt'],'w');
		fprintf(fid,'MCD %12.8f \r\n',mcd);
		fprintf(fid,'F0  %12.8f \r\n',f0_err);
		fprintf(fid,'vu  %12.8f \r\n', vu_err);
		fclose(fid);

		
		