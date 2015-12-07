CMU_path='/home/zhaoyi/mywork/tts/HTStry/Demo/CMU_STRAIGHT';
for i=1:7
	prj_name=['cmu',num2str(i)];
	prj_dir=[CMU_path filesep prj_name];
	file_dir=[prj_dir '/data/DNN_DATA_ALL2'];
	file_input=[prj_dir '/data/DNN_DATA_ALL2/INPUT_label'];
    file_target=[prj_dir '/data/DNN_DATA_ALL2/TARGET']; 
    inputlist=dir([file_input filesep '*.input']);
    targetlist=dir([file_target filesep '*.target']);
    len_input_files=length(inputlist);
    len_target_files=length(targetlist);
    assert(len_input_files == len_target_files, 'the number of input_files is not equal to the number of target_files.');
    mkdir([file_dir filesep 'TRAIN']);
    mkdir([file_dir filesep 'TRAIN/INPUT']);
    mkdir([file_dir filesep 'TRAIN/TARGET']);
    mkdir([file_dir filesep 'VAL']);
    mkdir([file_dir filesep 'VAL/INPUT']);
    mkdir([file_dir filesep 'VAL/TARGET']);
    mkdir([file_dir filesep 'TEST']);
    mkdir([file_dir filesep 'TEST/INPUT']);
    mkdir([file_dir filesep 'TEST/TARGET']);
    s_train=151;
%e_train=200;
   	e_train=len_input_files;

   	s_val=51;
    e_val=150;

	 s_test=1;

    e_test=50;
    for n=s_train:e_train
    	copyfile([file_input filesep inputlist(n).name],[file_dir filesep 'TRAIN/INPUT' filesep inputlist(n).name]);   
    	copyfile([file_target filesep targetlist(n).name],[file_dir filesep 'TRAIN/TARGET' filesep targetlist(n).name]);
    end
    for n=s_test:e_test

    	copyfile([file_input filesep inputlist(n).name],[file_dir filesep 'TEST/INPUT' filesep inputlist(n).name]);   
    	copyfile([file_target filesep targetlist(n).name],[file_dir filesep 'TEST/TARGET' filesep targetlist(n).name]);
    end
    for n=s_val:e_val

    	copyfile([file_input filesep inputlist(n).name],[file_dir filesep 'VAL/INPUT' filesep inputlist(n).name]);   
    	copyfile([file_target filesep targetlist(n).name],[file_dir filesep 'VAL/TARGET' filesep targetlist(n).name]);
    end
end






