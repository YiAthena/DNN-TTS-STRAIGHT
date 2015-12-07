CMU_path='/home/zhaoyi/mywork/tts/HTStry/Demo/CMU';
mean_path='/home/zhaoyi/mywork/tts/DeepLearning/net/net_common/average_voice/train_average';
INPUT_path='/home/zhaoyi/mywork/tts/DeepLearning/net/net_common/average_voice/val_average';
for i=1
	prj_name=['cmu',num2str(i)];
    input_dir=[INPUT_path filesep prj_name];
	target_dir=[CMU_path filesep prj_name];
	mean_input_dir=[mean_path filesep prj_name];
	file_input=[input_dir '/INPUT'];
    file_target=[target_dir '/data/DNN_DATA_ALL2/VAL/TARGET'];
   mean_output_dir=[target_dir '/data/DNN_DATA_ALL2/TRAIN']; 
   
    nc_filename=[input_dir filesep 'val.nc'];
    data_pre_nc1(file_input,file_target,nc_filename,mean_input_dir,mean_output_dir);
end
