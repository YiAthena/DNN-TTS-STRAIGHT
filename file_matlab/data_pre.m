% firstly estimate
%% pre_data: create netcdf file from input features and labels
function data_pre(file_input,file_target,nc_train,nc_val,nc_test)
    inputlist=dir([file_input filesep '*.input']);
    targetlist=dir([file_target filesep '*.target']);
    len_input_files=length(inputlist);
    len_target_files=length(targetlist);
    assert(len_input_files == len_target_files, 'the number of input_files is not equal to the number of target_files.');
  
    
s_train=151;
    
   	e_train=len_input_files;
   
   	numSeqs_train = e_train - s_train + 1;
    numTimesteps_train = 0;
    inputPattSize_train = 0;
    targetPattSize_train = 0;
    maxSeqTagLength_train = 0;

    
    s_val=51;

    e_val=150;
    numSeqs_val = e_val - s_val + 1;
    numTimesteps_val = 0;
    inputPattSize_val = 0;
    targetPattSize_val = 0;
    maxSeqTagLength_val = 0;

    
    s_test=1;

    e_test=50;
    numSeqs_test = e_test - s_test + 1;
    numTimesteps_test = 0;
    inputPattSize_test = 0;
    targetPattSize_test = 0;
    maxSeqTagLength_test = 0;

    input_msum = [];
    output_msum = [];

%for n=1:50
for n=s_test:e_test
        basename=regexp(inputlist(n).name,'\.input','split');
        basename=char(basename(1));
        str=sprintf('Reading file: %s',basename);
        disp(str)
        %data_input=importdata([basename '.input']);
        %data_input=importdata(inputlist(n).name);
        data_input=load([file_input filesep basename '.input']);
        %data_input
        max_abs_in=max(abs(data_input));
        if(max_abs_in>9999)
            str=sprintf('input data wrong in %s', find(max_abs_in));
            disp(str)
        end
        data_target=importdata([file_target filesep basename '.target']);
        assert(size(data_input,1)==size(data_target,1),'frame error');
        %data_target=getdata([file_target filesep basename '.target']);
        %data_target=getdata(targetlist(n).name);
        max_abs_tar=max(abs(data_target));
        if(max_abs_tar>9999)
            str=sprintf('target data wrong in %s', find(max_abs_tar));
            disp(str)
        end

        maxSeqTagLength_test = max(maxSeqTagLength_test,length(basename));
        numTimesteps_test = numTimesteps_test + size(data_input,1);
        inputPattSize_test = size(data_input,2);
        targetPattSize_test = size(data_target,2);
    end

%    for n=51:len_input_files
for n=s_val:e_train
        basename=regexp(inputlist(n).name,'\.input','split');
        basename=char(basename(1));
        str=sprintf('Reading file: %s',basename);
        disp(str)
        %data_input=importdata([basename '.input']);
        data_input=importdata([file_input filesep basename '.input']);
        max_abs_in=max(abs(data_input));
        if(max_abs_in>9999)
            str=sprintf('input data wrong in %s', find(max_abs_in));
            disp(str)
        end
        data_target=importdata([file_target filesep basename '.target']);
        assert(size(data_input,1)==size(data_target,1),'frame error');
        %data_target=getdata([file_target filesep basename '.target']);
        %data_target=getdata(targetlist(n).name);
        max_abs_tar=max(abs(data_target));
        if(max_abs_tar>9999)
            str=sprintf('target data wrong in %s', find(max_abs_tar));
            disp(str)
        end

        input_msum = [input_msum;data_input];
        output_msum = [output_msum;data_target];

        if (n<151)
            maxSeqTagLength_val = max(maxSeqTagLength_val,length(basename));
            numTimesteps_val = numTimesteps_val + size(data_input,1);
            inputPattSize_val = size(data_input,2);
            targetPattSize_val = size(data_target,2);
        else
            maxSeqTagLength_train = max(maxSeqTagLength_train,length(basename));
            numTimesteps_train = numTimesteps_train + size(data_input,1);
            inputPattSize_train = size(data_input,2);
            targetPattSize_train = size(data_target,2);
        end
    end


    input_mean = mean(input_msum,1);
    input_std = std(input_msum,0,1);
    input_std(input_std==0)=0.01;
    output_mean = mean(output_msum,1);
    output_std = std(output_msum,0,1);
    output_std(output_std==0)=0.01;
    save([file_input filesep 'input_mean'],'input_mean');
    save([file_input filesep 'input_std'],'input_std');
    save([file_target filesep 'output_mean'],'output_mean');
    save([file_target filesep 'output_std'],'output_std');

 mk_nc_file(file_input,file_target,nc_test,s_test,e_test,numSeqs_test,numTimesteps_test,inputPattSize_test,targetPattSize_test,maxSeqTagLength_test);
    mk_nc_file(file_input,file_target,nc_train,s_train,e_train,numSeqs_train,numTimesteps_train,inputPattSize_train,targetPattSize_train,maxSeqTagLength_train);
    mk_nc_file(file_input,file_target,nc_val,s_val,e_val,numSeqs_val,numTimesteps_val,inputPattSize_val,targetPattSize_val,maxSeqTagLength_val);

end