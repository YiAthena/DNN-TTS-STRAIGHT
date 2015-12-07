CMU_path='/home/zhaoyi/mywork/tts/HTStry/Demo/CMU_STRAIGHT';

for i=1:7
	prj_name=['cmu',num2str(i)];
	train_path=[CMU_path filesep prj_name filesep 'data' filesep 'DNN_DATA_ALL2' filesep 'TRAIN'];
	train_input_dir=[train_path filesep 'INPUT'];
	train_target_dir=[train_path filesep 'TARGET'];
	nc_train=[train_path filesep 'train.nc'];
	train_nc(train_input_dir,train_target_dir,nc_train);
	
end
    
