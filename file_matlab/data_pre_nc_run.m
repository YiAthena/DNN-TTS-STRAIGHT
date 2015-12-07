CMU_path='/home/zhaoyi/mywork/tts/HTStry/Demo/CMU';
INPUT_path='/home/zhaoyi/mywork/tts/DeepLearning/net/net_common/average_voice';
for i=1:7
	prj_name=['cmu',num2str(i)];
    input_dir=[INPUT_path filesep prj_name];
	target_dir=[CMU_path filesep prj_name];
	
	file_input=[input_dir '/INPUT'];
    file_target=[target_dir '/data/DNN_DATA_ALL2/TRAIN/TARGET']; 
    nc_filename=[input_dir filesep 'train.nc'];
    data_pre_nc(file_input,file_target,nc_filename);
end