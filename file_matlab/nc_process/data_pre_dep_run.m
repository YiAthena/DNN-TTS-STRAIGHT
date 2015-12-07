CMU_path='/home/zhaoyi/mywork/tts/HTStry/Demo/CMU';
mean_dir='/home/zhaoyi/mywork/tts/DeepLearning/file_matlab/ID_write/ID_G';
train_input_path='/home/zhaoyi/mywork/tts/DeepLearning/net/id/average_voice/train_average/';
val_input_path='/home/zhaoyi/mywork/tts/DeepLearning/net/id/average_voice/val_average/';
test_input_path='/home/zhaoyi/mywork/tts/DeepLearning/net/id/average_voice/test_average/';

for i=1
	prj_name=['cmu',num2str(i)];
	
	train_input_dir=[train_input_path filesep prj_name filesep 'INPUT'];
	val_input_dir=[val_input_path filesep prj_name filesep 'INPUT'];
	test_input_dir=[test_input_path filesep prj_name filesep 'INPUT'];

	prj_dir=[CMU_path filesep prj_name];
    
	train_output_dir=[prj_dir '/data/DNN_DATA_ALL2/TRAIN/TARGET'];
 	test_output_dir=[prj_dir '/data/DNN_DATA_ALL2/TEST/TARGET'];
    val_output_dir=[prj_dir '/data/DNN_DATA_ALL2/VAL/TARGET'];

   nc_filename_train=[train_input_dir filesep 'train.nc'];
   nc_filename_test=[test_input_dir filesep 'test.nc'];
    nc_filename_val=[val_input_dir filesep 'val.nc'];
    data_pre_dep(train_input_dir,train_output_dir,nc_filename_train,mean_dir);
    data_pre_dep(val_input_dir,val_output_dir,nc_filename_val,mean_dir);
    data_pre_dep(test_input_dir,test_output_dir,nc_filename_test,mean_dir);
end
