CMU_path='/home/zhaoyi/mywork/tts/HTStry/Demo/CMU_STRAIGHT';
mean_dir='/home/zhaoyi/mywork/tts/DeepLearning/deep_str/id/average';
nc_dir='/home/zhaoyi/mywork/tts/DeepLearning/deep_str/id/nc';
for i=1:7
	prj_name=['cmu',num2str(i)];
	train_path=[CMU_path filesep prj_name filesep 'data' filesep 'DNN_DATA_ALL2' filesep 'TRAIN'];
	train_input_dir=[train_path filesep 'INPUT_ID'];
	train_target_dir=[train_path filesep 'TARGET'];
	nc_train=[nc_dir filesep 'cmu' num2str(i) filesep 'train_id2.nc'];
	train_nc_id(train_input_dir,train_target_dir,nc_train,mean_dir);

	val_path=[CMU_path filesep prj_name filesep 'data' filesep 'DNN_DATA_ALL2' filesep 'VAL'];
	val_input_dir=[val_path filesep 'INPUT_ID'];
	val_target_dir=[val_path filesep 'TARGET'];
	nc_val=[nc_dir filesep 'cmu' num2str(i) filesep 'val_id2.nc'];
	train_nc_id(val_input_dir,val_target_dir,nc_val,mean_dir);
	test_path=[CMU_path filesep prj_name filesep 'data' filesep 'DNN_DATA_ALL2' filesep 'TEST'];
	test_input_dir=[test_path filesep 'INPUT_ID'];
	test_target_dir=[test_path filesep 'TARGET'];
	nc_test=[nc_dir filesep 'cmu' num2str(i) filesep 'test_id2.nc'];
	train_nc_id(test_input_dir,test_target_dir,nc_test,mean_dir);

end
